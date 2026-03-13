import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class StatsView extends WatchUi.View {
    
    const COLOR_ORANGE = 0xFF8800;
    const COLOR_CYAN = 0x00CCCC;
    
    function initialize() {
        WatchUi.View.initialize();
    }

    function onShow() as Void {
        // Refresh the view when it's shown to update stats
        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        var stats = Storage.getStats();
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 10, Graphics.FONT_MEDIUM, "Your Stats", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Starting position
        var startY = 70;
        var startX = 25;
        var lineHeight = 30;
        
        // Puzzles solved
        dc.drawText(startX, startY, Graphics.FONT_SMALL, "Solved:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() - startX, startY, Graphics.FONT_SMALL, stats.get("solved") + " / " + stats.get("total"), Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Accuracy
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(startX, startY + lineHeight, Graphics.FONT_SMALL, "Accuracy:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(COLOR_ORANGE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() - startX, startY + lineHeight, Graphics.FONT_SMALL, stats.get("accuracy") + "%", Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Incorrect
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(startX, startY + lineHeight * 2, Graphics.FONT_SMALL, "Incorrect:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() - startX, startY + lineHeight * 2, Graphics.FONT_SMALL, stats.get("incorrect").toString(), Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Average time
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(startX, startY + lineHeight * 3, Graphics.FONT_SMALL, "Avg Time:", Graphics.TEXT_JUSTIFY_LEFT);
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
        var avgTime = stats.get("avgTime") as Number;
        var avgMins = avgTime / 60;
        var avgSecs = avgTime % 60;
        dc.drawText(dc.getWidth() - startX, startY + lineHeight * 3, Graphics.FONT_SMALL, avgMins + "m " + avgSecs + "s", Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Back hint
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(55, 220, Graphics.FONT_TINY, "ESC to return", Graphics.TEXT_JUSTIFY_LEFT);
    }
}

class StatsDelegate extends WatchUi.InputDelegate {
    function initialize() {
        WatchUi.InputDelegate.initialize();
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        if (key.getKey() == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }
}
