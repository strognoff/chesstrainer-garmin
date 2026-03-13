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

    function initialize(idx as Number) {
        WatchUi.View.initialize();
        puzzleIndex = idx;
        var fen = PuzzleData.getPuzzle(puzzleIndex);
        boardData = BoardLogic.parseFen(fen);
        startTime = System.getTimer();
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
        
        // Draw header
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 5, Graphics.FONT_TINY, "Find the best move!", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw timer
        var elapsed = (System.getTimer() - startTime) / 1000;
        var mins = elapsed / 60;
        var secs = elapsed % 60;
        dc.drawText(width / 2, 20, Graphics.FONT_TINY, mins.format("%d") + ":" + secs.format("%02d"), Graphics.TEXT_JUSTIFY_CENTER);
        
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
                    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_LT_GRAY);
                } else {
                    dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
                }
                dc.fillRectangle(x, y, squareSize, squareSize);
                
                // Draw piece
                var piece = boardData["board"][row][col];
                if (piece != null) {
                    var pieceChar = BoardLogic.getPieceChar(piece);
                    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_LT_GRAY);
                    dc.drawText(x + squareSize / 2, y + squareSize / 2 - 5, Graphics.FONT_MEDIUM, pieceChar, Graphics.TEXT_JUSTIFY_CENTER);
                }
            }
        }
        
        // Draw controls hint
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, height - 20, Graphics.FONT_TINY, "MENU: Hint  OK: Give Up", Graphics.TEXT_JUSTIFY_CENTER);
    }
}

class BoardDelegate extends WatchUi.InputDelegate {
    var puzzleIndex as Number;

    function initialize(idx as Number) {
        WatchUi.InputDelegate.initialize();
        puzzleIndex = idx;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();
        
        if (keyCode == WatchUi.KEY_MENU) {
            // Show hint - in MVP just mark as correct
            var elapsed = (System.getTimer() - System.getTimer()) / 1000;
            Storage.markSolved(puzzleIndex, 0);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (keyCode == WatchUi.KEY_ENTER) {
            // Give up
            Storage.markIncorrect(puzzleIndex);
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (keyCode == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }
}
