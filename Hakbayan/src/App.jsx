import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import Auth from './auth/Auth'


function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <Auth />
    </>
  )
}

export default App
