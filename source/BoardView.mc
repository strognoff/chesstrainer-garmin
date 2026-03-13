import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Timer;

class BoardView extends WatchUi.View {
    var puzzleIndex as Number;
    var boardData as Dictionary;
    var timer as Timer.Timer?;
    var startTime as Number;
    var hintShown = false;
    var pieceBitmaps as Dictionary;
    
    // Move input state - sequential selection
    var cursorIndex as Number = 0;  // 0-63 for all squares (row*8+col)
    var selectedSquare as Number? = null;  // Index of selected square or null
    
    var showHint as Boolean = false;
    var hintMessage as String = "";

    function initialize(idx as Number) {
        WatchUi.View.initialize();
        puzzleIndex = idx;
        var fen = PuzzleData.getPuzzle(puzzleIndex);
        boardData = BoardLogic.parseFen(fen);
        startTime = System.getTimer();
        
        // Load all piece bitmaps once
        pieceBitmaps = {
            :WhiteKing => WatchUi.loadResource(Rez.Drawables.WhiteKing),
            :WhiteQueen => WatchUi.loadResource(Rez.Drawables.WhiteQueen),
            :WhiteRook => WatchUi.loadResource(Rez.Drawables.WhiteRook),
            :WhiteBishop => WatchUi.loadResource(Rez.Drawables.WhiteBishop),
            :WhiteKnight => WatchUi.loadResource(Rez.Drawables.WhiteKnight),
            :WhitePawn => WatchUi.loadResource(Rez.Drawables.WhitePawn),
            :BlackKing => WatchUi.loadResource(Rez.Drawables.BlackKing),
            :BlackQueen => WatchUi.loadResource(Rez.Drawables.BlackQueen),
            :BlackRook => WatchUi.loadResource(Rez.Drawables.BlackRook),
            :BlackBishop => WatchUi.loadResource(Rez.Drawables.BlackBishop),
            :BlackKnight => WatchUi.loadResource(Rez.Drawables.BlackKnight),
            :BlackPawn => WatchUi.loadResource(Rez.Drawables.BlackPawn)
        };
    }

    function onShow() as Void {
        timer = new Timer.Timer();
        timer.start(method(:onTimer), 1000, true);
    }

    function onHide() as Void {
        if (timer != null) {
            timer.stop();
            timer = null;
        }
    }

