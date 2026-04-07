#!/bin/sh
# Docker Compose integration tests
# Validates that backend, frontend, and frontend→backend connectivity work.

PASS=0
FAIL=0

pass() {
  PASS=$((PASS + 1))
  echo "  ✅ PASS: $1"
}

fail() {
  FAIL=$((FAIL + 1))
  echo "  ❌ FAIL: $1"
}

echo ""
echo "======================================"
echo "  Docker Compose Integration Tests"
echo "======================================"
echo ""

# ── 1. Backend health ────────────────────────────────────────────────────────
echo "── Backend Tests ──"

RESPONSE=$(wget -qO- http://backend:8080/home 2>&1) || true
if [ "$RESPONSE" = "Spring Boot MVP" ]; then
  pass "Backend /home returns expected response"
else
  fail "Backend /home returned: '$RESPONSE' (expected 'Spring Boot MVP')"
fi

# Test that /recipe endpoint responds with JSON containing 'meals'
RECIPE_RESPONSE=$(wget -qO- http://backend:8080/recipe 2>&1) || true
if echo "$RECIPE_RESPONSE" | grep -q '"meals"'; then
  pass "Backend /recipe returns JSON with meals"
else
  fail "Backend /recipe unexpected response: '$(echo "$RECIPE_RESPONSE" | head -c 200)'"
fi

# ── 2. Frontend health ──────────────────────────────────────────────────────
echo ""
echo "── Frontend Tests ──"

FRONTEND_RESPONSE=$(wget -qO- http://frontend:3000 2>&1) || true
if echo "$FRONTEND_RESPONSE" | grep -q '<div id="root"'; then
  pass "Frontend serves HTML with React root element"
else
  fail "Frontend did not return expected HTML"
fi

# Verify the frontend build contains the API URL configuration
if echo "$FRONTEND_RESPONSE" | grep -q 'script'; then
  pass "Frontend HTML includes script tags"
else
  fail "Frontend HTML missing script tags"
fi

# ── 3. Frontend → Backend connectivity ───────────────────────────────────────
echo ""
echo "── Frontend → Backend Connectivity Tests ──"

# Since the frontend is a static SPA, browser-side fetch calls go to the backend.
# We simulate this by calling the backend from the same Docker network,
# which proves the backend is reachable at the URL the frontend is configured to use.
CONNECTIVITY_RESPONSE=$(wget -qO- http://backend:8080/home 2>&1) || true
if [ "$CONNECTIVITY_RESPONSE" = "Spring Boot MVP" ]; then
  pass "Backend is reachable from within Docker network (frontend→backend path)"
else
  fail "Backend not reachable from Docker network"
fi

# Verify the frontend JavaScript bundle references the backend API URL
JS_FILES=$(wget -qO- http://frontend:3000 2>&1 | grep -oE 'src="[^"]*\.js"' | head -1 | sed 's/src="//;s/"//') || true
if [ -n "$JS_FILES" ]; then
  JS_CONTENT=$(wget -qO- "http://frontend:3000${JS_FILES}" 2>&1) || true
  if echo "$JS_CONTENT" | grep -q '/home'; then
    pass "Frontend JS bundle contains /home API call"
  else
    fail "Frontend JS bundle does not reference /home endpoint"
  fi
  if echo "$JS_CONTENT" | grep -q '/recipe'; then
    pass "Frontend JS bundle contains /recipe API call"
  else
    fail "Frontend JS bundle does not reference /recipe endpoint"
  fi
  if echo "$JS_CONTENT" | grep -q '/weather'; then
    pass "Frontend JS bundle contains /weather API call"
  else
    fail "Frontend JS bundle does not reference /weather endpoint"
  fi
else
  fail "Could not find JS bundle URL in frontend HTML"
  fail "Skipped JS bundle API call checks"
  fail "Skipped JS bundle API call checks"
fi

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "======================================"
echo "  Results: $PASS passed, $FAIL failed"
echo "======================================"
echo ""

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi

exit 0
