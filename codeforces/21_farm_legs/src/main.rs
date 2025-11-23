fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let mut nums = input.split_whitespace();
    let N: i32 = nums.next().unwrap().parse().unwrap();
    for _ in 0..N {
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let k: i32 = l.split_whitespace().next().unwrap().parse().unwrap();
        if k % 2 == 1 {
            println!("0");
        } else {
            println!("{}", k / 4 + 1);
        }
    }
}
