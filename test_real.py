#!/usr/bin/env python3
"""
Test actual checkmate positions - FIXED
The side to move (w) needs to deliver checkmate to black (b)
"""
import sys
sys.path.insert(0, '.')
from validate_puzzles import ChessBoard

# REAL mate-in-1 positions - need BOTH kings + attacking pieces
TEST_FENS = [
    # White to move - checkmate black king
    # Queen corner mate
    ("k7/8/8/8/8/8/8/Q1K5 w - -", "Qa8#"),
    # Back rank mate - black king on row 0
    ("6k1/5ppp/8/8/8/8/5PPP/4R1K1 w - -", "Re8# back rank"),
    # Smothered - knight covers escape
    ("6rk/5N1p/8/8/8/8/8/7K w - -", "Nf7# smothered"),
    # Queen + king mate
    ("k7/8/8/8/8/8/8/QK6 w - -", "Qa8#"),
    # Just queen vs king (king not mated yet)
    ("k7/8/8/8/8/8/8/Q7 w - -", "Qa8#"),
    # Rook + king mate  
    ("k7/8/8/8/8/8/8/RK6 w - -", "Ra8#"),
    # Queen + bishop
    ("6k1/4Q3/8/2B5/8/8/8/4K3 w - -", "Be6#"),
    # More classic mates
    ("7k/8/8/8/8/8/8/Q1K5 w - -", "Qb8#"),
    ("k7/8/8/8/8/8/8/1Q6 w - -", "Qc8#"),
    ("k7/8/8/8/8/8/8/2Q5 w - -", "Qd8#"),
]

print("=" * 60)
print("Testing positions - White to move, checkmate Black")
print("=" * 60)

for fen, name in TEST_FENS:
    board = ChessBoard(fen)
    # White to move (w) should checkmate black (b)
    black_in_check = board.is_check('b')
    black_mated = board.is_checkmate('b')
    
    if black_mated:
        print(f"✓ {name}: {fen}")
    else:
        print(f"✗ {name}: in_check={black_in_check}, mated={black_mated}")

print("=" * 60)
