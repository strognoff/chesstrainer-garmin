// Chess board logic - FEN parsing and basic move handling
class BoardLogic {
    // Unicode chess pieces
    static const WHITE_KING = "♔";
    static const WHITE_QUEEN = "♕";
    static const WHITE_ROOK = "♖";
    static const WHITE_BISHOP = "♗";
    static const WHITE_KNIGHT = "♘";
    static const WHITE_PAWN = "♙";
    static const BLACK_KING = "♚";
    static const BLACK_QUEEN = "♛";
    static const BLACK_ROOK = "♜";
    static const BLACK_BISHOP = "♝";
    static const BLACK_KNIGHT = "♞";
    static const BLACK_PAWN = "♟";

    // Parse FEN to 8x8 board array
    static function parseFen(fen) {
        var parts = fen.split(" ");
        var position = parts[0];
        var ranks = position.split("/");
        
        var board = [];
        
        for (var i = 0; i < 8; i++) {
            var rank = ranks[i];
            var row = [];
            for (var j = 0; j < rank.length(); j++) {
                var c = rank.substring(j, j + 1);
                if (c.equals(" ") || c.length() == 0) {
                    continue;
                }
                var digit = c.toNumber();
                if (digit != null) {
                    // Add empty squares
                    for (var k = 0; k < digit; k++) {
                        row.add(null);
                    }
                } else {
                    row.add(c);
                }
            }
            board.add(row);
        }
        
        return {
            "board" => board,
            "sideToMove" => parts.size() > 1 ? parts[1] : "w"
        };
    }

    // Get piece character for display
    static function getPieceChar(fenChar) {
        if (fenChar == null) {
            return " ";
        }
        
        // Convert FEN to Unicode
        if (fenChar.equals("K")) { return WHITE_KING; }
        if (fenChar.equals("Q")) { return WHITE_QUEEN; }
        if (fenChar.equals("R")) { return WHITE_ROOK; }
        if (fenChar.equals("B")) { return WHITE_BISHOP; }
        if (fenChar.equals("N")) { return WHITE_KNIGHT; }
        if (fenChar.equals("P")) { return WHITE_PAWN; }
        if (fenChar.equals("k")) { return BLACK_KING; }
        if (fenChar.equals("q")) { return BLACK_QUEEN; }
        if (fenChar.equals("r")) { return BLACK_ROOK; }
        if (fenChar.equals("b")) { return BLACK_BISHOP; }
        if (fenChar.equals("n")) { return BLACK_KNIGHT; }
        if (fenChar.equals("p")) { return BLACK_PAWN; }
        
        return " ";
    }

    // Check if square is light or dark
    static function isLightSquare(row, col) {
        return (row + col) % 2 == 1;
    }

    // Find piece on board
    static function findPiece(board, piece) {
        for (var r = 0; r < 8; r++) {
            for (var c = 0; c < 8; c++) {
                if (board[r][c] != null && board[r][c].equals(piece)) {
                    return {"row" => r, "col" => c};
                }
            }
        }
        return null;
    }

    // Get all pieces of a color
    static function getPiecesOfColor(board, color) {
        var pieces = [];
        for (var r = 0; r < 8; r++) {
            for (var c = 0; c < 8; c++) {
                var piece = board[r][c];
                if (piece != null) {
                    var isWhite = piece.equals(piece.toUpperCase());
                    if ((color == "white" && isWhite) || (color == "black" && !isWhite)) {
                        pieces.add({"piece" => piece, "row" => r, "col" => c});
                    }
                }
            }
        }
        return pieces;
    }
}
