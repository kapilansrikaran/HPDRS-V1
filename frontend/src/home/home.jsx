import React from "react";
import "./home.css";
import { Link } from "react-router-dom";

function Home() {
  return (
    <div className="App">
      <div className="paragraph">
        <p>welcome to the hotel management system</p>
      </div>
      <div className="buttons">
        <Link to="/signin">
          <button
            type="submit"
            fullWidth
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
          >
            Sign In
          </button>
        </Link>
        <Link to="/signup">
          <button
            type="submit"
            fullWidth
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
          >
            sign Up
          </button>
        </Link>
      </div>
    </div>
  );
}

export default Home;
