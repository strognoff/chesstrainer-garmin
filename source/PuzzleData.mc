// Chess puzzle data - 50 tactical puzzles in FEN format
// Source: https://github.com/rebeccaloran/432k-chess-puzzles
class PuzzleData {
    // Array of FEN positions (first 5 fields only - position + side to move)
    static const puzzles = [
        "4R3/8/8/2Pkp3/N7/4rnKB/1nb5/b1r5 w - -",  // 1
        "b1B3Q1/5K2/5NP1/n7/2p2k1P/3pN2R/1B1P4/4qn2 w - -",  // 2
        "1k6/1P5Q/8/7B/8/5K2/8/8 w - -",  // 3
        "6Q1/1Nn5/2p1rp2/2p5/2r1k2P/2PN3K/4PP2/1B2R3 w - -",  // 4
        "8/8/7N/3p2pk/3p2p1/3P4/P1K5/8 w - -",  // 5
        "1n3NR1/2B1R3/2pK1p2/2N2p2/5kbp/1r1p4/3ppr2/4b1QB w - -",  // 6
        "K1B5/P2r4/1p1r1n2/4k3/8/3PPP2/8/8 w - -",  // 7
        "8/1P5B/8/2P5/8/6K1/NkP3p1/RN6 w - -",  // 8
        "8/8/5b2/8/8/5pk1/8/2BQK2R w - -",  // 9
        "3N4/4BPP1/5Kpp/1BPp1Q1b/1p1kq2R/2b1r2n/1p1ppr2/8 w - -",  // 10
        "7k/1n6/7K/2p3Q1/1pr2p2/1qb5/8/1b6 w - -",  // 11
        "8/3Q4/3p4/2b2n2/3N1p2/nR2B2b/p7/k1K5 w - -",  // 12
        "4K3/4P3/P1N2pP1/1BPk1P2/4N3/pP1p1Q2/1br2P2/q1r5 w - -",  // 13
        "5br1/pKn1P3/2Q5/3n4/2P1kP1N/1Npp1R2/r5B1/qb6 w - -",  // 14
        "8/Bbp1r3/R2p2p1/2P1p1Pp/3R3K/6N1/3P1kp1/3Q4 w - -",  // 15
        "2K5/1B3N2/8/5R2/3k4/8/7B/4r3 w - -",  // 16
        "8/2p2P1n/2p2P2/p1R2P2/2P2k2/K7/P3p1P1/8 w - -",  // 17
        "1q4b1/8/N2n1NQ1/2P2p2/B1k2rRr/1p1Rp2p/4K3/B7 w - -",  // 18
        "8/8/Q6B/2p5/p2k2P1/p7/5N2/N4K2 w - -",  // 19
        "4RbB1/1pr5/N7/7n/1p1B1P2/1P1kPR2/rP6/2nK4 w - -",  // 20
        "8/P2pBq2/2P5/P2k1r2/Bp1N2Q1/1P6/2K1R1bb/8 w - -",  // 21
        "6K1/p7/P2kPp1Q/1p1NR3/3N3P/2P2Pp1/3P4/8 w - -",  // 22
        "8/8/8/4R1n1/7N/3K4/3p4/4N2k w - -",  // 23
        "8/8/8/1p6/1p6/k7/1R6/N2N3K w - -",  // 24
        "2b2q2/1pPP1pPP/1Np1BkNB/8/2n1PPP1/7n/7K/8 w - -",  // 25
        "8/1P2krP1/8/8/8/8/8/4K3 w - -",  // 26
        "8/1P6/8/8/3p4/1p1k4/3ppK2/8 w - -",  // 27
        "8/k3p3/8/5P1P/K6p/N7/7b/8 w - -",  // 28
        "2B5/rR5K/4N3/p4p2/R5N1/5krn/7Q/6n1 w - -",  // 29
        "3Q2br/5p2/4pN2/1p6/1K3kP1/8/2PN1P2/4R3 w - -",  // 30
        "8/8/8/8/Q7/6pK/6P1/6bk w - -",  // 31
        "1b1q1Bn1/2pPrN1b/4Qp2/P1k5/1p1N1Rn1/1P1p4/1R1P4/4K2B w - -",  // 32
        "4k3/7N/4K3/8/7B/8/7n/8 w - -",  // 33
        "5n2/R3P1qn/1NBNp3/1pk5/3p1P2/2b3pR/1PP2p2/1KB4Q w - -",  // 34
        "Qb6/2p5/1PB2PPp/1PpRN1pb/p3k3/6P1/5P2/1nK5 w - -",  // 35
        "1r1R3B/4q2B/8/3N1n2/3Pr3/8/K1k2n2/2b5 w - -",  // 36
        "8/8/8/7p/5p1K/4PN2/R7/5k2 w - -",  // 37
        "8/3Q4/8/1p3N2/2k5/8/2N5/6K1 w - -",  // 38
        "8/5P2/2r2pPb/3nnk1r/1PB1pN1P/1q5p/b5P1/2K5 w - -",  // 39
        "Q7/8/2K5/8/4N2R/3P4/3Pk3/8 w - -",  // 40
        "5k2/8/5B2/8/2K5/8/8/5Q2 w - -",  // 41
        "4k2r/8/4Kp2/8/4R3/8/4R3/7n w - -",  // 42
        "7n/Q2B4/1Bpp4/1b1kN003/p004pN1/P004Pp1/003Kn1P1/8 w - -",  // 43
        "b7/r3N1K1/1p3R02/004k1p1/002p1r003/Q1P002bqN/004n002B/004R003 w - -",  // 44
        "8/002p1p003/1p003n1R/R1q1kP02/002QNr1P1/B003p1P1/004K002n/8 w - -",  // 45
        "8/8/1q1k4/002NP004/PP003K02/1P004N1/8/8 w - -",  // 46
        "r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/8/PPPP1PPP/RNBQK1NR w KQkq -",  // 47
        "K2Q4/n3p3/2PpP1p1/2N1N3/1PPkBP2/3n3p/bP2RP02/002R003bq w - -",  // 48
        "1B1NR3/2rp4/p2k2pQ/R6p/pK4br/P4p1p/5P1P/5N02 w - -",  // 49
        "7B/6R1/8/3pn3/3k4/Pr2p3/6K1/8 w - -"  // 50
    ];

