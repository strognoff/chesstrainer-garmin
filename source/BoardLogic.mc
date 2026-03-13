import Toybox.Lang;

class BoardLogic {
    // Unicode chess pieces
    const WHITE_KING = "K";
    const WHITE_QUEEN = "Q";
    const WHITE_ROOK = "R";
    const WHITE_BISHOP = "B";
    const WHITE_KNIGHT = "N";
    const WHITE_PAWN = "P";
    const BLACK_KING = "k";
    const BLACK_QUEEN = "q";
    const BLACK_ROOK = "r";
    const BLACK_BISHOP = "b";
    const BLACK_KNIGHT = "n";
    const BLACK_PAWN = "p";

    // Simple split by delimiter
    static function splitString(str as String, delimiter as String) as Array<String> {
        var result = new [0] as Array<String>;
        var current = "";
        
        for (var i = 0; i < str.length(); i++) {
            var c = str.substring(i, i + 1);
            if (c.equals(delimiter)) {
                result.add(current);
                current = "";
            } else {
                current = current + c;
            }
        }
        result.add(current);
        return result;
    }

    // Parse FEN to 8x8 board array
    static function parseFen(fen as String) as Dictionary {
        var parts = splitString(fen, " ");
        var position = parts[0] as String;
        var ranks = splitString(position, "/");
        
        var board = new [8] as Array<Array<String?>>;
        
        for (var i = 0; i < 8; i++) {
            var rank = ranks[i] as String;
            var row = new [8] as Array<String?>;
            var colIdx = 0;
            
            for (var j = 0; j < rank.length(); j++) {
                var c = rank.substring(j, j + 1);
                
                var digit = c.toNumber();
                if (digit != null) {
                    // Add empty squares
                    for (var k = 0; k < digit; k++) {
                        row[colIdx] = null;
                        colIdx++;
                    }
                } else {
                    row[colIdx] = c;
                    colIdx++;
                }
            }
            board[i] = row;
        }
        
        return {
            "board" => board,
            "sideToMove" => parts.size() > 1 ? (parts[1] as String) : "w"
        };
    }

    // Get piece character for display
    static function getPieceChar(fenChar as String?) as String {
        if (fenChar == null) {
            return " ";
        }
        return fenChar;
    }

    // Check if square is light or dark
    static function isLightSquare(row as Number, col as Number) as Boolean {
        return (row + col) % 2 == 1;
    }

    // Find piece on board
    static function findPiece(board as Array<Array<String?>>, piece as String) as Dictionary? {
        for (var r = 0; r < 8; r++) {
            var row = board[r];
            for (var c = 0; c < 8; c++) {
                var p = row[c];
                if (p != null && p.equals(piece)) {
                    return {"row" => r, "col" => c};
                }
            }
        }
        return null;
    }

    // Get all pieces of a color
    static function getPiecesOfColor(board as Array<Array<String?>>, color as String) as Array<Dictionary> {
        var pieces = new [0] as Array<Dictionary>;
        for (var r = 0; r < 8; r++) {
            var row = board[r];
            for (var c = 0; c < 8; c++) {
                var piece = row[c];
                if (piece != null) {
                    var isWhite = isUpperCase(piece);
                    if ((color.equals("white") && isWhite) || (color.equals("black") && !isWhite)) {
                        pieces.add({"piece" => piece, "row" => r, "col" => c});
                    }
                }
            }
        }
        return pieces;
    }
    
    // Helper to check if character is uppercase
    static function isUpperCase(str as String) as Boolean {
        var c = str.substring(0, 1);
        var code = c.toNumber();
        if (code != null) {
            return code >= 65 && code <= 90;
        }
        return false;
    }
    
    // Validate if a move is legal for a piece
    static function isValidMove(piece as String, fromRow as Number, fromCol as Number, toRow as Number, toCol as Number, board as Array<Array<String?>>, sideToMove as String) as Boolean {
        if (piece == null || piece.equals(" ") || toRow < 0 || toRow > 7 || toCol < 0 || toCol > 7) {
            return false;
        }
        
        var isWhitePiece = isUpperCase(piece);
        var expectedSide = sideToMove.equals("w") ? "white" : "black";
        
        // Check if piece belongs to current player
        if ((expectedSide.equals("white") && !isWhitePiece) || (expectedSide.equals("black") && isWhitePiece)) {
            return false;
        }
        
        var pieceType = piece.toUpper();
        var dr = toRow - fromRow;
        var dc = toCol - fromCol;
        var absDr = dr < 0 ? -dr : dr;
        var absDc = dc < 0 ? -dc : dc;
        
        // Pawn moves
        if (pieceType.equals("P")) {
            var direction = isWhitePiece ? -1 : 1;
            if (dc == 0 && dr == direction && board[toRow][toCol] == null) {
                return true;
            }
            if (dc == 0 && dr == 2 * direction && fromRow == (isWhitePiece ? 6 : 1) && board[toRow][toCol] == null) {
                return true;
            }
            if (absDc == 1 && dr == direction) {
                var target = board[toRow][toCol];
                if (target != null) {
                    var targetIsWhite = isUpperCase(target);
                    return targetIsWhite != isWhitePiece;
                }
            }
            return false;
        }
        
        // Knight moves (L-shape)
        if (pieceType.equals("N")) {
            return (absDr == 2 && absDc == 1) || (absDr == 1 && absDc == 2);
        }
        
        // Bishop moves (diagonal)
        if (pieceType.equals("B")) {
            if (absDr != absDc) {
                return false;
            }
            return isPathClear(fromRow, fromCol, toRow, toCol, board);
        }
        
        // Rook moves (straight)
        if (pieceType.equals("R")) {
            if (dr != 0 && dc != 0) {
                return false;
            }
            return isPathClear(fromRow, fromCol, toRow, toCol, board);
        }
        
        // Queen moves (straight or diagonal)
        if (pieceType.equals("Q")) {
            if (dr != 0 && dc != 0 && absDr != absDc) {
                return false;
            }
            return isPathClear(fromRow, fromCol, toRow, toCol, board);
        }
        
        // King moves (one square)
        if (pieceType.equals("K")) {
            return absDr <= 1 && absDc <= 1;
        }
        
        return false;
    }
    
    // Check if path is clear for sliding pieces
    static function isPathClear(fromRow as Number, fromCol as Number, toRow as Number, toCol as Number, board as Array<Array<String?>>) as Boolean {
        var dr = toRow - fromRow;
        var dc = toCol - fromCol;
        var stepRow = (dr == 0) ? 0 : (dr > 0 ? 1 : -1);
        var stepCol = (dc == 0) ? 0 : (dc > 0 ? 1 : -1);
        
        var r = fromRow + stepRow;
        var c = fromCol + stepCol;
        
        if (r < 0 || r > 7 || c < 0 || c > 7) { return false; }
        while (r != toRow || c != toCol) {
            if (board[r][c] != null) {
                return false;
            }
            r += stepRow;
            c += stepCol;
        }
        
        return true;
    }
}
