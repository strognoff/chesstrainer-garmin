#!/usr/bin/env python3
"""
Chess Puzzle Validator

Validates all chess puzzles in PuzzleData.mc:
- Checks FEN position validity
- Verifies solution moves are legal
- Validates data array consistency
- Reports any issues found
"""

import re
import sys

try:
    import chess
except ImportError:
    print("Error: python-chess library not installed")
    print("Install with: pip install chess")
    sys.exit(1)


def extract_puzzle_data(filepath):
    """Extract puzzle data from PuzzleData.mc file."""
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Extract puzzles array
    puzzles_match = re.search(r'static const puzzles = \[(.*?)\];', content, re.DOTALL)
    if not puzzles_match:
        raise ValueError("Could not find puzzles array")
    
    puzzles_str = puzzles_match.group(1)
    puzzles = re.findall(r'"([^"]+)"', puzzles_str)
    
    # Extract solution moves
    solutions_match = re.search(r'static const solutionMoves = \[(.*?)\];', content, re.DOTALL)
    if not solutions_match:
        raise ValueError("Could not find solutionMoves array")
    
    solutions_str = solutions_match.group(1)
    solutions = re.findall(r'"([^"]+)"', solutions_str)
    
    # Extract puzzle names
    names_match = re.search(r'static const puzzleNames = \[(.*?)\];', content, re.DOTALL)
    if not names_match:
        raise ValueError("Could not find puzzleNames array")
    
    names_str = names_match.group(1)
    names = re.findall(r'"([^"]+)"', names_str)
    
    return puzzles, solutions, names


def validate_fen(fen, index):
    """Validate a FEN position."""
    try:
        board = chess.Board(fen)
        return True, board, None
    except ValueError as e:
        return False, None, f"Invalid FEN: {e}"


def validate_move(board, uci_move, index):
    """Validate that a move is legal in the given position."""
    try:
        move = chess.Move.from_uci(uci_move)
        if move not in board.legal_moves:
            return False, f"Move {uci_move} is not legal in this position"
        return True, None
    except ValueError as e:
        return False, f"Invalid UCI move format: {e}"


def analyze_position_after_move(board, uci_move):
    """Analyze the position after making the move."""
    move = chess.Move.from_uci(uci_move)
    board.push(move)
    
    info = {
        'is_checkmate': board.is_checkmate(),
        'is_check': board.is_check(),
        'is_stalemate': board.is_stalemate(),
        'is_game_over': board.is_game_over()
    }
    
    board.pop()
    return info


def validate_all_puzzles(filepath):
    """Validate all puzzles and return detailed report."""
    print(f"Reading puzzle data from: {filepath}\n")
    
    try:
        puzzles, solutions, names = extract_puzzle_data(filepath)
    except Exception as e:
        print(f"Error reading file: {e}")
        return False
    
    # Check array lengths
    print(f"Found {len(puzzles)} puzzles")
    print(f"Found {len(solutions)} solutions")
    print(f"Found {len(names)} names\n")
    
    issues = []
    
    if len(puzzles) != len(solutions):
        issues.append(f"Array length mismatch: {len(puzzles)} puzzles vs {len(solutions)} solutions")
    
    if len(puzzles) != len(names):
        issues.append(f"Array length mismatch: {len(puzzles)} puzzles vs {len(names)} names")
    
    if issues:
        print("CRITICAL ISSUES:")
        for issue in issues:
            print(f"  ❌ {issue}")
        print()
    
    # Validate each puzzle
    print("Validating individual puzzles...")
    print("=" * 80)
    
    all_valid = True
    checkmate_count = 0
    check_count = 0
    
    for i in range(len(puzzles)):
        fen = puzzles[i]
        solution = solutions[i] if i < len(solutions) else None
        name = names[i] if i < len(names) else None
        
        print(f"\nPuzzle #{i + 1}: {name}")
        print(f"  FEN: {fen}")
        print(f"  Solution: {solution}")
        
        # Validate FEN
        fen_valid, board, fen_error = validate_fen(fen, i)
        if not fen_valid:
            print(f"  ❌ {fen_error}")
            all_valid = False
            continue
        else:
            print(f"  ✓ FEN is valid")
        
        # Validate solution move
        if solution:
            move_valid, move_error = validate_move(board, solution, i)
            if not move_valid:
                print(f"  ❌ {move_error}")
                all_valid = False
                
                # Show legal moves for debugging
                legal_moves = list(board.legal_moves)
                print(f"  Legal moves: {', '.join([m.uci() for m in legal_moves[:10]])}")
                if len(legal_moves) > 10:
                    print(f"  ... and {len(legal_moves) - 10} more")
            else:
                print(f"  ✓ Solution move is legal")
                
                # Analyze position after move
                analysis = analyze_position_after_move(board, solution)
                
                if analysis['is_checkmate']:
                    print(f"  ✓ Solution leads to CHECKMATE")
                    checkmate_count += 1
                elif analysis['is_check']:
                    print(f"  ℹ Solution gives CHECK")
                    check_count += 1
                else:
                    print(f"  ℹ Solution does not give check/mate (tactical move)")
        else:
            print(f"  ⚠ No solution provided")
            all_valid = False
    
    # Summary
    print("\n" + "=" * 80)
    print("VALIDATION SUMMARY")
    print("=" * 80)
    print(f"Total puzzles: {len(puzzles)}")
    print(f"Checkmate puzzles: {checkmate_count}")
    print(f"Check puzzles: {check_count}")
    print(f"Tactical puzzles: {len(puzzles) - checkmate_count - check_count}")
    
    if all_valid and not issues:
        print("\n✓ ALL PUZZLES ARE VALID AND LEGAL!")
        return True
    else:
        print("\n❌ VALIDATION FAILED - Issues found above")
        return False


if __name__ == "__main__":
    filepath = "source/PuzzleData.mc"
    
    # Allow custom filepath as command line argument
    if len(sys.argv) > 1:
        filepath = sys.argv[1]
    
    success = validate_all_puzzles(filepath)
    sys.exit(0 if success else 1)
