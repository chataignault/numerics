use std::collections::HashMap;

fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let mut nums = input.split_whitespace();
    let n: i32 = nums.next().unwrap().parse().unwrap();

    for _ in 0..n {
        let mut le = String::new();
        std::io::stdin().read_line(&mut le).unwrap();
        //let k: i32 = le.split_whitespace().next().unwrap().parse().unwrap();

        let mut list = String::new();
        std::io::stdin().read_line(&mut list).unwrap();
        let nums: Vec<i32> = list
            .split_whitespace()
            .map(|x| x.parse().unwrap())
            .collect();

        let mut dict: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            if dict.contains_key(&num) {
                *dict.get_mut(&num).unwrap() += 1;
            } else {
                dict.insert(num, 1);
            }
        }
        let mut rmn: i32 = 0;
        for (&key, &value) in &dict {
            if key < value {
                rmn += value - key;
            } else if key > value {
                rmn += value
            }
        }
        println!("{}", rmn);
    }
}
