# ChessTrainer Garmin App

A chess tactics trainer app for Garmin watches built with Connect IQ (Monkey C).

## Features

- **Puzzle Display** - Show FEN position with goal "Find the best move"
- **Move Input** - Button navigation for chess moves
- **Timer** - Track time per puzzle
- **Hint System** - Optional hint after failed attempts
- **History** - View solved/incorrect puzzles
- **Progress Stats** - Puzzles solved, accuracy, average time

## Supported Devices

- Forerunner (255, 255s, 265, 965)
- Fenix (7 Pro, 7x Pro, 8, 8x, 8 Pro)
- Venu (2, 2 Plus, 3)
- Instinct (2, 3)
- Epix Pro
- Vivoactive 5

## Puzzle Collection

ChessTrainer includes **51 carefully curated and validated chess puzzles** designed to teach fundamental chess tactics and patterns. All puzzles have been programmatically verified for correctness using the python-chess library.

### What You'll Learn

The puzzle collection covers essential chess concepts:

- **Checkmate Patterns** (3 puzzles) - Learn to deliver decisive checkmate moves
  - Queen checkmate patterns in various board positions
  - Recognizing unstoppable mating attacks

- **Endgame Technique** (22 puzzles) - Master king and queen/rook endgames
  - King restriction with checks
  - Queen vs lone king positioning
  - Pawn advancement and promotion
  - Rook activity in endgames

- **Tactical Attacks** (9 puzzles) - Develop attacking skills
  - Scholar's Mate pattern (f7/f2 weakness)
  - Queen attack and positioning
  - Back rank weaknesses
  - Forcing checks to gain advantage

- **Piece Tactics** (9 puzzles) - Learn piece-specific moves
  - Knight forks (double attacks)
  - Bishop development and diagonal control
  - Knight repositioning and tactics

- **Fundamental Skills** (8 puzzles) - Build chess foundations
  - Pawn structure and advancement
  - Piece captures and exchanges
  - Opening principles

### Puzzle Difficulty

Puzzles are arranged progressively:
- **Beginner** (Puzzles 1-20): Basic endgame patterns, simple checkmates
- **Intermediate** (Puzzles 21-40): Tactical captures, opening traps, checks
- **Advanced** (Puzzles 41-51): Complex tactics, endgame technique

### Validation

All 51 puzzles have been validated with automated testing:
- ✓ All FEN positions are legal and valid
- ✓ All solution moves are legal in their positions
- ✓ Solutions lead to checkmate, check, or tactical advantage

For detailed information about each puzzle including the tactical concept it teaches, see [PUZZLES.md](PUZZLES.md).

## Building

This project uses the Garmin Connect IQ SDK. To build:

1. Install [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/)
2. Open the project in Eclipse or use the command line:
   ```
   monkeyc -o ChessTrainer.prg -f monkey.jungle -y your-garmin-developer-key.der
   ```

## Development Tools

### Puzzle Validation (`validate_puzzles.py`)

Validates all chess puzzles for correctness:

```bash
pip3 install chess
python3 validate_puzzles.py
```

**What it checks:**
- FEN position validity
- Solution move legality
- Array length consistency
- Position analysis (check/checkmate/tactical)

**Example output:**
```
✓ ALL PUZZLES ARE VALID AND LEGAL!
Total puzzles: 51
Checkmate puzzles: 3
Check puzzles: 15
Tactical puzzles: 33
```

### Puzzle Analysis (`analyze_puzzles.py`)

Generates detailed educational documentation about each puzzle:

```bash
python3 analyze_puzzles.py
```

**What it generates:**
- Tactical concepts for each puzzle
- Educational descriptions
- Grouping by concept type
- Complete puzzle documentation in `PUZZLES.md`

These tools ensure puzzle quality and help maintain the educational value of the collection.

## Project Structure

```
chesstrainer-garmin/
├── monkey.jungle          # Project manifest
├── source/
│   ├── ChessTrainerApp.mc # Main app entry
│   ├── BoardLogic.mc      # Chess board parsing
│   ├── PuzzleData.mc      # 50 puzzle FEN positions
│   ├── Storage.mc         # On-device storage
│   ├── MenuView.mc        # Main menu
│   ├── PuzzleListView.mc  # Puzzle selection
│   ├── BoardView.mc       # Chess board display
│   ├── StatsView.mc       # Progress statistics
│   └── HistoryView.mc     # Solve history
└── resources/
    ├── strings.xml        # App strings
    └── drawables.xml      # App icons
```

## Usage

1. Launch the app from your watch
2. Use UP/DOWN to navigate the puzzle list
3. Press ENTER to start a puzzle
4. Find the best move for the displayed position
5. Press MENU for a hint (solves puzzle)
6. Press ENTER to give up (marks as incorrect)
7. View stats and history from the main menu

## License

MIT License
