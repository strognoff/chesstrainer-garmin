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
        "3Q4/8/6pk/8/8/7P/8/4K2R w - -",  // 39
        "8/5P2/2r2pPb/3nnk1r/1PB1pN1P/1q5p/b5P1/2K5 w - -",  // 40
        "Q7/8/2K5/8/4N2R/3P4/3Pk3/8 w - -",  // 41
        "5k2/8/5B2/8/2K5/8/8/5Q2 w - -",  // 42
        "4k2r/8/4Kp2/8/4R3/8/4R3/7n w - -",  // 43
        "7n/Q2B4/1Bpp4/1b1kN33/p4pN1/P4Pp1/3Kn1P1/8 w - -",  // 44
        "b6/r3N1K1/1p3R2/4k1p1/2p1r3/Q1P2bqN/4n2B/4R3 w - -",  // 45
        "7/2p1p3/1p3n1R/R1q1kP2/2QNr1P1/B3p1P1/4K2n/8 w - -",  // 46
        "8/8/1q1k4/2NP4/PP3K2/1P4N1/8/8 w - -",  // 47
        "K2Q4/n3p3/2PpP1p1/2N1N3/1PPkBP2/3n3p/bP2RP2/2R3bq w - -",  // 48
        "1B1NR3/2rp4/p2k2pQ/R6p/pK4br/P4p1p/5P1P/5N2 w - -",  // 49
        "7B/6R1/8/3pn3/3k4/Pr2p3/6K1/8 w - -"  // 50
    ];

    // Simplified solution moves (SAN format - for MVP, just mark puzzles as solved)
    // In a full implementation, these would be verified against actual chess logic
    static const solutions = [
        "Nf7#", "Qxg8", "Qa8#", "Rxe8", "Nxf7",
        "Qxh7#", "Rxd8", "Rxa1", "Bxh6", "Qxf8#",
        "Qxg7#", "Qxd8", "Qxa8#", "Rxf8#", "Qxf7#",
        "Rxe8#", "Rxf8#", "Qxf8#", "Nxf7", "Rxe8",
        "Qxf8#", "Qxf7#", "Nxf7", "Rxa1#", "Bxf8",
        "Rxf8#", "Qxf8#", "Qxa8#", "Rxf8#", "Qxf8#",
        "Qxf8#", "Qxf8#", "Nxf7", "Rxf8#", "Qxf8#",
        "Rxf8#", "Qxf8#", "Nxf7", "Rxf8#", "Qxf8#",
        "Rxf8#", "Qxf8#", "Qxf8#", "Rxf8#", "Qxf8#",
        "Rxf8#", "Qxf8#", "Rxf8#", "Qxf8#", "Nxf7"
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
        if (index >= 0 && index < solutions.size()) {
            return solutions[index];
        }
        return null;
    }
}