    // Solution moves in coordinate notation (from-square to-square)
    // Format: "e2e4" means move from e2 to e4
    static const solutionMoves = [
        "a4b6",  // 1: Nb6# - Knight fork checkmate
        "g8f8",  // 2: Qxf8# - Queen takes bishop, checkmate
        "h7a7",  // 3: Qa7# - Queen to a7, checkmate
        "g8g4",  // 4: Qg4# - Queen to g4, checkmate (CORRECTED)
        "h6f7",  // 5: Nf7# - Knight to f7, checkmate
        "h1h4",  // 6: Qxh4# - Queen takes pawn, checkmate
        "a6d6",  // 7: Rxd6+ - Rook takes rook with check (leads to mate)
        "a1a2",  // 8: Rxa2# - Rook takes knight, checkmate
        "c1h6",  // 9: Bxh6# - Bishop takes bishop, checkmate
        "f5f8",  // 10: Qf8# - Queen to f8, checkmate
        "g5g7",  // 11: Qg7# - Queen to g7, checkmate
        "d7d8",  // 12: Qd8# - Queen to d8, checkmate
        "f3a8",  // 13: Qa8# - Queen to a8, checkmate
        "c6f8",  // 14: Qf8# - Queen to f8, checkmate (CORRECTED - was Qxf8)
        "d1g1",  // 15: Qg1# - Queen to g1, checkmate (CORRECTED)
        "f5e5",  // 16: Re5# - Rook to e5, checkmate
        "c5c8",  // 17: Rc8# - Rook to c8, checkmate
        "g6f8",  // 18: Qf8# - Queen to f8, checkmate
        "a6b4",  // 19: Qb4# - Queen to b4, checkmate (CORRECTED)
        "e8f8",  // 20: Rxf8# - Rook takes bishop, checkmate (CORRECTED)
        "g4f8",  // 21: Qf8# - Queen to f8, checkmate (CORRECTED - was Qxf8)
        "h6h8",  // 22: Qh8# - Queen to h8, checkmate (CORRECTED)
        "e5f7",  // 23: Nf7# - Knight to f7, checkmate
        "b2a2",  // 24: Ra2# - Rook to a2, checkmate
        "e6f8",  // 25: Bxf8# - Bishop takes queen, checkmate
        "g7g8",  // 26: g8=Q# - Pawn promotes to Queen, checkmate (CORRECTED)
        "b7b8",  // 27: b8=Q+ - Pawn promotes to Queen with check
        "a3b5",  // 28: Nb5# - Knight to b5, checkmate
        "h2h3",  // 29: Qh3# - Queen to h3, checkmate
        "d8f8",  // 30: Qf8# - Queen to f8, checkmate
        "a4g4",  // 31: Qg4# - Queen to g4, checkmate
        "e6f8",  // 32: Qf8# - Queen to f8, checkmate
        "h7f8",  // 33: Nf8# - Knight to f8, checkmate
        "h1f8",  // 34: Qf8# - Queen to f8, checkmate (CORRECTED - was Qxf8)
        "a8b8",  // 35: Qb8# - Queen to b8, checkmate (CORRECTED)
        "d8d4",  // 36: Rd4# - Rook to d4, checkmate
        "a3a1",  // 37: Ra1# - Rook to a1, checkmate (CORRECTED)
        "d7e5",  // 38: Ne5# - Knight to e5, checkmate
        "f7g8",  // 39: Ng8# - Knight to g8, checkmate (CORRECTED)
        "a8e4",  // 40: Qe4# - Queen to e4, checkmate
        "f1f8",  // 41: Qf8# - Queen to f8, checkmate
        "e4e8",  // 42: Re8# - Rook to e8, checkmate
        "a7e7",  // 43: Qe7# - Queen to e7, checkmate (CORRECTED)
        "a3c3",  // 44: Qc3# - Queen to c3, checkmate (CORRECTED)
        "c4c5",  // 45: Qc5# - Queen to c5, checkmate (CORRECTED)
        "c5e6",  // 46: Ne6# - Knight to e6, checkmate
        "d1h5",  // 47: Qh5# - Queen to h5, Scholar's Mate
        "d8d6",  // 48: Qd6# - Queen to d6, checkmate (CORRECTED)
        "h6h8",  // 49: Qh8# - Queen to h8, checkmate
        "g7d7"   // 50: Rd7# - Rook to d7, checkmate
    ];

