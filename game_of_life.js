// Copyright (c) 2018 Claus Jørgensen
'use strict'

/**
 * Conway's Game of Life
 *
 * https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
 */
class GameOfLife {
  /**
   * Constructs a Game of Life
   *
   * @param {Array} seed The initial game seed (two-dimensional array).
   */
  constructor (seed) {
    this.map = seed
  }

  /**
   * Transitions the game once
   *
   * @public
   */
  transition () {
    let newMap = []
    for (let x = 0; x < this.map.length; x++) {
      for (let y = 0; y < this.map[x].length; y++) {
        if (!newMap[x]) {
          newMap[x] = []
        }
        if (!newMap[x][y]) {
          newMap[x][y] = this.map[x][y]
        }
        let neightbors = this.neightbors(x, y)
        let numAlive = neightbors.reduce((a, c) => c === 1 ? a + 1 : a, 0)
        if (numAlive < 2) {
          newMap[x][y] = 0 // death by under population
        } else if (numAlive > 3) {
          newMap[x][y] = 0 // death by over population
        } else if (this.map[x][y] != 1 && numAlive === 3) {
          newMap[x][y] = 1 // alive by reproduction
        }
      }
    }
    this.map = newMap
  }

  /**
   * Gets a string representation of the game's current state.
   *
   * @public
   */
  toString () {
    let output = ''
    for (let x = 0; x < this.map.length; x++) {
      for (let y = 0; y < this.map[x].length; y++) {
        if (this.map[x][y] === 1) {
          output += '+ '
        } else {
          output += '  '
        }
      }
      output += '\n'
    }
    return output
  }

  /**
   * Gets the cell neightbors
   *
   * @private
   */
  neightbors (x, y) {
    let neightbors = []
    if (this.map[x - 1] && this.map[x - 1][y]) {
      neightbors.push(this.map[x - 1][y]) // left
    }
    if (this.map[x + 1] && this.map[x + 1][y]) {
      neightbors.push(this.map[x + 1][y]) // right
    }
    if (this.map[x][y - 1]) {
      neightbors.push(this.map[x][y - 1]) // top
    }
    if (this.map[x][y + 1]) {
      neightbors.push(this.map[x][y + 1]) // bottom
    }
    if (this.map[x - 1] && this.map[x - 1][y - 1]) {
      neightbors.push(this.map[x - 1][y - 1]) // top-left
    }
    if (this.map[x - 1] && this.map[x - 1][y + 1]) {
      neightbors.push(this.map[x - 1][y + 1]) // bottom-left
    }
    if (this.map[x + 1] && this.map[x + 1][y + 1]) {
      neightbors.push(this.map[x + 1][y + 1]) // top-right
    }
    if (this.map[x + 1] && this.map[x + 1][y - 1]) {
      neightbors.push(this.map[x + 1][y - 1]) // bottom-right
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

let game = new GameOfLife(pentadecathlon)

function play () {
  console.log('\x1Bc', game.toString())
  game.transition()
  setTimeout(play, 800)
}

play()
