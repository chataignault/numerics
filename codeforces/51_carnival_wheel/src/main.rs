use gcd::Gcd;

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
        let mut b: u32 = args.next().unwrap().parse().unwrap();
        b = b % (m - 1);
        if a == 0 && b == 0 {
            println!("0");
        } else if b == 0 {
            println!("{}", a);
        } else {
            let g: u32 = a.gcd(b);
            println!("{}", ((m-1) / g) * g);
        }
    }
}
