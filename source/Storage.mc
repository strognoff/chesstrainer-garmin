import Toybox.Lang;
import Toybox.Application.Storage;

//! Storage module for puzzle progress
module Storage {
    const KEY_PROGRESS = "chess_progress";
    const KEY_SOLVED = "solved";
    const KEY_INCORRECT = "incorrect";
    const KEY_TIMES = "times";
    const KEY_USE_ASCII = "useAsciiPieces";

    //! Get progress data
    function getProgressData() as Dictionary {
        var data = Toybox.Application.Storage.getValue(KEY_PROGRESS);
        if (data != null) {
            return data as Dictionary;
        }
        return {
            KEY_SOLVED => new [0] as Array<Number>,
            KEY_INCORRECT => new [0] as Array<Number>,
            KEY_TIMES => {} as Dictionary<Number>
        } as Dictionary;
    }

    //! Get solved puzzles array
    function getSolvedPuzzles() as Array<Number> {
        var progress = getProgressData();
        var solved = progress.get(KEY_SOLVED);
        if (solved != null) {
            return solved as Array<Number>;
        }
        return new [0] as Array<Number>;
    }

    //! Get incorrect puzzles array
    function getIncorrectPuzzles() as Array<Number> {
        var progress = getProgressData();
        var incorrect = progress.get(KEY_INCORRECT);
        if (incorrect != null) {
            return incorrect as Array<Number>;
        }
        return new [0] as Array<Number>;
    }

    //! Get puzzle times dictionary
    function getPuzzleTimes() as Dictionary<Number> {
        var progress = getProgressData();
        var times = progress.get(KEY_TIMES);
        if (times != null) {
            return times as Dictionary<Number>;
        }
        return {} as Dictionary<Number>;
    }

    //! Mark puzzle as solved
    function markSolved(puzzleIndex as Number, timeSeconds as Number) as Void {
        var progress = getProgressData();
        var solved = progress.get(KEY_SOLVED) as Array<Number>;
        var times = progress.get(KEY_TIMES) as Dictionary<Number>;
        
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
        
        times[puzzleIndex] = timeSeconds;
        
        // Update the progress dictionary
        progress[KEY_SOLVED] = solved;
        progress[KEY_TIMES] = times;
        
        // Save to storage
        Toybox.Application.Storage.setValue(KEY_PROGRESS, progress);
    }

    //! Mark puzzle as incorrect
    function markIncorrect(puzzleIndex as Number) as Void {
        var progress = getProgressData();
        var incorrect = progress.get(KEY_INCORRECT) as Array<Number>;
        
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
        
        // Update the progress dictionary
        progress[KEY_INCORRECT] = incorrect;
        
        // Save to storage
        Toybox.Application.Storage.setValue(KEY_PROGRESS, progress);
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
        
        var solvedCount = solved.size();
        var incorrectCount = incorrect.size();
        var attempted = solvedCount + incorrectCount;
        
        // Calculate accuracy based on attempted puzzles
        var accuracy = 0;
        if (attempted > 0) {
            accuracy = (solvedCount * 100) / attempted;
        }
        
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
            "solved" => solvedCount,
            "incorrect" => incorrectCount,
            "accuracy" => accuracy,
            "avgTime" => avgTime
        };
    }

    //! Reset all progress
    function resetProgress() as Void {
        Toybox.Application.Storage.setValue(KEY_PROGRESS, null);
    }

    //! Get piece display setting (true = ASCII, false = Bitmap)
    function getUseAsciiPieces() as Boolean {
        var value = Toybox.Application.Storage.getValue(KEY_USE_ASCII);
        if (value == null) {
            return false; // Default to bitmap display
        }
        return value as Boolean;
    }

    //! Set piece display setting
    function setUseAsciiPieces(useAscii as Boolean) as Void {
        Toybox.Application.Storage.setValue(KEY_USE_ASCII, useAscii);
    }
}
