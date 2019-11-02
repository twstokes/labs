import Circle from "./circle";

export default function sketch(p) {
  const circleCount = 8;
  const speed = 0.001;
  const boxSize = 600 / circleCount;

  const width = boxSize * (circleCount + 1);
  const height = boxSize * (circleCount + 1);

  let circleArray = Array(circleCount)
    .fill()
    .map((_, i) => new Circle(p, boxSize, (i + 1) * speed));

  p.setup = function() {
    p.createCanvas(width, height);
    p.background(0);
    p.colorMode(p.HSB, 100);
  };

  p.draw = function() {
    // entire canvas
    p.translate(boxSize * 1.5, boxSize / 2);
    p.noStroke();

    // clear everything if the first circle does a revolution
    if (circleArray[0].position >= 1) {
      circleArray[0].resetPosition();
      p.background(0);
    }

    p.push();
    // top row
    for (let circle of circleArray) {
      circle.tick();
      circle.draw();
      p.translate(boxSize, 0);
    }
    p.pop();

    // move down a block to start the side row
    p.translate(-1 * boxSize, 0);

    p.push();
    // side row
    for (let circle of circleArray) {
      p.translate(0, boxSize);
      circle.draw();
    }
    p.pop();

    // move over to the right to start the grid
    p.translate(boxSize, 0);
    for (let leftCircle of circleArray) {
      p.translate(0, boxSize);
      p.push();
      for (let topCircle of circleArray) {
        leftCircle.combineWith(topCircle);
        p.translate(boxSize, 0);
      }
      p.pop();
    }
  };
}
