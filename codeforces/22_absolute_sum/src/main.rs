fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let mut nums = input.split_whitespace();
    let n: i32 = nums.next().unwrap().parse().unwrap();
    for _ in 0..n {
        // find minimal absolute sum,
        // filling the gaps in the input array

        // parse the length of the list
        let mut input = String::new();
        std::io::stdin().read_line(&mut input).unwrap();
        let mut k_ = input.split_whitespace();
        let k: i32 = k_.next().unwrap().parse().unwrap();

        // parse the list
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let nums: Vec<i32> = l.split_whitespace().map(|x| x.parse().unwrap()).collect();

        match (nums.first().unwrap(), nums.get((k - 1) as usize).unwrap()) {
            (-1, -1) => {
                println!("0");
                let updated: Vec<i32> = nums.iter().map(|&x| if x == -1 { 0 } else { x }).collect();
                println!(
                    "{}",
                    updated
                        .iter()
                        .map(|x| x.to_string())
                        .collect::<Vec<_>>()
                        .join(" ")
                );
            }
            (a, -1) if *a != -1 => {
                println!("0");
                let mut updated: Vec<i32> = nums.clone();
                updated[(k - 1) as usize] = *a;
                let updated: Vec<i32> = updated
                    .iter()
                    .map(|&x| if x == -1 { 0 } else { x })
                    .collect();
                println!(
                    "{}",
                    updated
                        .iter()
                        .map(|x| x.to_string())
                        .collect::<Vec<_>>()
                        .join(" ")
                );
            }
            (-1, b) if *b != -1 => {
                println!("0");
                let mut updated: Vec<i32> = nums.clone();
                updated[0] = *b;
                let updated: Vec<i32> = updated
                    .iter()
                    .map(|&x| if x == -1 { 0 } else { x })
                    .collect();
                println!(
                    "{}",
                    updated
                        .iter()
                        .map(|x| x.to_string())
                        .collect::<Vec<_>>()
                        .join(" ")
                );
            }
            (a, b) => {
                println!("{}", (a - b).abs());
                let updated: Vec<i32> = nums.iter().map(|&x| if x == -1 { 0 } else { x }).collect();
                println!(
                    "{}",
                    updated
                        .iter()
                        .map(|x| x.to_string())
                        .collect::<Vec<_>>()
                        .join(" ")
                );
            }
            _ => {
                println!("Invalid array access");
            }
        }
    }
}
