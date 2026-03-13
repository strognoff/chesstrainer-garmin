import Toybox.Lang;
import Toybox.Application.Storage;

//! Storage module for puzzle progress
module Storage {
    const KEY_PROGRESS = "chess_progress";
    const KEY_SOLVED = "solved";
    const KEY_INCORRECT = "incorrect";
    const KEY_TIMES = "times";

    //! Get solved puzzles array
    function getSolvedPuzzles() as Array<Number> {
        var data = Storage.getValue(KEY_PROGRESS);
        if (data != null) {
            var progress = data as Dictionary;
            var solved = progress.get(KEY_SOLVED);
            if (solved != null) {
                return solved as Array<Number>;
            }
        }
        return new [0] as Array<Number>;
    }

    //! Get incorrect puzzles array
    function getIncorrectPuzzles() as Array<Number> {
        var data = Storage.getValue(KEY_PROGRESS);
        if (data != null) {
            var progress = data as Dictionary;
            var incorrect = progress.get(KEY_INCORRECT);
            if (incorrect != null) {
                return incorrect as Array<Number>;
            }
        }
        return new [0] as Array<Number>;
    }

    //! Get puzzle times dictionary
    function getPuzzleTimes() as Dictionary<Number> {
        var data = Storage.getValue(KEY_PROGRESS);
        if (data != null) {
            var progress = data as Dictionary;
            var times = progress.get(KEY_TIMES);
            if (times != null) {
                return times as Dictionary<Number>;
            }
        }
        return {} as Dictionary<Number>;
    }

    //! Save progress to storage
    function saveProgress() as Void {
        var data = {
            KEY_SOLVED => getSolvedPuzzles(),
            KEY_INCORRECT => getIncorrectPuzzles(),
            KEY_TIMES => getPuzzleTimes()
        } as Dictionary;
        Storage.setValue(KEY_PROGRESS, data);
    }

    //! Mark puzzle as solved
    function markSolved(puzzleIndex as Number, timeSeconds as Number) as Void {
        var solved = getSolvedPuzzles();
        
        // Check if already solved
        var alreadySolved = false;
        for (var i = 0; i < solved.size(); i++) {
            if (solved[i] == puzzleIndex) {
                alreadySolved = true;
                break;
            }
        }
        
        if (!alreadySolved) {
            solved.add(puzzleIndex);
        }
        
        var times = getPuzzleTimes();
        times[puzzleIndex] = timeSeconds;
        
        saveProgress();
    }

    //! Mark puzzle as incorrect
    function markIncorrect(puzzleIndex as Number) as Void {
        var incorrect = getIncorrectPuzzles();
        
        // Check if already marked incorrect
        var alreadyMarked = false;
        for (var i = 0; i < incorrect.size(); i++) {
            if (incorrect[i] == puzzleIndex) {
                alreadyMarked = true;
                break;
            }
        }
        
        if (!alreadyMarked) {
            incorrect.add(puzzleIndex);
        }
        
        saveProgress();
    }

    //! Check if puzzle is solved
    function isSolved(puzzleIndex as Number) as Boolean {
        var solved = getSolvedPuzzles();
        for (var i = 0; i < solved.size(); i++) {
            if (solved[i] == puzzleIndex) {
                return true;
            }
        }
        return false;
    }

    //! Check if puzzle is marked incorrect
    function isIncorrect(puzzleIndex as Number) as Boolean {
        var incorrect = getIncorrectPuzzles();
        for (var i = 0; i < incorrect.size(); i++) {
            if (incorrect[i] == puzzleIndex) {
                return true;
            }
        }
        return false;
    }

    //! Get statistics
    function getStats() as Dictionary {
        var total = PuzzleData.getPuzzleCount();
        var solved = getSolvedPuzzles();
        var incorrect = getIncorrectPuzzles();
        
        // Calculate average time
        var totalTime = 0;
        var count = 0;
        var times = getPuzzleTimes();
        var keys = times.keys();
        
        for (var i = 0; i < keys.size(); i++) {
            var key = keys[i];
            if (key != null) {
                var val = times.get(key);
                if (val != null) {
                    totalTime += val;
                    count++;
                }
            }
        }
        var avgTime = count > 0 ? totalTime / count : 0;
        
        return {
            "total" => total,
            "solved" => solved.size(),
            "incorrect" => incorrect.size(),
            "accuracy" => (solved.size() + incorrect.size()) > 0 ? (solved.size() * 100 / (solved.size() + incorrect.size())) : 0,
            "avgTime" => avgTime
        };
    }

    //! Reset all progress
    function resetProgress() as Void {
        Storage.setValue(KEY_PROGRESS, null);
    }
}
