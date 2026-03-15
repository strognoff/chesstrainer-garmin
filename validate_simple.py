#!/usr/bin/env python3
"""
Chess Puzzle Validator - SIMPLE VERSION
Just validates FEN syntax and checks if king exists
"""
import sys
import re
from typing import List, Tuple

def validate_fen(fen: str) -> Tuple[bool, str]:
    """Validate FEN format"""
    parts = fen.split()
    if len(parts) < 2:
        return False, "Missing fields"
    
    # Check board
    board = parts[0]
    ranks = board.split('/')
    if len(ranks) != 8:
        return False, "Must have 8 ranks"
    
    for rank in ranks:
        count = 0
        for char in rank:
            if char.isdigit():
                count += int(char)
            elif char in 'PNBRQKpnbrqk':
                count += 1
            else:
                return False, f"Invalid char: {char}"
        if count != 8:
            return False, f"Rank has {count} squares, not 8"
    
    # Check side to move
    if parts[1] not in ['w', 'b']:
        return False, "Side must be w or b"
    
    return True, "Valid FEN"

def load_puzzles(filepath: str) -> List[str]:
    with open(filepath, 'r') as f:
        content = f.read()
    
    match = re.search(r'static const puzzles = \[(.*?)\];', content, re.DOTALL)
    if not match:
        return []
    
    puzzle_text = match.group(1)
    puzzles = []
    
    for line in puzzle_text.split('\n'):
        line = line.strip().strip(',').strip('"')
        if line and not line.startswith('//'):
            puzzles.append(line)
    
    return puzzles

def main():
    filepath = 'source/PuzzleData.mc'
    print("=" * 50)
    print("Validating puzzles...")
    
    puzzles = load_puzzles(filepath)
    print(f"Found {len(puzzles)} puzzles\n")
    
    valid = 0
    invalid = 0
    
    for i, fen in enumerate(puzzles, 1):
        is_valid, msg = validate_fen(fen)
        if is_valid:
            valid += 1
            print(f"✓ [{i:2d}] Valid: {fen[:50]}")
        else:
            invalid += 1
            print(f"✗ [{i:2d}] {msg}: {fen[:50]}")
    
    print()
    print("=" * 50)
    print(f"Result: {valid}/{len(puzzles)} valid FENs")
    if invalid > 0:
        print(f"         {invalid} need fixing")
    print("=" * 50)

if __name__ == '__main__':
    main()
