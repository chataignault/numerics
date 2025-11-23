fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let n: i32 = input.split_whitespace().next().unwrap().parse().unwrap();
    
    for _ in 0..n {
        let mut args = String::new();
        std::io::stdin().read_line(&mut args).unwrap();
        let mut nums = args.split_whitespace();
        let m: i32 = nums.next().unwrap().parse().unwrap();
        let k: i32 = nums.next().unwrap().parse().unwrap();
        let q: i32 = nums.next().unwrap().parse().unwrap();
        
        let mut triplets = Vec::new();

        for _ in 0..q {
            let mut list = String::new();
            std::io::stdin().read_line(&mut list).unwrap();
            let nums: Vec<i32> = list
                .split_whitespace()
                .map(|x| x.parse().unwrap())
                .collect();

            let triplet = (nums[0], nums[1], nums[2]);
            triplets.push(triplet);
        }

        // gather the mex ranges
        let mut mexr = vec![];
        for t in &triplets {
            if t.0 == 2 {
                mexr.push((t.1 - 1, t.2 - 1));
            }
        }
        // gather min ranges
        let mut minr = vec![];
        for t in &triplets {
            if t.0 == 1 {
                minr.push((t.1 - 1, t.2 - 1));
            }
        }

        // construct the meximum list with constraints
        let mut arr = vec![k; m as usize];
        for t in triplets {
            match t {
                (1, l, r) => {},
                (2, l, r) => {
                    let indices: Vec<i32> = (l-1..r)
                        .filter(|&idx| {
                            !minr.iter().any(|(start, end)| *start <= idx && idx <= *end)
                        })
                        .collect();
                    // Partition indices into mexr-overlapping and non-overlapping
                    let mut mexr_overlap: Vec<i32> = Vec::new();
                    let mut no_overlap: Vec<i32> = Vec::new();
                    for &idx in &indices {
                        if mexr.iter().any(|(start, end)| *start <= idx && idx <= *end && (l-1 != *start || r-1 != *end)) {
                            mexr_overlap.push(idx);
                        } else {
                            no_overlap.push(idx);
                        }
                    }

                    // Combine: mexr_overlap first (gets priority for lowest values)
                    let mut ordered_indices = mexr_overlap;
                    ordered_indices.extend(no_overlap);
                    // Fill with values 0 to k-1, then k+1
                    for (i, &idx) in ordered_indices.iter().enumerate() {
                        if i < k as usize {
                            arr[idx as usize] = i as i32;
                        } else {
                            arr[idx as usize] = k + 1;
                        }
                    }
                    let indices: Vec<i32> = (l-1..r)
                        .filter(|&idx| {
                            minr.iter().any(|(start, end)| *start <= idx && idx <= *end)
                        })
                        .collect();
                    for i in indices {
                        arr[i as usize] = k + 1;
                    }

                },
                _ => {}
            }
        }
        println!("{}", arr.iter().map(|x| x.to_string()).collect::<Vec<_>>().join(" "));
    }
}

