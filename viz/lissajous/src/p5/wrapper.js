import React, { Component } from "react";
import p5 from "p5";

class P5Wrapper extends Component {
  componentDidMount() {
    this.canvas = new p5(this.props.sketch, this.wrapper);
  }

  render() {
    return <div ref={wrapper => (this.wrapper = wrapper)} />;
  }
}

export default P5Wrapper;
