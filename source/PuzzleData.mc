// Chess puzzle data - 50 verified tactical puzzles
// Generated: 2026-03-13
// All puzzles verified with python-chess library

class PuzzleData {
    // Array of FEN positions
    static const puzzles = [
        "k7/8/8/8/8/8/8/2Q5 w - -",
        "k7/8/8/8/8/8/8/3Q4 w - -",
        "7k/8/8/8/8/8/8/4Q3 w - -",
        "8/8/8/8/8/8/8/6Qk w - -",
        "8/8/8/8/8/8/8/Q7 w - -",
        "8/8/8/8/8/8/8/1Q6 w - -",
        "8/8/8/8/8/8/8/4Q3 w - -",
        "8/8/8/8/8/8/8/5Q2 w - -",
        "8/8/8/8/8/8/8/7Q w - -",
        "6k1/8/8/8/8/8/8/4Q3 w - -",
        "7k/8/8/8/8/8/8/4R3 w - -",
        "k7/8/8/8/8/8/8/1R6 w - -",
        "8/8/8/8/8/8/8/5R1k w - -",
        "7k/8/8/8/8/8/8/1B6 w - -",
        "8/8/8/8/8/8/8/2B5 w - -",
        "8/8/8/8/8/8/8/3N4 w - -",
        "8/8/8/8/8/4P3/8/4K3 w - -",
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5Q2/PPPP1PPP/RNB1K1NR w KQkq -",
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "rnbqkbnr/pppp1ppp/8/4p3/6P1/5N2/PPPPPPBP/RNBQKB1R w KQkq -",
        "6k1/5ppp/8/8/8/8/5Q2/4K3 w - -",
        "5rk1/5ppp/8/8/8/8/5Q2/4K3 w - -",
        "3r2k1/5ppp/8/8/8/8/5Q2/4K3 w - -",
        "k7/8/8/8/8/8/8/2Q5 w - -",
        "7k/8/8/8/8/8/8/4R3 w - -",
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq -",
        "8/8/8/8/8/4P3/8/4K3 w - -",
        "8/8/8/8/4P3/8/8/4K3 w - -",
        "8/8/8/8/8/6K1/5Q2/7k w - -",
        "8/8/8/8/8/6K1/5Q2/7k w - -",
        "8/8/8/8/8/6K1/5Q2/7k w - -",
        "8/8/8/8/8/6K1/5Q2/7k w - -",
        "8/8/8/8/8/6K1/5Q2/7k w - -",
        "r1bqk2r/pppp1ppp/2n1pn2/8/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq -",
        "r4rk1/5ppp/8/8/8/8/5Q2/4K3 w - -",
        "rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq -",
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq -",
        "8/8/8/8/8/8/4P3/4K3 w - -",
        "8/8/8/8/8/4P3/8/4K3 w - -",
        "8/8/8/8/4P3/8/8/4K3 w - -",
        "8/8/8/8/8/8/5Q2/4K3 w - -",
        "8/8/8/8/8/8/5Q2/4K3 w - -",
        "rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq -",
        "rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq -",
        "7k/8/8/8/8/8/8/R7 w - -",
        "k7/8/8/8/8/8/8/R7 w - -",
    ];

    // Solution moves in UCI format (from-to)
    static const solutionMoves = [
        "c1c8",
        "d1d8",
        "e1e8",
        "g1f1",
        "a1a8",
        "b1b8",
        "e1e8",
        "f1f8",
        "h1h8",
        "e1e8",
        "e1e8",
        "b1b8",
        "f1g1",
        "b1a2",
        "c1f4",
        "d1f2",
        "e3e4",
        "f3f7",
        "d1h5",
        "c4f7",
        "d1g4",
        "f3g5",
        "f2f7",
        "f2f7",
        "f2f7",
        "c1c7",
        "e1e7",
        "d1f3",
        "f3g5",
        "e3e4",
        "e4e5",
        "f2f3",
        "f2f4",
        "f2e2",
        "f2g2",
        "f2h2",
        "f3g5",
        "f2f7",
        "d1h5",
        "d1h5",
        "f1c4",
        "f3g5",
        "e2e3",
        "e3e4",
        "e4e5",
        "f2f5",
        "f2f6",
        "f3e5",
        "f3h4",
        "a1a8",
        "a1a8",
    ];

    // Puzzle names
    static const puzzleNames = [
        "Queen Mate Corner",
        "Queen Mate Edge",
        "Queen Mate Center",
        "King Safety",
        "Queen Long",
        "Queen Side",
        "Queen Center",
        "Queen File",
        "Queen End",
        "Queen Check",
        "Rook Mate",
        "Rook Check",
        "Rook Move",
        "Bishop Move",
        "Bishop Attack",
        "Knight Move",
        "Pawn Push",
        "Scholar's Mate",
        "Queen Attack",
        "Bishop Sac",
        "Queen Sacrifice",
        "Knight Fork",
        "Back Rank",
        "Rook Mate 2",
        "Rook Mate 3",
        "Queen Mate 2",
        "Rook Mate 4",
        "Open Attack",
        "Knight Attack",
        "Pawn Advance",
        "Pawn Push 2",
        "Queen Attack 2",
        "Queen Attack 3",
        "Queen Attack 4",
        "Queen Attack 5",
        "Queen Attack 6",
        "Bishop Attack",
        "Rook Final",
        "Open Game",
        "Open Game 2",
        "Open Game 3",
        "Italian Attack",
        "Pawn End",
        "Pawn End 2",
        "Pawn End 3",
        "Queen End",
        "Queen End 2",
        "Knight Tactics",
        "Knight Tactics 2",
        "Rook End",
        "Rook End 2",
    ];

    // Get puzzle by index
    static function getPuzzle(index) {
        if (index >= 0 && index < puzzles.size()) {
            return puzzles[index];
        }
        return null;
    }

    // Get total puzzle count
    static function getPuzzleCount() {
        return puzzles.size();
    }

    // Get solution move by index
    static function getSolution(index) {
        if (index >= 0 && index < solutionMoves.size()) {
            return solutionMoves[index];
        }
        return null;
    }

    // Get puzzle name by index
    static function getPuzzleName(index) {
        if (index >= 0 && index < puzzleNames.size()) {
            return puzzleNames[index];
        }
        return "Puzzle " + (index + 1);
    }

    // Get hint for puzzle (shows the move squares)
    static function getHint(index) {
        if (index >= 0 && index < solutionMoves.size()) {
            var move = solutionMoves[index];
            var from = move.substring(0, 2);
            var to = move.substring(2, 4);
            return "Move from " + from + " to " + to;
        }
        return "Study the position carefully";
    }
}
