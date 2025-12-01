use rand_distr::{Distribution, Uniform};

fn main() {
    let n: i32 = 100000;
    let p: i32 = 30;
    let q: i32 = 20;

    let stdmax: f64 = 75.;

    // assert that p < q, else exit the program : value error

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
    let exp_p_simulated: f64 = (s as f64) / (n as f64);
    let exp_p_squared: f64 = (v as f64) / (n as f64);
    let exp_var: f64 = exp_p_squared - exp_p_simulated * exp_p_simulated;

    let exp_p_analytical: f64 = ((p * (p + 1) - q * (q + 1)) as f64) / (2. * p as f64);

    println!("===NUMERICAL VERIFICATION===");
    println!("Expected return : {}", exp_p_analytical);
    println!("Empirical mean return : {}", exp_p_simulated);
    println!();
    println!("Simulated variance : {}", exp_var);
    println!("Simulated standard deviation : {}", exp_var.sqrt());
    println!();

    // Compute E[P²] analytically
    // E[P²] = (1/pq) * [2·Σ_{x=1}^q x²(x-1) + q·Σ_{x=q+1}^p x²]
    let mut sum_x_cubed_minus_x_squared: f64 = 0.;
    for x in 1..=q {
        sum_x_cubed_minus_x_squared += (x * x * (x - 1)) as f64;
    }

    let mut sum_x_squared_above_q: f64 = 0.;
    for x in (q + 1)..=p {
        sum_x_squared_above_q += (x * x) as f64;
    }

    let exp_p_squared_analytical: f64 =
        (2. * sum_x_cubed_minus_x_squared + q as f64 * sum_x_squared_above_q) / (p * q) as f64;

    let variance_analytical: f64 = exp_p_squared_analytical - exp_p_analytical * exp_p_analytical;

    println!("Analytical E[P] : {}", exp_p_analytical);
    println!("Analytical Var(P) : {}", variance_analytical);
    println!("Analytical std(P) : {}", variance_analytical.sqrt());
    println!();

    println!("===RISK LIMIT CONSIDERATIONS===");
    println!("Max std-deviation allowed : {}", stdmax);

    // compute portfolio weight
    let w: i64 = (stdmax * stdmax / variance_analytical).floor() as i64;

    println!("Number of games to play : {}", w);
    println!("Expected return : {}", w as f64 * exp_p_analytical);
    println!(
        "Expected ptf std-deviation : {}",
        (variance_analytical * w as f64).sqrt()
    );
    println!(
        "Sharpe ratio : {}",
        (w as f64).sqrt() * exp_p_analytical / variance_analytical.sqrt()
    );
}
