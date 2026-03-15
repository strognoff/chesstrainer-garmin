#!/usr/bin/env python3
"""
Test real Mate-in-1 positions
"""
import sys
sys.path.insert(0, '.')
from validate_puzzles import ChessBoard, validate_puzzle

# Real verified mate-in-1 positions (known to deliver checkmate in 1)
TEST_FENS = [
    # Position 1: King + Queen vs King - Queen delivers mate
    ("k7/8/8/8/8/8/8/Q1K5 w - -", "Queen vs King - Qa8#"),
    # Position 2: King + Rook vs King - Back rank
    ("6k1/5ppp/8/8/8/8/5PPP/4R1K1 w - -", "Back Rank"),
    # Position 3: King + Queen + Bishop
    ("6k1/4Q3/8/2B5/8/8/8/4K3 w - -", "Queen Bishop"),
    # Position 4: Smothered mate
    ("6rk/5N1p/8/8/8/8/8/7K w - -", "Smothered"),
    # Position 5: Simple queen mate
    ("k7/8/3Q4/8/8/8/8/4K3 w - -", "Queen corner"),
    # Position 6: Scholar's mate setup
    ("r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5Q2/PPPP1PPP/RNB1K1NR w KQkq -", "Scholar"),
    # Position 7: Famous mate in 1
    ("7k/R7/8/8/8/8/8/7K w - -", "Rook mate"),
    # Position 8: 
    ("8/8/8/8/8/6K1/5Q2/7k w - -", "Queen mate"),
    # Position 9:
    ("k7/8/8/8/8/8/8/Q7 w - -", "Queen mate 2"),
    # Position 10:
    ("6k1/5ppp/8/8/8/8/4Q3/4K3 w - -", "Queen center"),
]

print("=" * 60)
print("Testing REAL Mate-in-1 positions")
print("=" * 60)

valid_puzzles = []

for fen, name in TEST_FENS:
    is_valid, msg = validate_puzzle(fen)
    status = "✓" if is_valid else "✗"
    print(f"{status} {name}: {msg}")
    if is_valid:
        valid_puzzles.append((fen, name))
    else:
        # Debug
        board = ChessBoard(fen)
        kr, kc = board.find_king('b')
        if kr >= 0:
            print(f"   Black king at ({kr},{kc}), in check: {board.is_check('b')}")

print("=" * 60)
print(f"Valid: {len(valid_puzzles)}")
for fen, name in valid_puzzles:
    print(f"  {fen}")
print("=" * 60)
