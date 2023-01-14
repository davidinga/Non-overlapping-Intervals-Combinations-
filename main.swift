class Solution {
    /*
    Problem:
    - Given list of intervals, return minimum number of intervals needed to remove
      to make the list non-overlapping.

    Questions:
    - Assume valid format of [a, b] where 0 <= a,b = 10^4 and a <= b
    
    Thoughts:
    - Sort list to make finding overlapping intervals more efficient
    
    Bruteforce:
    - Try every combination of intervals from smallest to greatest
    - Backtrack to check if non-overlapping
    - Update min count if solution is less than minCount

    [[1,2],[1,3],[2,3],[3,4]]
                   i
    
    Include [1,2]
    Exclude [1,3]
    Include [2,3]
    Include [3,4]
    */

    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        let intervals = intervals.sorted { $0[0] < $1[0] }
        var minRemovals = intervals.count - 1
        var slate: [[Int]] = []
        func combinations(_ i: Int, _ slate: inout [[Int]]) {
            guard i < intervals.count else {
                minRemovals = min(minRemovals, intervals.count - slate.count)
                return
            }

            // Include
            if slate.isEmpty || slate.last![1] <= intervals[i][0] {
                slate.append(intervals[i])
                combinations(i + 1, &slate)
                slate.removeLast()
            }

            // Exclude
            combinations(i + 1, &slate)  
        }
        combinations(0, &slate)
        return minRemovals
    }
}