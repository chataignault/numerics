fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let mut nums = input.split_whitespace();
    let a: i32 = nums.next().unwrap().parse().unwrap();
    let b: i32 = nums.next().unwrap().parse().unwrap();
    
    for i in 0..a {
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();

        let nums: Vec<i32> = l
            .split_whitespace()
            .map(|x| x.parse().unwrap())
            .collect();

        println!("{:?}", nums);
    }
    println!("{} {}", a, b);
}

