// Copyright (c) 2021 Claus Jørgensen

// Conway's Game of Life
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

public sealed class GameOfLife
{
    private int[,] map;

    public GameOfLife(int[,] seed)
    {
        map = seed;
    }

    public void Transition()
    {
        var d1 = map.GetLength(0);
        var d2 = map.GetLength(1);
        int[,] newMap = new int[d1, d2];

        for (int x = 0; x < d1; x++)
        {
            for (int y = 0; y < d2; y++)
            {
                var neighbors = GetNeighbors(x, y);
                var numAlive = neighbors.Aggregate(0, (a, c) => c == 1 ? a + 1 : a);

                if (numAlive < 2)
                    newMap[x, y] = 0; // death by under population
                else if (numAlive > 3)
                    newMap[x, y] = 0; // death by over population
                else if (map[x, y] == 0 && numAlive == 3)
                    newMap[x, y] = 1; // alive by reproduction
                else
                    newMap[x, y] = map[x, y]; // continue unchanged
            }
        }

        map = newMap;
    }

    public override string ToString()
    {
        var stringBuilder = new StringBuilder();
        for (int x = 0; x < map.GetLength(0); x++)
        {
            for (int y = 0; y < map.GetLength(1); y++)
            {
                if (map[x, y] == 1)
                    stringBuilder.Append("+ ");
                else
                    stringBuilder.Append("  ");
            }
            stringBuilder.AppendLine();
        }
        return stringBuilder.ToString();
    }

    private IEnumerable<int> GetNeighbors(int x, int y)
    {
        var mapSizeX = map.GetLength(0);
        var mapSizeY = map.GetLength(1);

        if ((x - 1) >= 0)
            yield return map[x - 1, y]; // left

        if ((x + 1) < mapSizeX)
            yield return map[x + 1, y]; // right

        if ((y - 1) >= 0)
            yield return map[x, y - 1]; // top

        if ((y + 1) < mapSizeY)
            yield return map[x, y + 1]; // bottom

        if ((x - 1) >= 0 && (y - 1) >= 0)
            yield return map[x - 1, y - 1]; // top-left

        if ((x - 1) >= 0 && (y + 1) < mapSizeY)
            yield return map[x - 1, y + 1]; // bottom-left

        if ((x + 1) < mapSizeX && (y + 1) < mapSizeY)
            yield return map[x + 1, y + 1]; // top-right

        if ((x + 1) < mapSizeX && (y - 1) >= 0)
            yield return map[x + 1, y - 1]; // bottom-right
    }
}

public class Program
{
    static void Main()
    {
        int[,] pentadecathlon = {
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

        while (true)
        {
            Console.Clear();
            Console.WriteLine(game.ToString());
            game.Transition();
            Thread.Sleep(1000);
        }
    }
}
