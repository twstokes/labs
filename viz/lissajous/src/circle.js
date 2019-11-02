export default class Circle {
  constructor(p, boxSize, rate) {
    this._p = p;
    this._boxSize = boxSize;
    this._rate = rate;
    this._radius = boxSize / 3;

    this._position = 0;
    this.x = this.y = this.prevX = this.prevY = null;
    this._hue = rate * 10000;
  }

  get position() {
    return this._position;
  }

  resetPosition() {
    this._position = 0;
  }

  tick() {
    this.prevX = this.x;
    this.prevY = this.y;
    this._position += this._rate;

    let c = this._position * 2 * this._p.PI;
    this.x = this._p.cos(c) * this._radius;
    this.y = this._p.sin(c) * this._radius;
  }

  // "clear" the previous buffer by drawing over it
  _clear() {
    let p = this._p;

    p.noStroke();
    p.fill(0);
    p.rectMode(p.CENTER);
    p.rect(0, 0, this._boxSize, this._boxSize);
  }

  // no mutations allowed since we call multiple times!
  draw() {
    let p = this._p;

    this._clear();
    p.noFill();
    p.circle(0, 0, this._boxSize / 2);
    p.stroke(this._hue, 100, 100);
    p.strokeWeight(2);
    p.circle(0, 0, this._radius);
    p.fill(80, 0, 0);
    // unit circle position of small circle
    p.circle(this.x, this.y, 4);
  }

  combineWith(c) {
    let x = c.x;
    let y = this.y;
    let prevX = c.prevX || x;
    let prevY = this.prevY || y;
    let p = this._p;

    p.push();
    p.blendMode(p.BLEND);
    p.stroke(this._hue, 70, 100);
    p.line(x, y, prevX, prevY);
    p.stroke(c._hue, 70, 100);
    p.line(x, y, prevX, prevY);
    p.pop();
  }
}
