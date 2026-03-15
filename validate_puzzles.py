#!/usr/bin/env python3
"""
Chess Puzzle Validator
Validates Mate-in-1 puzzles
"""
import sys
import re
from typing import List, Tuple, Optional, Dict

class ChessBoard:
    """Simple chess board representation"""
    
    def __init__(self, fen: str):
        self.fen = fen
        self.board = self.parse_fen(fen)
        
    def parse_fen(self, fen: str) -> List[List[Optional[str]]]:
        """Parse FEN string to 8x8 board"""
        parts = fen.split()[0].split('/')
        board = []
        
        for rank in parts:
            row = []
            for char in rank:
                if char.isdigit():
                    row.extend([None] * int(char))
                else:
                    row.append(char)
            while len(row) < 8:
                row.append(None)
            board.append(row)
            
        return board
    
    def find_king(self, color: str) -> Tuple[int, int]:
        """Find king position (w=white, b=black)"""
        target = 'K' if color == 'w' else 'k'
        for r in range(8):
            for c in range(8):
                if self.board[r][c] == target:
                    return (r, c)
        return (-1, -1)
    
    def is_attacked(self, row: int, col: int, by_color: str) -> bool:
        """Check if square is attacked by given color"""
        
        # Check pawn attacks
        pawn_dir = -1 if by_color == 'w' else 1
        pawn = 'P' if by_color == 'w' else 'p'
        for dc in [-1, 1]:
            nr, nc = row + pawn_dir, col + dc
            if 0 <= nr < 8 and 0 <= nc < 8:
                if self.board[nr][nc] == pawn:
                    return True
        
        # Check knight attacks
        knight = 'N' if by_color == 'w' else 'n'
        for dr, dc in [(-2,-1),(-2,1),(-1,-2),(-1,2),(1,-2),(1,2),(2,-1),(2,1)]:
            nr, nc = row + dr, col + dc
            if 0 <= nr < 8 and 0 <= nc < 8:
                if self.board[nr][nc] == knight:
                    return True
        
        # Check diagonal attacks (bishop/queen)
        for dr, dc in [(-1,-1),(-1,1),(1,-1),(1,1)]:
            for i in range(1, 8):
                nr, nc = row + dr*i, col + dc*i
                if not (0 <= nr < 8 and 0 <= nc < 8):
                    break
                piece = self.board[nr][nc]
                if piece:
                    if (by_color == 'w' and piece in ('B', 'Q')) or \
                       (by_color == 'b' and piece in ('b', 'q')):
                        return True
                    if piece not in ('.', None):
                        break
        
        # Check straight attacks (rook/queen)
        for dr, dc in [(-1,0),(1,0),(0,-1),(0,1)]:
            for i in range(1, 8):
                nr, nc = row + dr*i, col + dc*i
                if not (0 <= nr < 8 and 0 <= nc < 8):
                    break
                piece = self.board[nr][nc]
                if piece:
                    if (by_color == 'w' and piece in ('R', 'Q')) or \
                       (by_color == 'b' and piece in ('r', 'q')):
                        return True
                    if piece not in ('.', None):
                        break
        
        # Check king attacks
        king = 'K' if by_color == 'w' else 'k'
        for dr in [-1, 0, 1]:
            for dc in [-1, 0, 1]:
                if dr == 0 and dc == 0:
                    continue
                nr, nc = row + dr, col + dc
                if 0 <= nr < 8 and 0 <= nc < 8:
                    if self.board[nr][nc] == king:
                        return True
        
        return False
    
    def is_check(self, color: str) -> bool:
        """Check if given color's king is in check"""
        king_row, king_col = self.find_king(color)
        if king_row == -1:
            return False
        enemy = 'b' if color == 'w' else 'w'
        return self.is_attacked(king_row, king_col, enemy)
    
    def is_checkmate(self, color: str) -> bool:
        """Check if given color is in checkmate"""
        if not self.is_check(color):
            return False
            
        king_row, king_col = self.find_king(color)
        enemy = 'b' if color == 'w' else 'w'
        
        # Check if king can escape
        for dr in [-1, 0, 1]:
            for dc in [-1, 0, 1]:
                if dr == 0 and dc == 0:
                    continue
                nr, nc = king_row + dr, king_col + dc
                if 0 <= nr < 8 and 0 <= nc < 8:
                    piece = self.board[nr][nc]
                    can_move = (piece is None) or \
                               (color == 'w' and piece.islower()) or \
                               (color == 'b' and piece.isupper())
                    if can_move and not self.is_attacked(nr, nc, enemy):
                        return False
                            
        return True


def load_puzzles_from_file(filepath: str) -> List[str]:
    """Load puzzle FENs from source file"""
    puzzles = []
    
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Find the puzzles array - simplified format (just FENs)
    match = re.search(r'static const puzzles = \[(.*?)\];', content, re.DOTALL)
    if not match:
        print("No puzzles found!")
        return []
    
    puzzle_text = match.group(1)
    
    for line in puzzle_text.split('\n'):
        line = line.strip().strip(',').strip('"')
        if line and not line.startswith('//'):
            puzzles.append(line)
    
    return puzzles


def validate_puzzle(fen: str) -> Tuple[bool, str]:
    """Validate a single puzzle"""
    try:
        parts = fen.split()
        if len(parts) < 2:
            return False, "Invalid FEN format"
        
        side_to_move = parts[1]
        board = ChessBoard(fen)
        
        if not board.is_check(side_to_move):
            return False, f"Position has no check"
        
        if not board.is_checkmate(side_to_move):
            return False, f"Not checkmate"
        
        return True, "Valid mate-in-1"
        
    except Exception as e:
        return False, str(e)


def main():
    filepath = 'source/PuzzleData.mc'
    
    print("=" * 60)
    print("Chess Puzzle Validator - Mate-in-1")
    print("=" * 60)
    print(f"Loading puzzles from {filepath}...\n")
    
    puzzles = load_puzzles_from_file(filepath)
    
    if not puzzles:
        print("No puzzles found!")
        return 1
    
    print(f"Found {len(puzzles)} puzzles\n")
    
    valid = 0
    invalid = 0
    
    for i, fen in enumerate(puzzles, 1):
        is_valid, msg = validate_puzzle(fen)
        
        if is_valid:
            print(f"✓ [{i:2d}] {fen[:50]:<50} - {msg}")
            valid += 1
        else:
            print(f"✗ [{i:2d}] {fen[:50]:<50} - {msg}")
            invalid += 1
    
    print()
    print("=" * 60)
    print(f"RESULT: {valid}/{len(puzzles)} puzzles valid")
    if invalid > 0:
        print(f"         {invalid} puzzles need fixing")
    print("=" * 60)
    
    return 0 if invalid == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
