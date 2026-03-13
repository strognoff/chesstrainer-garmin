using Toybox.WatchUi;
using Toybox.System;

class MenuView extends WatchUi.MenuInputDelegate {
    function initialize() {}

    function onMenuItem(item) {
        if (item == :id_start) {
            WatchUi.pushView(new PuzzleListView(), new PuzzleListDelegate(), WatchUi.SLIDE_LEFT);
        } else if (item == :id_stats) {
            WatchUi.pushView(new StatsView(), new StatsDelegate(), WatchUi.SLIDE_LEFT);
        } else if (item == :id_history) {
            WatchUi.pushView(new HistoryView(), new HistoryDelegate(), WatchUi.SLIDE_LEFT);
        } else if (item == :id_reset) {
            Storage.resetProgress();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}

class MenuView2 extends WatchUi.View {
    function initialize() {}

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 20, Graphics.FONT_MEDIUM, "ChessTrainer", Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 60, Graphics.FONT_SMALL, "[START]", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 90, Graphics.FONT_SMALL, "[STATS]", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 120, Graphics.FONT_SMALL, "[HISTORY]", Graphics.TEXT_JUSTIFY_CENTER);
    }
}

class MenuDelegate extends WatchUi.InputDelegate {
    function initialize() {}

    function onKey(key) {
        if (key.key == WatchUi.KEY_ENTER) {
            WatchUi.pushView(new PuzzleListView(), new PuzzleListDelegate(), WatchUi.SLIDE_LEFT);
            return true;
        }
        return false;
    }
}
