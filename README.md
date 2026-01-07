# Alphabet Catching Game

**x86 Assembly game** — Catch falling alphabet characters to score points.

## How to play
- **Left Arrow:** Move catcher left
- **Right Arrow:** Move catcher right
- **Goal:** Catch falling letters to score; miss 10 and game over

## Build & Run
Requires x86 16-bit assembly environment (DOS/NASM or TASM):

```bash
nasm -f bin game.asm -o game.com
# Or with TASM:
tasm game.asm
tlink /t game.obj
```

Run in a DOS emulator (DosBox, Virtual Machine, etc.).

## Features
- Randomized letter positions and timing
- Keyboard interrupt handler for responsive controls
- Score and miss tracking
- Game over after 10 misses
