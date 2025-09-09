# Dr. Mario in MIPS Assembly
![Quiz90](images/drmario_and_viruses.png)
This README will go through my progress and the features I chose to implement.
## Game Specifications
- 1x1 unit width/height (pixels)
- 32x32 display width/height (pixels)
- Base Address for Display: 0x10008000 ($gp)
### How to play:
- w: Rotate capsule 90 degrees counter-clockwise. a: Move capsule left.
- s: Move capsule down.
- d: Move capsule right.
- p: Pause and unpause the game.
- y: start a new game from the game over screen. q: quit the game.
## Features/Implementation
### Drawing the map
- Stored objects to be drawn in .data.
- Each object started with the following in order: 4 bytes for the width, 4 bytes for the height, 4 bytes for the starting position on the bitmap display (in pixels).
- The rest of the object was an array in order of colours that make up the image – left to right, top to bottom. That way, the same function to draw an image onto the bitmap display could be reused for different images.
### Movement + Wall Collision Detection
- Before rotating the capsule upon pressing ’w’, and before shifting the capsule left or right, made sure that the capsule could be moved without hitting a wall. If it couldn’t, nothing happened - return to game loop.
- To make the capsule move, it was erased (replaced with black) from the bitmap display and the two pixels below the capsule were replaced with the capsule colours instead.
### Capsule + Floor Collision Detection
- When the player presses ’s’ to move the capsule down, if it cannot move down, the capsule colours are stored into the array for play area data, and the addresses for each half of the capsule are stored into a CAPSULES array so that it can be known which blocks belong to the same capsule (each group of 8 bytes/two blocks in the CAPSULES array is one capsule).
- When any collision occurs, horizontal and vertical line checks of 4 or more begin. If they exist, they are deleted (replaced with black), and the corresponding addresses in the CAPSULES array replaced with 0.
- This way, capsules that are entirely unsupported must fall, and any capsules missing one half (so only one half remaining) have that half drop as well.
- The first 4 spots (16 bytes) in the CAPSULES array are reserved for the viruses, as those are single blocks, yet must not fall even with empty space below them.
### Additional Features
- Gravity: each second that passes will automatically move the capsule down one row. Speed of gravity gradually increases over time.
  - On each sleep call, a counter increments by 16 milliseconds. When this counter exceeds the set limit, the current capsule falls by one pixel, and the set limit decreases slightly (so it is reached slightly faster next time).
- Sound effects for different conditions (rotating, moving, placing, completing 4+, blocked action, game over, and new game).
- Game Over screen + option to try again
![image](/readme_assets/game_over_screen.png)
- Pause functionality
![image](/readme_assets/pause.png)
- Harder levels that trigger after the player eliminates all of the viruses in the current level.
  - Increased speed of gravity for each level: When it is detected that all 4 viruses are set to 0/black in internal data, the glass bottle is reset to black and the set limit for the millisecond counter to reach before dropping the capsule by 1 pixel is reduced dramatically.
- Each virus image disappears as the viruses of that colour are eliminated from the playing field.
  - Virus colours are stored into a VIRUS DATA array at the same time that they are generated and stored into the first 16 bytes of the CAPSULES array. As they are stored in the same order, when it is found that the capsules array has a virus at a certain location set to 0/black, the same virus can be set to black in the VIRUS DATA array.
![image](/readme_assets/viruses_gone.png)
