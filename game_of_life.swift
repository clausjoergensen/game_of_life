#!/usr/bin/swift

// Copyright (c) 2020 Claus Jørgensen

import Foundation

/// Conway's Game of Life
///
/// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
struct GameOfLife: CustomStringConvertible {

    private var map: [[Int]]

    /// Constructs a Game of Life
    ///
    /// - param seed: The initial game seed (two-dimensional array).
    init(_ seed: [[Int]]) {
        self.map = seed
    }

    /// Transitions the game once
    mutating func transition () {
        var newMap: [[Int]] = .init(repeating: [Int](), count: map.count)
        for x in 0..<map.count {
            for y in 0..<map[x].count {
                if newMap[x].count == 0 {
                    newMap[x] = map[x]
                }
                let neightbors = self.neightbors(x: x, y: y)
                let numAlive = neightbors.reduce(into: 0) { (a, c) in a = (c == 1 ? a + 1 : a) }
                if (numAlive < 2) {
                    newMap[x][y] = 0 // death by under population
                } else if (numAlive > 3) {
                    newMap[x][y] = 0 // death by over population
                } else if (map[x][y] == 0 && numAlive == 3) {
                    newMap[x][y] = 1 // alive by reproduction
                }
            }
        }
        map = newMap
    }

    /// Gets a string representation of the game's current state.
    var description: String {
        var output = ""
        for x in 0..<map.count {
            for y in 0..<map[x].count {
                if (map[x][y] == 1) {
                    output += "+ "
                } else {
                    output += "  "
                }
            }
            output += "\n"
        }
        return output
    }

    /// Gets the cell neightbors
    private func neightbors(x: Int, y: Int) -> [Int] {
        var neightbors: [Int] = []
        let mapSizeX = map.count
        let mapSizeY = map[0].count

        if (x - 1) >= 0 {
            neightbors.append(map[x - 1][y]) // left
        }

        if (x + 1) < mapSizeX {
            neightbors.append(map[x + 1][y]) // right
        }

        if (y - 1) >= 0 {
            neightbors.append(map[x][y - 1]) // top
        }

        if (y + 1) < mapSizeY {
            neightbors.append(map[x][y + 1]) // bottom
        }

        if (x - 1) >= 0 && (y - 1) >= 0 {
            neightbors.append(map[x - 1][y - 1]) // top-left
        }

        if (x - 1) >= 0 && (y + 1) < mapSizeY {
            neightbors.append(map[x - 1][y + 1]) // bottom-left
        }

        if (x + 1) < mapSizeX && (y + 1) < mapSizeY {
            neightbors.append(map[x + 1][y + 1]) // top-right
        }

        if (x + 1) < mapSizeX && (y - 1) >= 0 {
            neightbors.append(map[x + 1][y - 1]) // bottom-right
        }

        return neightbors
    }
}

let pentadecathlon = [
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
]

var game = GameOfLife(pentadecathlon)

while true {
    print("\u{001B}[2J", game)
    game.transition()
    sleep(1)
}
