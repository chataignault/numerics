use rand_distr::{Distribution,Uniform};

fn main() {
    let n: i32 = 10000;
    let p: i32 = 30;
    let q: i32 = 20;

    println!("Compute Monte Carlo estimates :");
    let x_dist = Uniform::new_inclusive(1, p).unwrap();
    let y_dist = Uniform::new_inclusive(1, q).unwrap();
    let mut s: i64 = 0;
    let mut v: i64 = 0;
    let mut rng = rand::rng();
    for _ in 0..n {
        let x: i64 = x_dist.sample(&mut rng) as i64;
        let y: i64 = y_dist.sample(&mut rng) as i64;
        if x > y {
            s += x;
            v += x * x;
        } else if x < y {
            s -= y;
            v += y * y;
        }
    }
    let exp_return: f64 = (s as f64) / (n as f64);
    let exp_var: f64 = (v as f64) / (n as f64) - exp_return * exp_return;
    println!("Expected return : {}", 8.5);
    println!("Simulated return : {}", exp_return);
    println!();
    println!("Simulated variance : {}", exp_var);
    println!("Simulated standard deviation : {}", exp_var.sqrt());
}
