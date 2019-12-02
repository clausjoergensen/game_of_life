// Copyright (c) 2019 Claus Jørgensen

// Conway's Game of Life
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int find_neightbors(char neightbors[8],
                    const int width,
                    const int height,
                    const char map[width][height],
                    const int x,
                    const int y) {
    int count = 0;
    if ((x - 1) >= 0) {
        neightbors[count++] = map[x - 1][y]; // left
    }

    if ((x + 1) < width) {
        neightbors[count++] = map[x + 1][y]; // right
    }

    if ((y - 1) >= 0) {
        neightbors[count++] = map[x][y - 1]; // top
    }

    if ((y + 1) < height) {
        neightbors[count++] = map[x][y + 1]; // bottom
    }

    if ((x - 1) >= 0 && (y - 1) >= 0) {
        neightbors[count++] = map[x - 1][y - 1]; // top-left
    }

    if ((x - 1) >= 0 && (y + 1) < height) {
        neightbors[count++] = map[x - 1][y + 1]; // bottom-left
    }

    if ((x + 1) < width && (y + 1) < height) {
        neightbors[count++] = map[x + 1][y + 1]; // top-right
    }

    if ((x + 1) < width && (y - 1) >= 0) {
        neightbors[count++] = map[x + 1][y - 1]; // bottom-right
    }

    return count;
}

void transition(const int width,
                const int height,
                const char map[width][height],
                char newMap[width][height]) {
    char tmpMap[width][height];
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            static char neightbors[8];
            int count = find_neightbors(neightbors, width, height, map, x, y);

            int numAlive = 0;
            for (int n = 0; n < count; n++) {
                numAlive = neightbors[n] == 1 ? numAlive + 1 : numAlive;
            }

            if (numAlive < 2) {
                tmpMap[x][y] = 0; // death by under population
            } else if (numAlive > 3) {
                tmpMap[x][y] = 0; // death by over population
            } else if (map[x][y] == 0 && numAlive == 3) {
                tmpMap[x][y] = 1; // alive by reproduction
            } else {
                tmpMap[x][y] = map[x][y]; // continue unchanged
            }
        }
    }
    memcpy(newMap, tmpMap, width * height);
}

void print_map(const int width,
               const int height,
               const char map[width][height]) {
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            if (map[x][y] == 1) {
                printf("+ ");
            } else {
                printf("  ");
            }
        }
        printf("\n");
    }
}

#define PENTADECATHLON_WIDTH 20
#define PENTADECATHLON_HEIGHT 20
#define PENTADECATHLON { \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, \
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }  \
}

int main(int argc, const char * argv[]) {
    const int width = PENTADECATHLON_WIDTH;
    const int height = PENTADECATHLON_HEIGHT;

    char map[width][height] = PENTADECATHLON;

    while (1) {
        system("clear");
        print_map(width, height, map);
        transition(width, height, map, map);
        sleep(1);
    }

    return 0;
}
