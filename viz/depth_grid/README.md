# Depth Grid

This is not an original piece. This is a clone of [https://cacheflowe.com/art/digital/deepflat](https://cacheflowe.com/art/digital/deepflat) because I was nerd sniped by how cool it was, and had to figure it out. 

The magic sauce for this one is the `ortho()` camera and `UV` texture mapping from the perspective of the screen.

### What's happening: ###

Even though a cube may be rotated or in the distance, the texture (a grid) is painted proportionatly to a 2D mapping of the screen. The user first sees a perfect grid (only imperfect if not enough cubes were generated), and then discovers that this is an illusion once the camera is rotated.

### Gotchas: ###
- The cubes (and the single shape they are all children of) are best generated before the `draw()` sequence. Before I did this, a perfect grid would always show regardless of the camera orientation.
- I couldn't figure out how to do this with normalized verteces (e.g. 1, 1, 1). They would paint correctly from preceding `scale()` calls, but this would be cumbersome to keep track of for each cube. This spawned the `addVertex` function to take the values returned from `model` and `screen` calls.
