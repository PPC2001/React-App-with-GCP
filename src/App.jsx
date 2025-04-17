import { useState } from 'react'
import './App.css'

function App() {
  const [count, setCount] = useState(0)
  return (
    <>
      <div className="App">
      <h1>Welcome to My Simple React App 🚀</h1>
      <p>Click count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Click Me</button>
    </div>
    </>
  )
}

export default App
