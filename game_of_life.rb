# Copyright (c) 2019 Claus Jørgensen

# Conway's Game of Life
# https:#en.wikipedia.org/wiki/Conway%27s_Game_of_Life
class GameOfLife

  # Constructs a Game of Life
  # +seed+:: The initial game seed (two-dimensional array).
  def initialize(seed = [[]])
    @map = seed
  end

  # Transitions the game once
  def transition
    newMap = []
    for x in 0...@map.length do
      for y in 0...@map[x].length do
        if !newMap[x]
          newMap[x] = []
        end
        if !newMap[x][y]
          newMap[x][y] = @map[x][y]
        end
        numAlive = neightbors(x, y).reduce(0) { |a, c|  c == 1 ? a + 1 : a }
        if numAlive < 2
          newMap[x][y] = 0 # death by under population
        elsif numAlive > 3
          newMap[x][y] = 0 # death by over population
        elsif @map[x][y] == 0 and numAlive == 3
          newMap[x][y] = 1 # alive by reproduction
        end
      end
    end
    @map = newMap
  end

  # Gets a string representation of the game's current state.
  def to_s
    output = ""
    for x in 0...@map.length do
      for y in 0...@map[x].length do
        if @map[x][y] == 1
          output += "+ "
        else
          output += "  "
        end
      end
      output += "\n"
    end
    return output
  end

  private

  # Gets the cell neightbors
  def neightbors(x, y)
    neightbors = []
    if @map[x - 1] && @map[x - 1][y]
      neightbors.push(@map[x - 1][y]) # left
    end
    if @map[x + 1] && @map[x + 1][y] 
      neightbors.push(@map[x + 1][y]) # right
    end
    if @map[x][y - 1]
      neightbors.push(@map[x][y - 1]) # top
    end
    if @map[x][y + 1] 
      neightbors.push(@map[x][y + 1]) # bottom
    end
    if @map[x - 1] && @map[x - 1][y - 1]
      neightbors.push(@map[x - 1][y - 1]) # top-left
    end
    if @map[x - 1] && @map[x - 1][y + 1] 
      neightbors.push(@map[x - 1][y + 1]) # bottom-left
    end
    if @map[x + 1] && @map[x + 1][y + 1] 
      neightbors.push(@map[x + 1][y + 1]) # top-right
    end
    if @map[x + 1] && @map[x + 1][y - 1] 
      neightbors.push(@map[x + 1][y - 1]) # bottom-right
    end
    return neightbors
  end

end

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

game = GameOfLife.new(pentadecathlon)

while true
  system("clear")
  game.transition
  print(game.to_s)
  sleep(0.8)
end
