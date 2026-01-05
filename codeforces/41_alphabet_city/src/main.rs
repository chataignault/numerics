use std::collections::HashMap;

fn main() {
    // parse street information
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let mut nums = input.split_whitespace();
    let n: i32 = nums.next().unwrap().parse().unwrap();
    let m: i32 = nums.next().unwrap().parse().unwrap();

    //println!("Number of streets: {}", n);
    //println!("Number of orders: {}", m);

    // parse street names
    let mut names: Vec<String> = vec![];
    for _ in 0..n {
        let mut street_name = String::new();
        std::io::stdin().read_line(&mut street_name).unwrap();
        // remove trailing white spaces and line breaks
        let street_name = street_name.trim().to_string();
        //println!("{}", street_name);
        names.push(street_name.clone())
    }

    let mut counts: Vec<i32> = vec![];

    // count letters
    let mut letter_count: HashMap<char, i32> = HashMap::new();
    for name in names.iter() {
        for l in name.chars() {
            *letter_count.entry(l).or_insert(0) += 1;
        }
    }
    //println!("Letter counts: {:?}", letter_count);

    // count the maximum number of signs left to constitute the missing sign
    for name in names {
        let mut name_letter_count: HashMap<char, i32> = HashMap::new();
        for l in name.chars() {
            *name_letter_count.entry(l).or_insert(0) += 1;
            *letter_count.get_mut(&l).unwrap() -= 1;
        }
        let mut k = 0;
        for (key, value) in name_letter_count.iter() {
            if *letter_count.get(key).unwrap_or(&0) == 0 {
                k = -1;
                break;
            } else {
                k = std::cmp::max(k, (value - 1) / letter_count.get(key).unwrap() + 1);
            }
        }
        if k > 0 {
            k = m - k
        }
        if k < 0 {
            k = -1
        }
        counts.push(k);
        for (key, value) in name_letter_count.iter() {
            *letter_count.get_mut(&key).unwrap() += value;
        }
    }

    println!(
        "{}",
        counts
            .iter()
            .map(|x| x.to_string())
            .collect::<Vec<_>>()
            .join(" ")
    );
}
