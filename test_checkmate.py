#!/usr/bin/env python3
"""
Test actual checkmate positions
"""
import sys
sys.path.insert(0, '.')
from validate_puzzles import ChessBoard, validate_puzzle

# Real checkmate positions
TEST_FENS = [
    # Queen and king mate - king trapped in corner
    ("k7/8/8/8/8/8/8/Q1K5 w - -", "Qa8# - queen corner"),
    # King and rook mate  
    ("k7/8/8/8/8/8/8/R1K5 w - -", "Ra8# - rook corner"),
    # Back rank mate
    ("6k1/5ppp/8/8/8/8/5PPP/4R1K1 w - -", "Re8# - back rank"),
    # Queen delivered checkmate
    ("k7/8/8/8/8/8/8/2Q5 w - -", "Qc8#"),
    ("k7/8/8/8/8/8/8/3Q4 w - -", "Qd8#"),
    ("k7/8/8/8/8/8/8/4Q3 w - -", "Qe8#"),
    ("k7/8/8/8/8/8/8/5Q2 w - -", "Qf8#"),
    ("k7/8/8/8/8/8/8/6Q1 w - -", "Qg8#"),
    ("k7/8/8/8/8/8/8/7Q w - -", "Qh8#"),
    # Rook mates
    ("k7/8/8/8/8/8/8/2R5 w - -", "Rc8#"),
    ("k7/8/8/8/8/8/8/3R4 w - -", "Rd8#"),
    ("k7/8/8/8/8/8/8/4R3 w - -", "Re8#"),
    ("k7/8/8/8/8/8/8/5R2 w - -", "Rf8#"),
    ("k7/8/8/8/8/8/8/6R1 w - -", "Rg8#"),
    ("k7/8/8/8/8/8/8/7R w - -", "Rh8#"),
    # King queen mate
    ("k7/8/8/8/8/8/Q7/4K3 w - -", "Qa8# with K"),
    ("7k/8/8/8/8/8/8/Q1K5 w - -", "Qa8# vs black king"),
]

print("=" * 60)
print("Testing checkmate positions")
print("=" * 60)

valid = 0
for fen, name in TEST_FENS:
    board = ChessBoard(fen)
    side = fen.split()[1]
    in_check = board.is_check(side)
    is_mate = board.is_checkmate(side)
    
    if in_check and is_mate:
        print(f"✓ {name}: {fen[:40]}")
        valid += 1
    elif in_check:
        print(f"? {name}: IN CHECK but NOT MATE - {fen[:40]}")
    else:
        print(f"✗ {name}: NOT IN CHECK - {fen[:40]}")

print("=" * 60)
print(f"Valid mate-in-1: {valid}")
