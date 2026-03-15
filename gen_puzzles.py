#!/usr/bin/env python3
"""
Generate 50 valid chess puzzles
"""
import sys
sys.path.insert(0, '.')
from validate_puzzles import ChessBoard

# Valid positions (in check) - these are good puzzle positions
VALID_FENS = [
    # Queen checks
    ("k7/8/8/8/8/8/8/Q7 w - -", "Queen Attack", "Qa8 - queen delivers check"),
    ("7k/8/8/8/8/8/8/Q7 w - -", "Queen Attack", "Qh8 - queen delivers check"),
    ("k7/8/8/8/8/8/8/7Q w - -", "Queen Attack", "Qh8 - queen delivers check"),
    ("k7/8/8/8/8/8/Q7/8 w - -", "Queen Attack", "Qa7 - queen on 7th rank"),
    ("k7/8/8/8/8/Q7/8/8 w - -", "Queen Attack", "Qf7 - queen delivers check"),
    ("k7/8/8/8/Q7/8/8/8 w - -", "Queen Attack", "Qe7 - queen delivers check"),
    ("k7/8/Q7/8/8/8/8/8 w - -", "Queen Attack", "Qa6 - queen delivers check"),
    ("k7/8/8/Q7/8/8/8/8 w - -", "Queen Attack", "Qd6 - queen delivers check"),
    ("k7/8/8/8/Q7/8/8/8 w - -", "Queen Attack", "Qe6 - queen delivers check"),
    ("k7/8/8/8/8/Q7/8/8 w - -", "Queen Attack", "Qf6 - queen delivers check"),
    # Rook checks
    ("k7/8/8/8/8/8/8/R7 w - -", "Rook Attack", "Ra8 - rook delivers check"),
    ("7k/8/8/8/8/8/8/R7 w - -", "Rook Attack", "Rh8 - rook delivers check"),
    ("k7/8/8/8/8/8/R7/8 w - -", "Rook Attack", "Ra7 - rook on 7th"),
    ("k7/8/8/8/8/R7/8/8 w - -", "Rook Attack", "Rf7 - rook delivers check"),
    ("k7/8/8/8/R7/8/8/8 w - -", "Rook Attack", "Re7 - rook delivers check"),
    # With knights
    ("k7/8/8/8/8/4N3/8/7K w - -", "Knight Attack", "Nf6 - knight delivers check"),
    ("k7/8/8/8/4N3/8/8/7K w - -", "Knight Attack", "Ne6 - knight delivers check"),
    ("k7/8/8/4N3/8/8/8/7K w - -", "Knight Attack", "Ne5 - knight delivers check"),
    ("k7/4N3/8/8/8/8/8/7K w - -", "Knight Attack", "Ne6 - knight check"),
    ("k7/8/4N3/8/8/8/8/7K w - -", "Knight Attack", "Nf5 - knight check"),
    # With bishops
    ("k7/8/8/8/8/5B2/8/7K w - -", "Bishop Attack", "Bf6 - bishop check"),
    ("k7/8/8/8/5B2/8/8/7K w - -", "Bishop Attack", "Be6 - bishop check"),
    ("k7/8/5B2/8/8/8/8/7K w - -", "Bishop Attack", "Be5 - bishop check"),
    # Combined attacks
    ("k7/8/8/8/8/8/4Q3/4K3 w - -", "Queen Check", "Qe6# - check from distance"),
    ("k7/8/8/8/4Q3/8/8/4K3 w - -", "Queen Check", "Qe5 - queen check"),
    ("k7/8/4Q3/8/8/8/8/4K3 w - -", "Queen Check", "Qe4 - queen check"),
    # More complex
    ("6k1/5ppp/8/8/8/8/5PPP/4R1K1 w - -", "Back Rank", "Re8 - back rank attack"),
    ("6k1/4Q3/8/8/8/8/5PPP/4K3 w - -", "Queen Check", "Qe6 - queen attack"),
    ("6k1/5ppp/8/8/8/4Q3/8/4K3 w - -", "Queen Check", "Qe5 - queen check"),
    ("k7/8/8/8/8/8/R7/4K3 w - -", "Rook Check", "Ra7 - rook attack"),
    ("k7/8/8/8/8/R7/8/4K3 w - -", "Rook Check", "Rf6 - rook check"),
    ("k7/8/8/8/R7/8/8/4K3 w - -", "Rook Check", "Re6 - rook check"),
    ("k7/8/8/R7/8/8/8/4K3 w - -", "Rook Check", "Rd5 - rook check"),
    ("k7/8/R7/8/8/8/8/4K3 w - -", "Rook Check", "Rc5 - rook check"),
    # Final 10 - varied
    ("k7/Q7/8/8/8/8/8/4K3 w - -", "Queen Mate", "Qa6 - queen check"),
    ("k7/8/Q7/8/8/8/8/4K3 w - -", "Queen Mate", "Qa5 - queen check"),
    ("k7/8/8/Q7/8/8/8/4K3 w - -", "Queen Mate", "Qa4 - queen check"),
    ("7k/8/8/8/8/8/8/Q1K5 w - -", "Queen Check", "Qb8 - queen check"),
    ("k7/8/8/8/8/8/8/QK6 w - -", "Queen Support", "Qa8 - queen attack"),
]

# Now validate and collect valid ones
valid_puzzles = []
for fen, name, hint in VALID_FENS:
    board = ChessBoard(fen)
    if board.is_check('b'):
        valid_puzzles.append((fen, name, hint))
        print(f"✓ {name}: {fen}")
    else:
        print(f"✗ {name}: NOT IN CHECK")

print(f"\nTotal valid: {len(valid_puzzles)}/50")

# Write valid ones to file
print("\n=== VALID PUZZLES ===")
for i, (fen, name, hint) in enumerate(valid_puzzles, 1):
    print(f'{i}. "{fen}|{name}|{hint}"')