    function onTimer() as Void {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        // Clear
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw puzzle number and timer in header
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        var elapsed = (System.getTimer() - startTime) / 1000;
        var mins = elapsed / 60;
        var secs = elapsed % 60;
        var headerText = "#" + (puzzleIndex + 1) + " " + mins.format("%d") + ":" + secs.format("%02d");
        dc.drawText(width / 2, 5, Graphics.FONT_XTINY, headerText, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Calculate board area
        var boardSize = width - 60;
        if (boardSize > height - 70) {
            boardSize = height - 70;
        }
        
        var marginX = (width - boardSize) / 2;
        var marginY = (height - boardSize) / 2 + 5;
        var squareSize = boardSize / 8;
        
        var cursorRow = cursorIndex / 8;
        var cursorCol = cursorIndex % 8;
        
        // Draw chess board
        for (var row = 0; row < 8; row++) {
            for (var col = 0; col < 8; col++) {
                var x = marginX + col * squareSize;
                var y = marginY + row * squareSize;
                var squareIndex = row * 8 + col;
                
                // Draw square
                var isLight = BoardLogic.isLightSquare(row, col);
                var isCursor = (squareIndex == cursorIndex);
                var isSelected = (selectedSquare != null && selectedSquare == squareIndex);
                
                if (isSelected) {
                    // Selected square - highlight in yellow
                    dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_YELLOW);
                } else if (isCursor) {
                    // Cursor square - highlight in green
                    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_GREEN);
                } else if (isLight) {
                    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_LT_GRAY);
                } else {
                    dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
                }
                dc.fillRectangle(x, y, squareSize, squareSize);
                
                // Draw piece using bitmap
                var piece = boardData["board"][row][col];
                if (piece != null) {
                    var drawableId = BoardLogic.getPieceDrawableId(piece);
                    if (drawableId != null) {
                        var bitmap = pieceBitmaps[drawableId];
                        if (bitmap != null) {
                            // Center the bitmap in the square
                            var bitmapWidth = bitmap.getWidth();
                            var bitmapHeight = bitmap.getHeight();
                            var bitmapX = x + (squareSize - bitmapWidth) / 2;
                            var bitmapY = y + (squareSize - bitmapHeight) / 2;
                            dc.drawBitmap(bitmapX, bitmapY, bitmap);
                        }
                    }
                }
            }
        }
        
        // Draw feedback message if present (overlays the board)
        if (feedbackMessage != null && feedbackColor != null) {
            dc.setColor(feedbackColor, Graphics.COLOR_BLACK);
            dc.fillRectangle(width / 4, height / 2 - 20, width / 2, 40);
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(width / 2, height / 2, Graphics.FONT_MEDIUM, feedbackMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {
            // Draw controls hint at bottom (only if no feedback)
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
            var helpText = selectedSquare == null ? "UP/DN: Move OK: Select" : "UP/DN: Move OK: Confirm";
            dc.drawText(width / 2, height - 20, Graphics.FONT_XTINY, helpText, Graphics.TEXT_JUSTIFY_CENTER);
        }
        
        if (showHint) {
            drawHint(dc);
        }
    }
    
    function drawHint(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        // Semi-transparent overlay
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, height / 2 - 40, width, 80);
        
        // Draw border
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(5, height / 2 - 35, width - 10, 70);
        
        // Draw "HINT" title
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width / 2,
            height / 2 - 30,
            Graphics.FONT_SMALL,
            "HINT",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // Draw hint message
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width / 2,
            height / 2 - 5,
            Graphics.FONT_TINY,
            hintMessage,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // Draw instruction
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width / 2,
            height / 2 + 20,
            Graphics.FONT_XTINY,
            "Press ENTER to continue",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    function generateHint() as Void {
        var solution = PuzzleData.getSolution(puzzleIndex);
        
        if (solution != null && solution.length() >= 4) {
            var from = solution.substring(0, 2);
            var to = solution.substring(2, 4);
            
            // Parse coordinates properly
            var fromFileChar = from.substring(0, 1);
            var fromRankChar = from.substring(1, 2);
            var toFileChar = to.substring(0, 1);
            var toRankChar = to.substring(1, 2);
            
            // Convert file letter to column (a=0, b=1, ..., h=7)
            var fromCol = fromFileChar.toCharArray()[0].toNumber() - 97;
            var toCol = toFileChar.toCharArray()[0].toNumber() - 97;
            
            // Convert rank to row - FEN uses rank 8 at top (row 0), rank 1 at bottom (row 7)
            var fromRankNum = parseRank(fromRankChar);
            var toRankNum = parseRank(toRankChar);
            var fromRow = 8 - fromRankNum;
            var toRow = 8 - toRankNum;
            
            // Validate coordinates are in bounds
            if (fromRow >= 0 && fromRow < 8 && fromCol >= 0 && fromCol < 8) {
                var piece = boardData["board"][fromRow][fromCol];
                
                if (piece != null) {
                    var pieceName = getPieceName(piece);
                    hintMessage = pieceName + " " + from.toUpper() + " to " + to.toUpper();
                } else {
                    // No piece at source - scan nearby squares for similar pieces
                    var alternativePiece = findNearbyPiece(fromRow, fromCol, toRow, toCol);
                    if (alternativePiece != null) {
                        var altPieceName = getPieceName(alternativePiece["piece"]);
                        hintMessage = altPieceName + " " + alternativePiece["from"] + " to " + to.toUpper();
                    } else {
                        // Just show destination
                        hintMessage = "Move to " + to.toUpper();
                    }
                }
            } else {
                hintMessage = "Check the board carefully";
            }
        } else {
            hintMessage = "Try different moves";
        }
        
        showHint = true;
        hintShown = true;
        WatchUi.requestUpdate();
    }
    
    function hideHint() as Void {
        showHint = false;
        WatchUi.requestUpdate();
    }
    
    // Helper to parse rank character to number
    function parseRank(rankChar as String) as Number {
        if (rankChar.equals("1")) { return 1; }
        else if (rankChar.equals("2")) { return 2; }
        else if (rankChar.equals("3")) { return 3; }
        else if (rankChar.equals("4")) { return 4; }
        else if (rankChar.equals("5")) { return 5; }
        else if (rankChar.equals("6")) { return 6; }
        else if (rankChar.equals("7")) { return 7; }
        else if (rankChar.equals("8")) { return 8; }
        return 0;
    }
    
    // Helper to find a piece that could make the intended move
    function findNearbyPiece(fromRow as Number, fromCol as Number, toRow as Number, toCol as Number) as Dictionary? {
        var files = "abcdefgh";
        
        // Check adjacent squares (in case of notation error)
        var offsets = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]];
        
        for (var i = 0; i < offsets.size(); i++) {
            var checkRow = fromRow + offsets[i][0];
            var checkCol = fromCol + offsets[i][1];
            
            if (checkRow >= 0 && checkRow < 8 && checkCol >= 0 && checkCol < 8) {
                var piece = boardData["board"][checkRow][checkCol];
                if (piece != null) {
                    // Found a piece - return it
                    var fileChar = files.substring(checkCol, checkCol + 1);
                    var rankNum = 8 - checkRow;
                    return {
                        "piece" => piece,
                        "from" => fileChar + rankNum.toString()
                    };
                }
            }
        }
        
        return null;
    }
    
    // Add this helper method to get piece names
    function getPieceName(piece as String) as String {
        var firstChar = piece.substring(0, 1);
        
        if (firstChar.equals("K")) {
            return "King";
        } else if (firstChar.equals("Q")) {
            return "Queen";
        } else if (firstChar.equals("R")) {
            return "Rook";
        } else if (firstChar.equals("B")) {
            return "Bishop";
        } else if (firstChar.equals("N")) {
            return "Knight";
        } else if (firstChar.equals("P")) {
            return "Pawn";
        }
        
        return "Piece";
    }
    
    function moveCursor(delta as Number) as Void {
        cursorIndex = (cursorIndex + delta + 64) % 64;
        WatchUi.requestUpdate();
    }
    
    function selectSquare() as Void {
        if (selectedSquare == null) {
            // First selection - pick up piece
            var row = cursorIndex / 8;
            var col = cursorIndex % 8;
            var piece = boardData["board"][row][col];
            if (piece != null) {
                selectedSquare = cursorIndex;
                WatchUi.requestUpdate();
            }
        } else {
            // Second selection - make move
            var fromRow = selectedSquare / 8;
            var fromCol = selectedSquare % 8;
            var toRow = cursorIndex / 8;
            var toCol = cursorIndex % 8;
            
            // Convert to algebraic notation (e.g., "e2e4")
            var files = "abcdefgh";
            var fromFile = files.substring(fromCol, fromCol + 1);
            var fromRank = (8 - fromRow).toString();
            var toFile = files.substring(toCol, toCol + 1);
            var toRank = (8 - toRow).toString();
            var move = fromFile + fromRank + toFile + toRank;
            
            // Get the expected solution move
            var solution = PuzzleData.getSolution(puzzleIndex);
            
            var elapsed = (System.getTimer() - startTime) / 1000;
            
            if (move.equals(solution)) {
                // Correct move!
                Storage.markSolved(puzzleIndex, elapsed);
                showFeedback("Well done!", Graphics.COLOR_GREEN);
            } else {
                // Wrong move
                Storage.markIncorrect(puzzleIndex);
                showFeedback("Try again!", Graphics.COLOR_RED);
            }
            
            // Wait 2 seconds before returning to menu
            var feedbackTimer = new Timer.Timer();
            feedbackTimer.start(method(:exitPuzzle), 2000, false);
        }
    }
    
    var feedbackMessage as String? = null;
    var feedbackColor as Number? = null;
    
    function showFeedback(message as String, color as Number) as Void {
        feedbackMessage = message;
        feedbackColor = color;
        selectedSquare = null;
        WatchUi.requestUpdate();
    }
    
    function exitPuzzle() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}

