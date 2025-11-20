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

        // Find the highest bit position across both arrays
        let max_ajisai = ajisai.iter().copied().max().unwrap_or(0);
        let max_masai = masai.iter().copied().max().unwrap_or(0);
        let max_val = std::cmp::max(max_ajisai, max_masai);
        let mut m = if max_val > 0 {
            max_val.ilog2() as i32
        } else {
            0
        };
        
        // Check whether ajisai or masai tie on the highest bit
        // Count parity of occurrences where bit m is set
        // loop over m .. 0 until m_c_ajisai and m_c_mai are different.
        // each step : m -= 1
        let mut tie = false;
        loop {
            let m_c_ajisai = ajisai.iter().fold(0, |acc, &x| if (x & (1 << m)) != 0 { acc ^ 1 } else { acc });
            let m_c_mai = masai.iter().fold(0, |acc, &x| if (x & (1 << m)) != 0 { acc ^ 1 } else { acc });

            if m_c_ajisai != m_c_mai {
                break;
            }

            if m == 0 {
                println!("Tie");
                tie = true;
                break;
            }

            m -= 1;
        }
        if tie {
            continue;
        }


        let mut i: i32 = k-1;
        while i >= 0 {
            // compare only the highest bit "m"
            if (masai.get(i as usize).unwrap() & (1 << m)) != (ajisai.get(i as usize).unwrap() & (1 << m)) {
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

