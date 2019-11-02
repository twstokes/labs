import React, { Component } from "react";
import P5Wrapper from "./p5/wrapper";
import sketch from "./sketch";

import "./App.css";

class App extends Component {
  render() {
    return (
      <div className="App">
        <P5Wrapper sketch={sketch} />
      </div>
    );
  }
}

export default App;