class BoardDelegate extends WatchUi.InputDelegate {
    var puzzleIndex as Number;
    var view as BoardView;

    function initialize(idx as Number, boardView as BoardView) {
        WatchUi.InputDelegate.initialize();
        puzzleIndex = idx;
        view = boardView;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();
        
        // Handle MENU button for hint
        if (keyCode == WatchUi.KEY_MENU) {
            if (view.showHint) {
                // If hint is already showing, hide it
                view.hideHint();
            } else {
                // Show hint
                view.generateHint();
            }
            return true;
        }
        
        // Handle ENTER button
        if (keyCode == WatchUi.KEY_ENTER) {
            if (view.showHint) {
                // If hint is showing, close it and continue
                view.hideHint();
                return true;
            }
            view.selectSquare();
            return true;
        }
        
        // Handle ESC button
        if (keyCode == WatchUi.KEY_ESC) {
            if (view.showHint) {
                view.hideHint();
                return true;
            }
            if (view.selectedSquare != null) {
                // Cancel selection
                view.selectedSquare = null;
                WatchUi.requestUpdate();
                return true;
            }
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        
        if (keyCode == WatchUi.KEY_UP) {
            view.moveCursor(-1);  // Move to previous square (wraps around)
            return true;
        } else if (keyCode == WatchUi.KEY_DOWN) {
            view.moveCursor(1);   // Move to next square (wraps around)
            return true;
        }
        
        return false;
    }
}
