import {useEffect, useState} from 'react'


function App() {
  const [title, setTitle] = useState('Default value');

useEffect(()=> {
  fetch("http://localhost:8080/home").then(response => response.text())
  .then(text=>setTitle(text))
  .catch(error=>console.log("Error fetching", error))
},[])


  return (
    <div>
      <h1>React + {title} </h1>
    </div>
  );
}

export default App;
