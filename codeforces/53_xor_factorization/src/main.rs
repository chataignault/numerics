fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let t: u32 = input.split_whitespace().next().unwrap().parse().unwrap();

    for i in 0..t {
        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let mut args = l.split_whitespace();
        let n: u32 = args.next().unwrap().parse().unwrap();
        let k: u32 = args.next().unwrap().parse().unwrap();

        if k % 2 == 1 {
            println!(
                "{}",
                (0..k).map(|_| n.to_string()).collect::<Vec<_>>().join(" ")
            );
        } else {
            // Find the highest power of 2 <= n (this will be our starting b)
            let mut b = 1;
            while b * 2 <= n {
                b *= 2;
            }
            let mut a = n - b;

            // Maximize a + b by adding shared bits where n has 0s
            // Both a+x and b+x must remain <= n
            let max_add = std::cmp::min(n - a, n - b);

            // Build x using only bit positions where n has 0s
            // Check from highest bit down to maximize x
            let mut x = 0;
            for i in (0..32).rev() {
                let bit = 1 << i;
                if (n & bit) == 0 {
                    // n doesn't have this bit
                    if x + bit <= max_add {
                        x += bit;
                    }
                }
            }

            a += x;
            b += x;

            if k == 2 {
                println!("{} {}", a, b);
            } else {
                let c: String = (0..(k - 2))
                    .map(|_| n.to_string())
                    .collect::<Vec<_>>()
                    .join(" ");
                println!("{} {} {}", a, b, c);
            }
        }
    }
}
