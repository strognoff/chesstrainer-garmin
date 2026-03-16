#!/usr/bin/env python3
"""
Chess Puzzle Analyzer

Analyzes each puzzle and generates educational documentation about
what tactical concept each puzzle teaches.
"""

import chess
import re


def extract_puzzle_data(filepath):
    """Extract puzzle data from PuzzleData.mc file."""
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Extract puzzles array
    puzzles_match = re.search(r'static const puzzles = \[(.*?)\];', content, re.DOTALL)
    puzzles_str = puzzles_match.group(1)
    puzzles = re.findall(r'"([^"]+)"', puzzles_str)
    
    # Extract solution moves
    solutions_match = re.search(r'static const solutionMoves = \[(.*?)\];', content, re.DOTALL)
    solutions_str = solutions_match.group(1)
    solutions = re.findall(r'"([^"]+)"', solutions_str)
    
    # Extract puzzle names
    names_match = re.search(r'static const puzzleNames = \[(.*?)\];', content, re.DOTALL)
    names_str = names_match.group(1)
    names = re.findall(r'"([^"]+)"', names_str)
    
    return puzzles, solutions, names


def analyze_puzzle(fen, solution_uci, name, index):
    """Analyze a single puzzle and determine what it teaches."""
    board = chess.Board(fen)
    move = chess.Move.from_uci(solution_uci)
    
    # Get piece that's moving
    moving_piece = board.piece_at(move.from_square)
    piece_name = chess.piece_name(moving_piece.piece_type).title()
    
    # Check if it's a capture
    is_capture = board.is_capture(move)
    captured_piece = None
    if is_capture:
        captured_piece = board.piece_at(move.to_square)
        if captured_piece:
            captured_name = chess.piece_name(captured_piece.piece_type).title()
    
    # Make the move and analyze the result
    board.push(move)
    
    is_check = board.is_check()
    is_checkmate = board.is_checkmate()
    
    # Count material
    material_count = len(board.piece_map())
    
    # Determine educational concept
    concept = determine_concept(
        moving_piece, is_capture, is_check, is_checkmate, 
        material_count, name, fen, solution_uci
    )
    
    # Create description
    description = create_description(
        piece_name, move, is_capture, is_check, is_checkmate,
        captured_piece, name, concept, board
    )
    
    return {
        'number': index + 1,
        'name': name,
        'fen': fen,
        'solution': solution_uci,
        'piece': piece_name,
        'concept': concept,
        'description': description,
        'is_checkmate': is_checkmate,
        'is_check': is_check,
        'is_capture': is_capture,
        'material_count': material_count
    }


def determine_concept(moving_piece, is_capture, is_check, is_checkmate, 
                     material_count, name, fen, solution_uci):
    """Determine the main tactical/educational concept."""
    
    piece_type = moving_piece.piece_type
    
    # Checkmate patterns
    if is_checkmate:
        if piece_type == chess.QUEEN:
            return "Queen Checkmate Pattern"
        elif piece_type == chess.ROOK:
            return "Rook Checkmate Pattern"
        return "Checkmate Pattern"
    
    # Check patterns
    if is_check:
        if material_count <= 5:  # Endgame
            return "Endgame Check Technique"
        else:
            return "Attacking Check"
    
    # Scholar's mate and early game tactics
    if "Scholar" in name or "f3f7" in solution_uci or "f7" in solution_uci and "f3" in solution_uci:
        return "Scholar's Mate (Checkmate Attack)"
    
    # Captures and sacrifices
    if is_capture:
        if "Sac" in name or "Sacrifice" in name:
            return "Sacrificial Attack"
        if "Bishop" in name and piece_type == chess.BISHOP:
            return "Bishop Capture"
        return "Tactical Capture"
    
    # Piece-specific tactics
    if piece_type == chess.KNIGHT:
        if "Fork" in name:
            return "Knight Fork (Double Attack)"
        return "Knight Tactics"
    
    if piece_type == chess.BISHOP:
        return "Bishop Development & Control"
    
    if piece_type == chess.QUEEN:
        if material_count <= 6:
            return "Queen Endgame Technique"
        return "Queen Attack & Positioning"
    
    if piece_type == chess.ROOK:
        if "Back Rank" in name:
            return "Back Rank Weakness"
        if material_count <= 5:
            return "Rook Endgame Technique"
        return "Rook Activity"
    
    if piece_type == chess.PAWN:
        return "Pawn Advancement"
    
    return "Tactical Move"


