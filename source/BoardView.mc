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
        
        if (keyCode == WatchUi.KEY_UP) {
            view.moveCursor(-1);  // Move to previous square (wraps around)
            return true;
        } else if (keyCode == WatchUi.KEY_DOWN) {
            view.moveCursor(1);   // Move to next square (wraps around)
            return true;
        } else if (keyCode == WatchUi.KEY_ENTER) {
            view.selectSquare();
            return true;
        } else if (keyCode == WatchUi.KEY_MENU) {
            // Show hint - in MVP just mark as correct
            var elapsed = (System.getTimer() - view.startTime) / 1000;
            Storage.markSolved(puzzleIndex, elapsed);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (keyCode == WatchUi.KEY_ESC) {
            if (view.selectedSquare != null) {
                // Cancel selection
                view.selectedSquare = null;
                WatchUi.requestUpdate();
                return true;
            }
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }
}
