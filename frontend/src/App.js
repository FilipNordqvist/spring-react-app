import { useEffect, useState } from "react";


const API_BASE_URL = process.env.REACT_APP_API_URL || "http://localhost:8080";

function App() {
  const [title, setTitle] = useState("...");
  const [page, setPage] = useState("home");
  const [recipe, setRecipe] = useState(null);
  const [city, setCity] = useState("");
  const [weather, setWeather] = useState(null);


  useEffect(() => {
    fetch(`${API_BASE_URL}/home`)
      .then((response) => response.text())
      .then((text) => setTitle(text))
      .catch((error) => console.log("Error fetching", error));
  }, []);

   const fetchRecipe = () => {
     fetch(`${API_BASE_URL}/recipe`)
       .then((response) => response.json())
       .then((data) => setRecipe(data.meals[0]))
       .catch((error) => console.log("Error:", error));
   };

 const fetchWeather = () => {
   fetch(`${API_BASE_URL}/weather?city=${city}`)
     .then((response) => response.json())
     .then((data) => {
       console.log(data); // Kolla vad du får
       setWeather(data);
     })
     .catch((error) => console.log("Error:", error));
 };



  return (
    <div style={{ textAlign: "center", marginTop: "100px" }}>
      <h1>React + {title}</h1>

      {page === "home" && (
        <div>
          <button onClick={() => setPage("weather")}>🌤️ Väder</button>
          <button
            onClick={() => setPage("recipe")}
            style={{ marginLeft: "20px" }}
          >
            🍽️ Slumpa recept
          </button>
        </div>
      )}

      {page === "weather" && (
        <div>
          <h2>Väder</h2>
          <input
            placeholder="Ange stad..."
            value={city}
            onChange={(e) => setCity(e.target.value)}
          />
          <button onClick={fetchWeather}>Sök</button>

          {weather && weather.main && (
            <div>
              <p>🏙️ Stad: {weather.name}</p>
              <p>🌡️ Temp: {weather.main.temp}°C</p>
            </div>
          )}

          <button onClick={() => setPage("home")}>⬅️ Tillbaka</button>
        </div>
      )}

      {page === "recipe" && (
        <div>
          <h2>Slumpa recept</h2>
          <button onClick={fetchRecipe}>🎲 Slumpa!</button>

          {recipe && (
            <div>
              <h3>{recipe.strMeal}</h3>
              <img src={recipe.strMealThumb} alt={recipe.strMeal} width="200" />
              <p>
                🍴 Länk:{" "}
                <a href={recipe.strSource} target="_blank" rel="noreferrer">
                  Visa recept
                </a>
              </p>
            </div>
          )}

          <button onClick={() => setPage("home")}>⬅️ Tillbaka</button>
        </div>
      )}
    </div>
  );
}

export default App;
