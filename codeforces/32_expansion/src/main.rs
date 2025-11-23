use std::cmp::{max,min};

fn main() {
    // parse number of test cases
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let n: i32 = input.split_whitespace().next().unwrap().parse().unwrap();
    
    // iterate over test cases
    for _ in 0..n {
        
        // parse test case arguments 
        let mut args = String::new();
        std::io::stdin().read_line(&mut args).unwrap();
        let mut nums = args.split_whitespace();
        let k: i32 = nums.next().unwrap().parse().unwrap();
        let mut x: i32 = nums.next().unwrap().parse().unwrap();
        let mut y: i32 = nums.next().unwrap().parse().unwrap();
    
        // parse input string
        let mut actions = String::new();
        std::io::stdin().read_line(&mut actions).unwrap();
        
        // count each actions
        let mut man: i32 = 0;
        let mut mas: i32 = 0;
        for s in actions.chars() {
            if s == '4' {
                man += 1;
            } else if s == '8' {
                mas += 1;
            }
        }
        
        if x > 0 {x = max(0, x - mas);} else {x = min(0, x + mas)};
        if y > 0 {y = max(0, y - mas);} else {y = min(0, y + mas)};
        if x.abs() + y.abs() <= man {
            println!("yes")
        } else {
            println!("no")
        }
    }
}

