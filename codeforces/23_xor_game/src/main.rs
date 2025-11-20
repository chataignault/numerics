fn main() {
    // parse number of test cases
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let mut nums = input.split_whitespace();
    let n: i32 = nums.next().unwrap().parse().unwrap();
    
    for _ in 0..n {
        
        // parse list length
        let mut input = String::new();
        std::io::stdin().read_line(&mut input).unwrap();
        let mut nums = input.split_whitespace();
        let k: i32 = nums.next().unwrap().parse().unwrap();
        
        // parse both lists
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let ajisai: Vec<i32> = l
            .split_whitespace()
            .map(|x| x.parse().unwrap())
            .collect();
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let masai: Vec<i32> = l
            .split_whitespace()
            .map(|x| x.parse().unwrap())
            .collect();

        let xor_ajisai: i32 = ajisai.iter().fold(0, |acc, &x| acc ^ x);
        let xor_masai: i32 = masai.iter().fold(0, |acc, &x| acc ^ x);

        if xor_ajisai == xor_masai {
            println!("Tie");
            continue;
        }

        // determine parity of last non-matching index
        let mut i: i32 = k-1;
        while i >= 0 {
            if masai.get(i as usize).unwrap() != ajisai.get(i as usize).unwrap() {
                if i % 2 == 0 { 
                    println!("Ajisai");
                } else {
                    println!("Mai");
                }
                break;
            }
            i -= 1;
        }
        if i == -1 {
            println!("Tie");
        }
    }
}

