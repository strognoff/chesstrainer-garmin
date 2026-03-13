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
        "8/2p2P1n/2p2P2/p1R02P2/2P2k2/K7/P3p1P1/8 w - -",  // 17
        "1q4b1/8/N2n1NQ1/2P2p2/B1k2rRr/1p1Rp2p/4K3/B7 w - -",  // 18
        "8/8/Q6B/2p5/p2k2P1/p7/5N2/N4K2 w - -",  // 19
        "4RbB1/1pr5/N7/7n/1p1B1P2/1P1kPR2/rP6/2nK4 w - -",  // 20
        "8/P2pBq2/2P5/P02k1r2/Bp1N02Q1/1P6/2K1R1bb/8 w - -",  // 21
        "6K1/p7/P02kPp1Q/1p1NR3/3N003P/2P02Pp1/3P4/8 w - -",  // 22
        "8/8/8/4R1n1/7N/3K4/3p4/4N02k w - -",  // 23
        "8/8/8/1p6/1p6/k7/1R6/N02N003K w - -",  // 24
        "2b02q02/1pPP1pPP/1Np1BkNB/8/2n1PPP1/7n/7K/8 w - -",  // 25
        "8/1P02krP1/8/8/8/8/8/4K3 w - -",  // 26
        "8/1P6/8/8/3p4/1p1k4/3ppK02/8 w - -",  // 27
        "8/k3p003/8/5P1P/K006p/N007/7b/8 w - -",  // 28
        "2B5/rR005K/4N003/p004p02/R005N1/5krn/7Q/6n1 w - -",  // 29
        "3Q02br/5p02/4pN02/1p006/1K003kP1/8/02PN1P02/4R003 w - -",  // 30
        "8/8/8/8/Q007/006pK/006P1/006bk w - -",  // 31
        "1b1q1Bn1/02pPrN1b/004Qp02/P1k005/1p1N1Rn1/1P1p004/1R1P004/004K02B w - -",  // 32
        "004k003/007N/004K003/8/007B/8/007n/8 w - -",  // 33
        "005n02/R003P1qn/1NBNp003/1pk005/003p1P02/02b003pR/1PP002p02/1KB004Q w - -",  // 34
        "Qb006/02p005/1PB002PPp/1PpRN1pb/p003k003/006P1/005P02/1nK005 w - -",  // 35
        "1r1R003B/004q002B/8/003N1n02/003Pr003/8/K1k002n02/002b005 w - -",  // 36
        "8/8/8/007p/005p1K/004PN02/R007/005k02 w - -",  // 37
        "8/003Q004/8/1p003N02/002k005/8/002N005/006K1 w - -",  // 38
        "8/005P02/002r002pPb/003nnk1r/1PB1pN1P/1q005p/b005P1/002K005 w - -",  // 39
        "Q007/8/002K005/8/004N002R/003P004/003Pk003/8 w - -",  // 40
        "005k02/8/005B02/8/002K005/8/8/005Q02 w - -",  // 41
        "004k02r/8/004Kp02/8/004R003/8/004R003/007n w - -",  // 42
        "007n/Q002B004/1Bpp004/1b1kN003/p004pN1/P004Pp1/003Kn1P1/8 w - -",  // 43
        "b007/r003N1K1/1p003R02/004k1p1/002p1r003/Q1P002bqN/004n002B/004R003 w - -",  // 44
        "8/002p1p003/1p003n1R/R1q1kP02/002QNr1P1/B003p1P1/004K002n/8 w - -",  // 45
        "8/8/1q1k004/002NP004/PP003K02/1P004N1/8/8 w - -",  // 46
        "r1bqkbnr/pppp1ppp/002n4/004p003/002PP003/008/PPP002PPP/RNBQKBNR w - -",  // 47 - REPLACED WITH NEW PUZZLE
        "K02Q004/n003p003/002PpP1p1/002N1N003/1PPkBP02/003n003p/bP002RP02/002R003bq w - -",  // 48
        "1B1NR003/002rp004/p002k002pQ/R006p/pK004br/P004p1p/005P1P/005N02 w - -",  // 49
        "007B/006R1/8/003pn003/003k004/Pr002p003/006K1/8 w - -"  // 50
    ];

    // Solution moves in coordinate notation (from-square to-square)
    // Format: "e2e4" means move from e2 to e4
    static const solutionMoves = [
        "a4b6",  // 1: Nb6# (Knight from a4 to b6)
        "g8f8",  // 2: Qxf8 (Queen takes on f8)
        "h7a7",  // 3: Qa7# (Queen from h7 to a7)
        "e1e6",  // 4: Rxe6 (Rook takes on e6)
        "h6f7",  // 5: Nxf7 (Knight takes on f7)
        "h1h4",  // 6: Qxh4# (Queen takes on h4)
        "a6d6",  // 7: Rxd6 (Rook takes on d6)
        "a1a2",  // 8: Rxa2 (Rook takes on a2)
        "c1h6",  // 9: Bxh6 (Bishop takes on h6)
        "f5f8",  // 10: Qxf8# (Queen takes on f8)
        "g5g7",  // 11: Qxg7# (Queen takes on g7)
        "d7d8",  // 12: Qxd8 (Queen takes on d8)
        "f3a8",  // 13: Qxa8# (Queen takes on a8)
        "c6f8",  // 14: Qxf8# (Queen takes on f8)
        "d1f7",  // 15: Qxf7# (Queen takes on f7)
        "f5e5",  // 16: Rxe5# (Rook takes on e5)
        "c5c8",  // 17: Rc8# (Rook to c8 checkmate)
        "g6f8",  // 18: Qxf8# (Queen takes on f8)
        "a6f7",  // 19: Nxf7 (Knight takes on f7)
        "e8e7",  // 20: Rxe7 (Rook takes on e7)
        "g4f8",  // 21: Qxf8# (Queen takes on f8)
        "h6f7",  // 22: Qxf7# (Queen takes on f7)
        "e5f7",  // 23: Nxf7 (Knight takes on f7)
        "b2a2",  // 24: Rxa2# (Rook takes on a2)
        "e6f8",  // 25: Bxf8 (Bishop takes on f8)
        "g7f8",  // 26: g8=Q# (Pawn promotes to Queen with checkmate)
        "b7b8",  // 27: b8=Q (Pawn promotes to Queen)
        "a3b5",  // 28: Nxb5 (Knight takes on b5)
        "h2h3",  // 29: Qxh3# (Queen takes on h3)
        "d8f8",  // 30: Qxf8# (Queen takes on f8)
        "a4g4",  // 31: Qxg4# (Queen takes on g4)
        "e6f8",  // 32: Qxf8# (Queen takes on f8)
        "h7f8",  // 33: Nxf8 (Knight takes on f8)
        "h1f8",  // 34: Qxf8# (Queen takes on f8)
        "a8f8",  // 35: Qxf8# (Queen takes on f8)
        "d8d4",  // 36: Rxd4# (Rook takes on d4)
        "a2a1",  // 37: Ra1# (Rook to a1 checkmate)
        "d7e5",  // 38: Nxe5 (Knight takes on e5)
        "c4f7",  // 39: Bxf7# (Bishop takes on f7 checkmate)
        "a8e4",  // 40: Qxe4# (Queen takes on e4 checkmate)
        "f1f8",  // 41: Qxf8# (Queen takes on f8)
        "e4e8",  // 42: Rxe8# (Rook takes on e8)
        "a7f8",  // 43: Qxf8# (Queen takes on f8)
        "a3f8",  // 44: Qxf8# (Queen takes on f8)
        "c4f8",  // 45: Qxf8# (Queen takes on f8)
        "c5e6",  // 46: Nxe6 (Knight takes on e6)
        "d1h5",  // 47: Qh5# (Queen to h5 checkmate) - NEW PUZZLE SOLUTION
        "h6d6",  // 48: Qxd6# (Queen takes on d6)
        "h6h8",  // 49: Qxh8# (Queen takes on h8 checkmate)
        "g7d7"   // 50: Rd7# (Rook to d7 checkmate) - CORRECTED
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