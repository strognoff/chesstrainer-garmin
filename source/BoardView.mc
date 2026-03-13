using Toybox.WatchUi;
using Toybox.System;
using Toybar.Timer;

class BoardView extends WatchUi.View {
    var puzzleIndex;
    var boardData;
    var timer;
    var startTime;
    var hintShown = false;

    function initialize(idx) {
        View.initialize();
        puzzleIndex = idx;
        var fen = PuzzleData.getPuzzle(puzzleIndex);
        boardData = BoardLogic.parseFen(fen);
        startTime = System.getTimer();
    }

    function onShow() {
        timer = new Timer.Timer();
        timer.start(method(:onTimer), 1000, true);
    }

    function onHide() {
        if (timer != null) {
            timer.stop();
        }
    }

    function onTimer() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        // Clear
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw header
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 5, Graphics.FONT_TINY, "Find the best move!", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw timer
        var elapsed = (System.getTimer() - startTime) / 1000;
        var mins = elapsed / 60;
        var secs = elapsed % 60;
        dc.drawText(width / 2, 20, Graphics.FONT_TINY, format("$1$:$2$", [mins, secs.format("%02d")]), Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw puzzle number
        dc.drawText(width / 2, 35, Graphics.FONT_TINY, "Puzzle " + (puzzleIndex + 1), Graphics.TEXT_JUSTIFY_CENTER);
        
        // Calculate board area
        var boardSize = height - 90;
        var marginX = (width - boardSize) / 2;
        var marginY = 50;
        var squareSize = boardSize / 8;
        
        // Draw chess board
        for (var row = 0; row < 8; row++) {
            for (var col = 0; col < 8; col++) {
                var x = marginX + col * squareSize;
                var y = marginY + row * squareSize;
                
                // Draw square
                if (BoardLogic.isLightSquare(row, col)) {
                    dc.setColor(Graphics.COLOR_LTGRAY, Graphics.COLOR_LTGRAY);
                } else {
                    dc.setColor(Graphics.COLOR_DKGRAY, Graphics.COLOR_DKGRAY);
                }
                dc.fillRectangle(x, y, squareSize, squareSize);
                
                // Draw piece
                var piece = boardData.board[row][col];
                if (piece != null) {
                    var pieceChar = BoardLogic.getPieceChar(piece);
                    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_LTGRAY);
                    dc.drawText(x + squareSize / 2, y + squareSize / 2 - 5, Graphics.FONT_MEDIUM, pieceChar, Graphics.TEXT_JUSTIFY_CENTER);
                }
            }
        }
        
        // Draw controls hint
        dc.setColor(Graphics.COLOR_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, height - 20, Graphics.FONT_TINY, "[MENU] Hint [OK] Give Up", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onKey(key) {
        if (key.key == WatchUi.KEY_MENU) {
            // Show hint - in MVP just mark as correct
            hintShown = true;
            var elapsed = (System.getTimer() - startTime) / 1000;
            Storage.markSolved(puzzleIndex, elapsed);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (key.key == WatchUi.KEY_ENTER) {
            // Give up
            Storage.markIncorrect(puzzleIndex);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (key.key == WatchUi.KEY_DOWN || key.key == WatchUi.KEY_UP) {
            // Navigation for potential move input
            return true;
        }
        return false;
    }
}

class BoardDelegate extends WatchUi.InputDelegate {
    var puzzleIndex;

    function initialize(idx) {
        InputDelegate.initialize();
        puzzleIndex = idx;
    }

    function onKey(key) {
        // This will call the view's onKey
        return false;
    }
}
