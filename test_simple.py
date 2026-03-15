#!/usr/bin/env python3
"""
Simplified test - just find ANY position where black is in check
"""
import sys
sys.path.insert(0, '.')
from validate_puzzles import ChessBoard

# Simpler approach: test if position has black in check
TEST_FENS = [
    # Standard positions where white attacks black king
    "k7/8/8/8/8/8/8/Q7 w - -",  # queen attacks a8
    "7k/8/8/8/8/8/8/Q7 w - -",  # queen attacks h8
    "k7/8/8/8/8/8/8/R7 w - -",  # rook attacks a8
    "7k/8/8/8/8/8/8/R7 w - -",  # rook attacks h8
    "k7/8/8/8/8/8/8/1R6 w - -",
    "k7/8/8/8/8/8/8/2R5 w - -",
    "k7/8/8/8/8/8/8/3R4 w - -",
    "k7/8/8/8/8/8/8/4R3 w - -",
    "k7/8/8/8/8/8/8/5R2 w - -",
    "k7/8/8/8/8/8/8/6R1 w - -",
    "k7/8/8/8/8/8/8/7R w - -",
    "k7/8/8/8/8/8/8/8R w - -",
    # With queens
    "k7/8/8/8/8/8/8/1Q6 w - -",
    "k7/8/8/8/8/8/8/2Q5 w - -",
    "k7/8/8/8/8/8/8/3Q4 w - -",
    "k7/8/8/8/8/8/8/4Q3 w - -",
    "k7/8/8/8/8/8/8/5Q2 w - -",
    "k7/8/8/8/8/8/8/6Q1 w - -",
    "k7/8/8/8/8/8/8/7Q w - -",
    # With kings
    "k7/8/8/8/8/8/8/K1Q5 w - -",
    "7k/8/8/8/8/8/8/1Q6 w - -",
    # More complex
    "6k1/5ppp/8/8/8/8/5PPP/4R1K1 w - -",
]

print("Testing positions for check...")
valid = 0
for fen in TEST_FENS:
    board = ChessBoard(fen)
    in_check = board.is_check('b')
    if in_check:
        print(f"✓ {fen}")
        valid += 1
    else:
        print(f"✗ {fen}")
        
print(f"\nTotal: {valid}/{len(TEST_FENS)} have black in check")
