-- Copyright (c) 2019 Claus Jørgensen

-- Conway's Game of Life
-- https:#en.wikipedia.org/wiki/Conway%27s_Game_of_Life

GameOfLife = { map = {} }

function GameOfLife:new(seed)
	local object = {}
	setmetatable(object, self)
	self.__index = self
	self.map = seed
	return object
end

function GameOfLife:transition()
	local newMap = {}
	for x = 1, #self.map do
		for y = 1, #self.map[x] do
			local neightbors = self:neightbors(x, y)

			local numAlive = 0
			for n = 0, #neightbors do
				if neightbors[n] == 1 then 
					numAlive = numAlive + 1 
				end
			end

            if newMap[x] == nil then
                newMap[x] = {}
            end
            
            if newMap[x][y] == nil then
                newMap[x][y] = self.map[x][y]
            end

			if numAlive < 2 then
				newMap[x][y] = 0 -- death by under population
			elseif numAlive > 3 then
				newMap[x][y] = 0 -- death by over population
			elseif self.map[x][y] == 0 and numAlive == 3 then
				newMap[x][y] = 1 -- alive by reproduction
			end
  		end
	end
	self.map = newMap
end

function GameOfLife:__tostring()
	local output = ""
	for x = 1, #self.map do
		for y = 1, #self.map[x] do
			if self.map[x][y] == 1 then
				output = output .. "+ "
			else
				output = output .. "  "
			end
		end
		output = output .. "\n"
	end
	return output
end

function GameOfLife:neightbors(x, y)
	local neightbors = {}
	
	if self.map[x - 1] and self.map[x - 1][y] then
	 	table.insert(neightbors, self.map[x - 1][y]) -- left
	end
	
	if self.map[x + 1] and self.map[x + 1][y] then
		table.insert(neightbors, self.map[x + 1][y]) -- right
	end
	
	if self.map[x][y - 1] then
		table.insert(neightbors, self.map[x][y - 1]) -- top
	end
	
	if self.map[x][y + 1] then
		table.insert(neightbors, self.map[x][y + 1]) -- bottom
	end
	
	if self.map[x - 1] and self.map[x - 1][y - 1] then
		table.insert(neightbors, self.map[x - 1][y - 1]) -- top-left
	end
	
	if self.map[x - 1] and self.map[x - 1][y + 1] then
		table.insert(neightbors, self.map[x - 1][y + 1]) -- bottom-left
	end
	
	if self.map[x + 1] and self.map[x + 1][y + 1] then
		table.insert(neightbors, self.map[x + 1][y + 1]) -- top-right
	end
	
	if self.map[x + 1] and self.map[x + 1][y - 1] then
		table.insert(neightbors, self.map[x + 1][y - 1]) -- bottom-right
	end
	
	return neightbors
end

local pentadecathlon = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
}

local game = GameOfLife:new(pentadecathlon)

while true do
	os.execute("clear")
	game:transition()
	print(game)
	os.execute("sleep 0.8")
end
