/* Copyright (c) 2020 Claus Jørgensen */
import java.util.*;
import java.io.*;

/** 
 * Conway's Game of Life
 *
 * https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
 */
public final class GameOfLife {
    private int[][] map;

    public GameOfLife(int[][] map) {
        this.map = map;
    }

    private void transition() {
        var newMap = new int[this.map.length][this.map[0].length];
        for (int x = 0; x < map.length; x++) {
            for (int y = 0; y < map[x].length; y++) {
                var neightbors = getNeightbors(x, y);
                int numAlive = neightbors.stream().reduce(0, (a, c) -> (c == 1 ? a + 1 : a));
                if (numAlive < 2) {
                    newMap[x][y] = 0; // death by under population
                } else if (numAlive > 3) {
                    newMap[x][y] = 0; // death by over population
                } else if (map[x][y] == 0 && numAlive == 3) {
                    newMap[x][y] = 1; // alive by reproduction
                } else {
                    newMap[x][y] = this.map[x][y]; // continue unchanged
                }
            }
        }
        this.map = newMap;
    }

    private List<Integer> getNeightbors(int x, int y) {
        var neightbors = new ArrayList<Integer>();
        int mapSizeX = this.map.length;
        int mapSizeY = this.map[0].length;

        if ((x - 1) >= 0) {
            neightbors.add(map[x - 1][y]); // left
        }

        if ((x + 1) < mapSizeX) {
            neightbors.add(map[x + 1][y]); // right
        }

        if ((y - 1) >= 0) {
            neightbors.add(map[x][y - 1]); // top
        }

        if ((y + 1) < mapSizeY) {
            neightbors.add(map[x][y + 1]); // bottom
        }

        if ((x - 1) >= 0 && (y - 1) >= 0) {
            neightbors.add(map[x - 1][y - 1]); // top-left
        }

        if ((x - 1) >= 0 && (y + 1) < mapSizeY) {
            neightbors.add(map[x - 1][y + 1]); // bottom-left
        }

        if ((x + 1) < mapSizeX && (y + 1) < mapSizeY) {
            neightbors.add(map[x + 1][y + 1]); // top-right
        }

        if ((x + 1) < mapSizeX && (y - 1) >= 0) {
            neightbors.add(map[x + 1][y - 1]); // bottom-right
        }

        return neightbors;
    }

    private String getString() {
        var output = "";
        for (int x = 0; x < map.length; x++) {
            for (int y = 0; y < map[x].length; y++) {
                if (map[x][y] == 1) {
                    output += "+ ";
                } else {
                    output += "  ";
                }
            }
            output += "\n";
        }
        return output;
    }

    public static void main(String[] args) throws IOException, InterruptedException {
        int[][] pentadecathlon = {
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

        var game = new GameOfLife(pentadecathlon);

        while (true) {
            System.out.print("\033[H\033[2J");  
            System.out.flush();  
            System.out.println(game.getString());
            game.transition();
            Thread.sleep(1000);
        }
    }
}
