// Copyright (c) 2020 Claus Jørgensen

// Conway's Game of Life
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

fn find_neightbors(map: &Vec<Vec<i8>>, x: usize, y: usize) -> Vec<i8> {
    let mut neightbors: Vec<i8> = vec![];
    let width = map.len();
    let height = map[0].len();

    if x >= 1 {
        neightbors.push(map[x - 1][y]); // left
    }

    if (x + 1) < width {
        neightbors.push(map[x + 1][y]) // right
    }

    if y >= 1 {
        neightbors.push(map[x][y - 1]); // top
    }

    if (y + 1) < height {
        neightbors.push(map[x][y + 1]); // bottom
    }

    if x >= 1 && y >= 1 {
        neightbors.push(map[x - 1][y - 1]); // top-left
    }

    if x >= 1 && (y + 1) < height {
        neightbors.push(map[x - 1][y + 1]); // bottom-left
    }

    if (x + 1) < width && (y + 1) < height {
        neightbors.push(map[x + 1][y + 1]); // top-right
    }

    if (x + 1) < width && y >= 1 {
        neightbors.push(map[x + 1][y - 1]); // bottom-right
    }

    return neightbors
}

fn transition(map: Vec<Vec<i8>>) -> Vec<Vec<i8>> {
    let mut tmp_map: Vec<Vec<i8>> = map.clone();
    let width = map.len();
    let height = map[0].len();
    
    for x in 0..width {
        for y in 0..height {
            let neightbors = find_neightbors(&map, x, y);
            let mut num_alive = 0;
            for n in &neightbors {
                if *n == 1 {  num_alive += 1 }
            }

            if num_alive < 2 {
                tmp_map[x][y] = 0; // death by under population
            } else if num_alive > 3 {
                tmp_map[x][y] = 0; // death by over population
            } else if map[x][y] == 0 && num_alive == 3 {
                tmp_map[x][y] = 1; // alive by reproduction
            } else {
                tmp_map[x][y] = map[x][y]; // continue unchanged
            }
        }
    }
    
    return tmp_map;
}

fn print_map(map: &Vec<Vec<i8>>) {
    let width = map.len();
    let height = map[0].len();
    for x in 0..width {
        for y in 0..height {
            if map[x][y] == 1 {
                print!("+ ");
            } else {
                print!("  ");
            }
        }
        println!();
    }
}

fn main() {
    let pentadecathlon = vec![
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        vec![ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    ];

    let mut map = pentadecathlon;
    loop {
        std::process::Command::new("clear").status().unwrap();
        print_map(&map);
        map = transition(map);
        std::thread::sleep(std::time::Duration::from_secs(1));
    }
}
