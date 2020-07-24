// Copyright (c) 2020 Claus Jørgensen

// Conway's Game of Life
//
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
class GameOfLife(var map: Array<IntArray>) {
    fun transition() {
        var newMap = Array(map.size) { IntArray(map[0].size) { 0 } }
        for ((x, innerMap) in map.withIndex()) {
            for ((y, _) in innerMap.withIndex()) {
                val neighbors = getNeighbors(x, y)
                val numAlive = neighbors.reduce { a, c -> if (c == 1) a + 1 else a }
                if (numAlive < 2) {
                    newMap[x][y] = 0 // death by under population
                } else if (numAlive > 3) {
                    newMap[x][y] = 0 // death by over population
                } else if (map[x][y] == 0 && numAlive == 3) {
                    newMap[x][y] = 1 // alive by reproduction
                } else {
                    newMap[x][y] = map[x][y] // continue unchanged
                }
            }
        }
        this.map = newMap
    }

    fun getNeighbors(x: Int, y: Int): IntArray {
        val neighbors = mutableListOf<Int>()
        val mapSizeX = map.size
        val mapSizeY = map[0].size

        if ((x - 1) >= 0) {
            neighbors += map[x - 1][y] // left
        }

        if ((x + 1) < mapSizeX) {
            neighbors += map[x + 1][y] // right
        }

        if ((y - 1) >= 0) {
            neighbors += map[x][y - 1] // top
        }

        if ((y + 1) < mapSizeY) {
            neighbors += map[x][y + 1] // bottom
        }

        if ((x - 1) >= 0 && (y - 1) >= 0) {
            neighbors += map[x - 1][y - 1] // top-left
        }

        if ((x - 1) >= 0 && (y + 1) < mapSizeY) {
            neighbors += map[x - 1][y + 1] // bottom-left
        }

        if ((x + 1) < mapSizeX && (y + 1) < mapSizeY) {
            neighbors += map[x + 1][y + 1] // top-right
        }

        if ((x + 1) < mapSizeX && (y - 1) >= 0) {
            neighbors += map[x + 1][y - 1] // bottom-right
        }

        return neighbors.toIntArray()
    }

    override fun toString(): String {
        var output = ""
        for (innerMap in map) {
            for (value in innerMap) {
                if (value == 1) {
                    output += "+ "
                } else {
                    output += "  "
                }
            }
            output += "\n"
        }
        return output
    }
}

fun main() {
    val pentadecathlon = arrayOf(
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
        intArrayOf(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
    )

    val game = GameOfLife(pentadecathlon)

    while (true) {
        print("\u001b[H\u001b[2J")
        println(game.toString())
        game.transition()
        platform.posix.sleep(1) // Thread.sleep(1_000)
    }
}
