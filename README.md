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

## Puzzle Data

50 tactical puzzles in FEN format from [432k Chess Puzzles](https://github.com/rebeccaloran/432k-chess-puzzles).

## Building

This project uses the Garmin Connect IQ SDK. To build:

1. Install [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/)
2. Open the project in Eclipse or use the command line:
   ```
   monkeyc -o ChessTrainer.prg -f monkey.jungle -y your-garmin-developer-key.der
   ```

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
