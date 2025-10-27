# Mood Games

## Data
Started: 13.10.2025
Textures from:
	Own Drawings,
Goal:
	An app on a tablet to messure the mood of the employees and improve it. 
	This works by collecting a reason like rain and play a minigame about it.

## Tasks
### Homework
#### Improve the Textures for:
- [x] Smileys (Thicker outline usw.)
- [x] Icons for the games
- [ ] Map (**side view** Rainy meadows, **top down** whide office room, **side view** jump and run office)
- [ ] Enemies (Rain, Stars, Cars, Bugs)
#### Search or create Textures for:
- [x] Smileys
- [x] Icons for the games
- [ ] Map (**side view** Rainy meadows, **top down** whide office room, **side view** jump and run office)
- [x] Enemies (Rain, Stars, Cars, Bugs)

### Games
- [x] Rain
	Move left and right to avoid getting hit
- [x] To many bugs
	Bugs will hunt you and you have to destroy them.
- [ ] No Desire To Work
	Escape the office.
- [ ] Traffic
	Drive fast in a road and overtake the other cars.

### Needed Objects
- [x] Falling Object
	Avoid to not die
	has a velocity and collision
	variable is the texture and collision shape
- [x] Following Object
	Allways heads the player and moves forward
	Has a variable health and speed status and Sprite.
	lightweight directional following.
- [x] Player
	Moves with gravity.
	Can jump and accelerate to the side.
	Controll buttons (left, right, up, down, shoot, swing, quit)
- [ ] Car Player
	No gravity
	Can Accelerate to the top, bottom and to the sides
	Deaccelerates allways
	Controll buttons (left, right, up, down, quit)
- [ ] Map
	Has a Tilemap and Collisionshapes on the Tiles
- [x] Controll Buttons
	Toggle able left, right, up, down, shoot, swing, quit

### Needed Scenes
- [x] Start Menu with:
	Mood selection
	< Reason selection
	< < Game start Mechanism
	Stat view today
	All stats tab
- [x] Game Over Menu with:
	Score and highscore view
	After mood selection
	Replay and home menu button
- [ ] Games with:
	Game mechanics
	Score view
	Player

## Doing now
- [ ] Car Game Polishing


## Notes

car size = (15, 32)px
line = 19 px
Screen = 30 lines
road = 7 lines
roads = range(11,20)
`#  #  #  #  #  #  #  #  #  #  |  |  |  |  |  |  |  |  |  |  #  #  #  #  #  #  #  #  #  # `
`1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30`
