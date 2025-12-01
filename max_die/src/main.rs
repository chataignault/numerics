use rand_distr::{Distribution, Uniform};

fn main() {
    let n: i32 = 10000;
    let p: i32 = 30;
    let q: i32 = 20;

    // assert that p <= q

    println!("Inputs :");
    println!("- n MC samples : {}", n);
    println!("- p, q for uniform draws : {}, {}", p, q);
    println!();

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

    let mut s0: f64 = 0.;
    // compute s0
    let mut s1: f64 = 0.;
    let mut s2: f64 = 0.;
    for k in 1..q {
        s1 += 1. / k as f64;
        s2 += (k * (k + 1) * (2 * k + 1)) as f64 / (q - k) as f64;
    }
    s0 = 2583. / 20. * s1 - 3. / 400. * s2;
    // end compute s0
    let s_final: f64 = 2. * s0 / 3. + 1317. / 12. / 3.;
    println!("Computed variance : {}", s_final);
    println!();

    let stdmax: f64 = 75.;
    println!("Max std-deviation expected : {}", stdmax);
    // compute portfolio weight
    let w: i64 = (stdmax * stdmax / s_final).floor() as i64;
    println!("Number of games to play : {}", w);
    println!("Expected return : {}", (17 * w) as f64 / 2.);
    println!(
        "Expected ptf std-deviation : {}",
        (s_final * w as f64).sqrt()
    );
    println!(
        "Sharpe ratio : {}",
        (17 as f64 * (w as f64).sqrt()) / (2. * s_final.sqrt())
    );
}