def create_description(piece_name, move, is_capture, is_check, is_checkmate,
                      captured_piece, name, concept, board):
    """Create a human-readable description of what the puzzle teaches."""
    
    from_sq = chess.square_name(move.from_square)
    to_sq = chess.square_name(move.to_square)
    
    # Build description based on concept
    if "Checkmate" in concept:
        return f"Delivers checkmate by moving {piece_name} from {from_sq} to {to_sq}. Teaches decisive finishing moves."
    
    if "Scholar's Mate" in concept:
        return f"Classic Scholar's Mate pattern - Queen takes f7 with checkmate. Teaches early game attacking patterns and the importance of defending f7/f2."
    
    if "Fork" in concept:
        return f"Knight fork technique - attacking multiple pieces simultaneously. Teaches the power of knight positioning."
    
    if "Back Rank" in concept:
        return f"Exploits back rank weakness with Queen attack. Teaches importance of king safety and escape squares."
    
    if "Sacrifice" in concept:
        cap_name = chess.piece_name(captured_piece.piece_type).title() if captured_piece else "piece"
        return f"Sacrifices {piece_name} for {cap_name} to gain tactical advantage. Teaches material sacrifice for position."
    
    if is_check and "Endgame" in concept:
        return f"Uses {piece_name} check to restrict the king's movement. Teaches endgame technique and king restriction."
    
    if is_capture:
        cap_name = chess.piece_name(captured_piece.piece_type).title() if captured_piece else "piece"
        return f"Captures {cap_name} with {piece_name}. Teaches tactical awareness and piece exchanges."
    
    if "Pawn" in piece_name:
        return f"Advances pawn from {from_sq} to {to_sq}. Teaches pawn structure and advancement techniques."
    
    if "Queen" in concept and "Position" in concept:
        return f"Develops Queen to {to_sq} for attacking position. Teaches piece coordination and attacking play."
    
    if "Bishop" in piece_name:
        return f"Develops Bishop to {to_sq} for diagonal control. Teaches bishop activity and long-range pieces."
    
    if "Knight" in piece_name:
        return f"Repositions Knight to {to_sq}. Teaches knight mobility and tactical positioning."
    
    if "Rook" in piece_name:
        return f"Activates Rook to {to_sq}. Teaches rook placement and file/rank control."
    
    return f"Moves {piece_name} from {from_sq} to {to_sq}. Teaches tactical awareness."


def generate_markdown_documentation(puzzles_data):
    """Generate markdown documentation for all puzzles."""
    
    # Group puzzles by concept
    concepts = {}
    for p in puzzles_data:
        concept = p['concept']
        if concept not in concepts:
            concepts[concept] = []
        concepts[concept].append(p)
    
    # Generate markdown
    md = "# Chess Puzzles - Educational Guide\n\n"
    md += "This document provides detailed information about all 51 chess puzzles in ChessTrainer.\n\n"
    
    # Summary statistics
    md += "## Summary\n\n"
    md += f"- **Total Puzzles**: {len(puzzles_data)}\n"
    md += f"- **Checkmate Puzzles**: {sum(1 for p in puzzles_data if p['is_checkmate'])}\n"
    md += f"- **Check Puzzles**: {sum(1 for p in puzzles_data if p['is_check'] and not p['is_checkmate'])}\n"
    md += f"- **Tactical Puzzles**: {sum(1 for p in puzzles_data if not p['is_check'])}\n"
    md += f"- **Unique Concepts**: {len(concepts)}\n\n"
    
    # Concepts breakdown
    md += "## Concepts Covered\n\n"
    for concept, plist in sorted(concepts.items(), key=lambda x: -len(x[1])):
        md += f"- **{concept}**: {len(plist)} puzzles\n"
    md += "\n"
    
    # Detailed puzzle list
    md += "## All Puzzles\n\n"
    
    for p in puzzles_data:
        md += f"### Puzzle #{p['number']}: {p['name']}\n\n"
        md += f"- **Concept**: {p['concept']}\n"
        md += f"- **Solution**: Move {p['piece']} ({p['solution']})\n"
        md += f"- **Outcome**: "
        if p['is_checkmate']:
            md += "Checkmate ✓\n"
        elif p['is_check']:
            md += "Check\n"
        else:
            md += "Tactical advantage\n"
        md += f"- **What it teaches**: {p['description']}\n"
        md += f"- **Position (FEN)**: `{p['fen']}`\n"
        md += "\n"
    
    return md


def main():
    filepath = "source/PuzzleData.mc"
    
    print("Analyzing puzzles...")
    puzzles, solutions, names = extract_puzzle_data(filepath)
    
    puzzles_data = []
    for i in range(len(puzzles)):
        analysis = analyze_puzzle(puzzles[i], solutions[i], names[i], i)
        puzzles_data.append(analysis)
        print(f"  Analyzed #{i+1}: {names[i]}")
    
    print(f"\nGenerating documentation...")
    markdown = generate_markdown_documentation(puzzles_data)
    
    # Write to file
    output_file = "PUZZLES.md"
    with open(output_file, 'w') as f:
        f.write(markdown)
    
    print(f"✓ Documentation written to {output_file}")
    
    # Also return data for README update
    return puzzles_data, markdown


if __name__ == "__main__":
    main()
