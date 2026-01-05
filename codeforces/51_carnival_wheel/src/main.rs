use gcd::Gcd;

fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let n: i32 = input.split_whitespace().next().unwrap().parse().unwrap();

    for _ in 0..n {
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let mut args = l.split_whitespace();
        let m: u32 = args.next().unwrap().parse().unwrap();
        let a: u32 = args.next().unwrap().parse().unwrap();
        let b: u32 = args.next().unwrap().parse().unwrap();

        if b == 0 {
            println!("{}", a);
        } else {
            let g: u32 = b.gcd(m);
            println!("{}", a + ((m - 1 - a) / g) * g);
        }
    }
}
