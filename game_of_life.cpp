// Copyright (c) 2018 Claus Jørgensen

// Conway's Game of Life
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
// C++17

#include <iostream>
#include <vector>
#include <numeric>
#include <sstream>
#include <thread>
#include <chrono>

class GameOfLife {
public:
    GameOfLife(std::vector<std::vector<int>> seed);
    void transition();
    std::string to_string();
private:
    std::vector<std::vector<int>> map;
    std::vector<int> neightbors(int x, int y);
};

GameOfLife::GameOfLife(std::vector<std::vector<int>> seed) 
    : map(seed) {}

std::vector<int> GameOfLife::neightbors(int x, int y) {
    std::vector<int> neightbors;
    
    int map_size_x = (int)this->map.size();
    int map_size_y = (int)this->map.at(0).size();

    if ((x - 1) >= 0) {
        neightbors.push_back(this->map[x - 1][y]); // left
    }
    
    if ((x + 1) < map_size_x) {
        neightbors.push_back(this->map[x + 1][y]); // right
    }
    
    if ((y - 1) >= 0) {
        neightbors.push_back(this->map[x][y - 1]); // top
    }
    
    if ((y + 1) < map_size_y) {
        neightbors.push_back(this->map[x][y + 1]); // bottom
    }
    
    if ((x - 1) >= 0 && (y - 1) >= 0) {
        neightbors.push_back(this->map[x - 1][y - 1]); // top-left
    }
    
    if ((x - 1) >= 0 && (y + 1) < map_size_y) {
        neightbors.push_back(this->map[x - 1][y + 1]); // bottom-left
    }
    
    if ((x + 1) < map_size_x && (y + 1) < map_size_y) {
        neightbors.push_back(this->map[x + 1][y + 1]); // top-right
    }
    
    if ((x + 1) < map_size_x && (y - 1) >= 0) {
        neightbors.push_back(this->map[x + 1][y - 1]); // bottom-right
    }

    return neightbors;
}

void GameOfLife::transition() {
    std::vector<std::vector<int>> newMap(this->map.size(), std::vector<int>(this->map.at(0).size()));
    for (int x = 0; x < (int)this->map.size(); x++) {
        for (int y = 0; y < (int)this->map.at(x).size(); y++) {
            auto neightbors = this->neightbors(x, y);
            auto numAlive = std::reduce(neightbors.begin(), neightbors.end(), 0, [](int a, int c) { 
                return c == 1 ? a + 1 : a;
            });
            if (numAlive < 2) {
                newMap[x][y] = 0; // death by under population
            } else if (numAlive > 3) {
                newMap[x][y] = 0; // death by over population
            } else if (this->map[x][y] == 0 && numAlive == 3) {
                newMap[x][y] = 1; // alive by reproduction
            } else {
                newMap[x][y] = this->map[x][y];
            }
        }
    }
    this->map = newMap;
}

std::string GameOfLife::to_string() {
    std::stringstream ss;
    for (int x = 0; x < (int)this->map.size(); x++) {
      for (int y = 0; y < (int)this->map.at(x).size(); y++) {
        if (this->map[x][y] == 1) {
            ss << "+ ";
        } else {
            ss << "  ";
        }
      }
      ss << "\n";
    }
    return ss.str();
}

int main() {
    std::vector<std::vector<int>> blinker = {
        { 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0 },
        { 0, 1, 1, 1, 0 },
        { 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0 },
    };

    std::vector<std::vector<int>> toad = {
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 1, 1, 1, 0 },
        { 0, 1, 1, 1, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
    };

    std::vector<std::vector<int>> pulsar = {
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },        
        { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
        { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
        { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
        { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },        
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },        
        { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
        { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
        { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0 },        
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    };

    std::vector<std::vector<int>> pentadecathlon = {
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
    };

    std::unique_ptr<GameOfLife> game(new GameOfLife(pentadecathlon));

    while (true) {
        system("cls");
        std::cout << game->to_string() << std::endl;
        game->transition();
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}