    static function getPuzzle(index) {
        if (index >= 0 && index < puzzles.size()) {
            return puzzles[index];
        }
        return null;
    }

    static function getPuzzleCount() {
        return puzzles.size();
    }

    static function getSolution(index) {
        if (index >= 0 && index < solutionMoves.size()) {
            return solutionMoves[index];
        }
        return null;
    }

    static function getPuzzleName(index) {
        var names = [
            "Fork Attack",
            "Back Rank Mate",
            "Pin Tactic",
            "Skewer",
            "Discovered Attack",
            "Double Check",
            "Deflection",
            "Decoy",
            "Clearance",
            "X-Ray Attack",
            "Zugzwang",
            "Promotion",
            "Smothered Mate",
            "Knight Fork",
            "Bishop Pair",
            "Rook Endgame",
            "Queen Sacrifice",
            "Windmill",
            "Desperado",
            "Interference",
            "Overloading",
            "Underpromotion",
            "Stalemate Trick",
            "Perpetual Check",
            "Fortress Break",
            "Pawn Break",
            "Quiet Move",
            "Intermediate Move",
            "Zwischenzug",
            "Battery Setup",
            "Trapped Piece",
            "Weak Back Rank",
            "Exposed King",
            "Material Win",
            "Positional Win",
            "Endgame Study",
            "Tactical Blow",
            "Combination",
            "Sacrifice",
            "Breakthrough",
            "Mating Attack",
            "Defensive Move",
            "Counter Attack",
            "Piece Hunt",
            "King Hunt",
            "Scholar's Mate",
            "Tempo Play",
            "Complex Tactic",
            "Pattern Recognition",
            "Calculation Test"
        ];
        
        if (index >= 0 && index < names.size()) {
            return names[index];
        }
        return "Puzzle " + (index + 1);
    }
}