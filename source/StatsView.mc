using Toybox.WatchUi;
using Toybox.System;

class StatsView extends WatchUi.View {
    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {
        var stats = Storage.getStats();
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_MEDIUM, "Your Stats", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Puzzles solved
        dc.drawText(20, 50, Graphics.FONT_SMALL, "Solved:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() - 20, 50, Graphics.FONT_SMALL, stats.solved + " / " + stats.total, Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Accuracy
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(20, 80, Graphics.FONT_SMALL, "Accuracy:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_CYAN, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() - 20, 80, Graphics.FONT_SMALL, stats.accuracy + "%", Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Incorrect
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(20, 110, Graphics.FONT_SMALL, "Incorrect:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() - 20, 110, Graphics.FONT_SMALL, stats.incorrect.toString(), Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Average time
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(20, 140, Graphics.FONT_SMALL, "Avg Time:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
        var avgMins = stats.avgTime / 60;
        var avgSecs = stats.avgTime % 60;
        dc.drawText(dc.getWidth() - 20, 140, Graphics.FONT_SMALL, avgMins + "m " + avgSecs + "s", Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Back hint
        dc.setColor(Graphics.COLOR_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 20, Graphics.FONT_TINY, "[BACK] to return", Graphics.TEXT_JUSTIFY_CENTER);
    }
}

class StatsDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(key) {
        if (key.key == WatchUi.KEY_BACK) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }
}
