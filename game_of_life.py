# -*- coding: UTF-8 -*-

# Copyright (c) 2019 Claus Jørgensen

from functools import reduce
from os import system, name 
from time import sleep 

class GameOfLife(object):
  """
  Conway's Game of Life
  
  https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
  """

  def __init__(self, seed):
    """
    Constructs a Game of Life
      
    Parameters
    ----------
    seed : list
        The initial game seed (two-dimensional array).
    """
    self.map = seed

  def transition(self):
    """
    Transitions the game once.
    """
    newMap = []
    for x in range(0, len(self.map) - 1):
      for y in range(0, len(self.map[x]) - 1):
        if len(newMap) <= x:
          newMap.insert(x, [])
        if len(newMap[x]) <= y:
          newMap[x].insert(y, self.map[x][y])
        numAlive = reduce(lambda a, c: a + 1 if c == 1 else a, self.neighbors(x, y))
        if numAlive < 2:
          newMap[x][y] = 0 # death by under population
        elif numAlive > 3:
          newMap[x][y] = 0 # death by over population
        elif self.map[x][y] == 0 and numAlive == 3:
          newMap[x][y] = 1 # alive by reproduction
    self.map = newMap

  def __str__(self):
    """
    Gets a string representation of the game's current state.
    """
    output = ""
    for x in range(0, len(self.map) - 1):
      for y in range(0, len(self.map[x]) - 1):
        if self.map[x][y] == 1:
          output += "+ "
        else:
          output += "  "
      output += "\n"
    return output

  def neighbors(self, x, y):
    """
    Gets the cell neighbors
    """
    neighbors = []
    if self.map[x - 1] >= 0 and self.map[x - 1][y] >= 0:
      neighbors.append(self.map[x - 1][y]) # left
    if self.map[x + 1] >= 0 and self.map[x + 1][y]:
      neighbors.append(self.map[x + 1][y]) # right
    if self.map[x][y - 1] >= 0:
      neighbors.append(self.map[x][y - 1]) # top
    if self.map[x][y + 1] >= 0:
      neighbors.append(self.map[x][y + 1]) # bottom
    if self.map[x - 1] >= 0 and self.map[x - 1][y - 1] >= 0:
      neighbors.append(self.map[x - 1][y - 1]) # top-left
    if self.map[x - 1] >= 0 and self.map[x - 1][y + 1] >= 0:
      neighbors.append(self.map[x - 1][y + 1]) # bottom-left
    if self.map[x + 1] >= 0 and self.map[x + 1][y + 1] >= 0:
      neighbors.append(self.map[x + 1][y + 1]) # top-right
    if self.map[x + 1] >= 0 and self.map[x + 1][y - 1] >= 0:
      neighbors.append(self.map[x + 1][y - 1]) # bottom-right
    return neighbors

pentadecathlon = [
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

game = GameOfLife(pentadecathlon)

while True:
  system("clear")
  game.transition()
  print(game)
  sleep(0.8)
