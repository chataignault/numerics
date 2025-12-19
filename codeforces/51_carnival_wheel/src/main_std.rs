fn gcd(mut a: u32, mut b: u32) -> u32 {
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a
}

fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let n: i32 = input.split_whitespace().next().unwrap().parse().unwrap();

    for i in 0..n {
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let mut args = l.split_whitespace();
        let m: u32 = args.next().unwrap().parse().unwrap();
        let a: u32 = args.next().unwrap().parse().unwrap();
        let b: u32 = args.next().unwrap().parse().unwrap();

        if b == 0 {
            println!("{}", a);
        } else {
            let g: u32 = gcd(b, m);
            println!("{}", a + ((m - 1 - a) / g) * g);
        }
    }
}
