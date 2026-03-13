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
    static function splitString(str as String, delimiter as String) as Lang.Array {
        var result = new [0] as Lang.Array;
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
    static function parseFen(fen as String) as Lang.Dictionary {
        var parts = splitString(fen, " ");
        var position = parts[0] as String;
        var ranks = splitString(position, "/");
        
        var board = new [8] as Lang.Array;
        
        for (var i = 0; i < 8; i++) {
            var rank = ranks[i] as String;
            var row = new [8] as Lang.Array;
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
    static function findPiece(board as Lang.Array, piece as String) as Lang.Dictionary? {
        for (var r = 0; r < 8; r++) {
            var row = board[r] as Lang.Array;
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
    static function getPiecesOfColor(board as Lang.Array, color as String) as Lang.Array {
        var pieces = new [0] as Lang.Array;
        for (var r = 0; r < 8; r++) {
            var row = board[r] as Lang.Array;
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
}
