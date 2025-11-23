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
        let mut arr = vec![k + 1; m as usize];

        // First pass: process all MEX constraints
        for t in &triplets {
            if let (2, l, r) = t {
                // Check which values from 0..k-1 are already present in the range
                let mut present = vec![false; k as usize];
                for idx in *l-1..*r {
                    let val = arr[idx as usize];
                    if val >= 0 && val < k {
                        present[val as usize] = true;
                    }
                }

                // Collect missing values that need to be placed
                let missing: Vec<i32> = (0..k).filter(|&v| !present[v as usize]).collect();

                // Partition indices by overlap priority
                let mut mexr_overlap_only: Vec<i32> = Vec::new();
                let mut no_overlap: Vec<i32> = Vec::new();
                let mut minr_overlap: Vec<i32> = Vec::new();

                for idx in *l-1..*r {
                    // Skip positions that already have a value from 0..k-1
                    if arr[idx as usize] >= 0 && arr[idx as usize] < k {
                        continue;
                    }

                    let overlaps_minr = minr.iter().any(|(start, end)| *start <= idx && idx <= *end);
                    let overlaps_mexr = mexr.iter().any(|(start, end)| *start <= idx && idx <= *end && (*l-1 != *start || *r-1 != *end));

                    if overlaps_minr {
                        minr_overlap.push(idx);
                    } else if overlaps_mexr {
                        mexr_overlap_only.push(idx);
                    } else {
                        no_overlap.push(idx);
                    }
                }

                // Combine: mexr_overlap_only first, then no_overlap, then minr_overlap (least priority)
                let mut ordered_indices = mexr_overlap_only;
                ordered_indices.extend(no_overlap);
                ordered_indices.extend(minr_overlap);

                // Assign missing values to positions
                for (i, &idx) in ordered_indices.iter().enumerate() {
                    if i < missing.len() {
                        arr[idx as usize] = missing[i];
                    } else {
                        // Ensure k doesn't appear (set to k+1 if needed)
                        if arr[idx as usize] == k {
                            arr[idx as usize] = k + 1;
                        }
                    }
                }
            }
        }

        // Second pass: process all MIN constraints
        for t in &triplets {
            if let (1, l, r) = t {
                // For MIN constraint: ensure at least one position in [l, r] is exactly k
                let has_k = (*l-1..*r).any(|idx| arr[idx as usize] == k);

                if !has_k {
                    // Find a position that's >= k+1 and set it to k
                    for idx in *l-1..*r {
                        if arr[idx as usize] >= k + 1 {
                            arr[idx as usize] = k;
                            break;
                        }
                    }
                }
            }
        }
        println!("{}", arr.iter().map(|x| x.to_string()).collect::<Vec<_>>().join(" "));
    }
}

