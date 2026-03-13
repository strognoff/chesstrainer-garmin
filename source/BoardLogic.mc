// Chess board logic - FEN parsing and basic move handling
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

    // Parse FEN to 8x8 board array
    static function parseFen(fen as String) as Dictionary {
        var parts = fen.split(" ");
        var position = parts[0];
        var ranks = position.split("/");
        
        var board = new [8] as Array;
        
        for (var i = 0; i < 8; i++) {
            var rank = ranks[i];
            var row = new [8] as Array;
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
            "sideToMove" => parts.size() > 1 ? parts[1] : "w"
        };
    }

    // Get piece character for display
    static function getPieceChar(fenChar as String?) as String {
        if (fenChar == null) {
            return " ";
        }
        
        // Return the FEN character as-is
        return fenChar;
    }

    // Check if square is light or dark
    static function isLightSquare(row as Number, col as Number) as Boolean {
        return (row + col) % 2 == 1;
    }

    // Find piece on board
    static function findPiece(board as Array, piece as String) as Dictionary? {
        for (var r = 0; r < 8; r++) {
            var row = board[r] as Array;
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
    static function getPiecesOfColor(board as Array, color as String) as Array {
        var pieces = new [0] as Array;
        for (var r = 0; r < 8; r++) {
            var row = board[r] as Array;
            for (var c = 0; c < 8; c++) {
                var piece = row[c];
                if (piece != null) {
                    // Check if piece is uppercase (white) or lowercase (black)
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
        // Get character codes
        var c = str.charAt(0);
        var code = c.toNumber();
        if (code != null) {
            // A-Z is 65-90, a-z is 97-122
            return code >= 65 && code <= 90;
        }
        return false;
    }
}
