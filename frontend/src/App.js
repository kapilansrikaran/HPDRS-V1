import React from 'react';
import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import SignInSide from './components/login/SignInSide';
import SignUp from './components/register/SignUp';
//import Dashboard from './components/Dashboard/Dashboard';
//import Dashboard from './components/Dashboard';
//import Blog from './components/Homepage/Blog';
import Dashboard from './components/Dashboard/Dashboard';
//import Main from './components/Homepage/Main';
import Blog from './components/Homepage/Blog';
import Home from './home/home';
import StudentDashboard from './studentdashboard/Studentdashboard';
function App() {
  return (
    <div className="App">
      <Router>
        <header className="App-header">
          {/* Your header content goes here */}
        </header>

        <Routes>

          <Route path="/signin" element={<SignInSide />} />
          <Route path="/signup" element={<SignUp />} />
          <Route path="/dashboard" element={<Home />} />
          <Route path="/studentdashboard" element={<StudentDashboard />} />


        </Routes>
      </Router>
    </div>
  );
}

export default App;
