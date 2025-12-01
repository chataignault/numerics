use clap::Parser;
use rand_distr::{Distribution, Uniform};

#[derive(Parser, Debug)]
#[command(name = "max_die")]
#[command(about = "Monte Carlo simulation for max die game", long_about = None)]
struct Args {
    /// Number of Monte Carlo samples
    #[arg(short, long, default_value_t = 100000)]
    n: i32,

    /// Upper bound for first uniform distribution (1 to p)
    #[arg(short, long, default_value_t = 30)]
    p: i32,

    /// Upper bound for second uniform distribution (1 to q)
    #[arg(short, long, default_value_t = 20)]
    q: i32,

    /// Maximum standard deviation allowed
    #[arg(short, long, default_value_t = 75.0)]
    stdmax: f64,
}

fn main() {
    let args = Args::parse();

    let n = args.n;
    let p = args.p;
    let q = args.q;
    let stdmax = args.stdmax;

    // Validate that p > q
    if p <= q {
        eprintln!("Error: p must be greater than q (p={}, q={})", p, q);
        std::process::exit(1);
    }

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
    let exp_p_squared_analytical = (3 * q * (q + 1) * (q + 1) - 2 * (q + 1) * (2 * q + 1)
        + p * (p + 1) * (2 * p + 1)
        - q * (q + 1) * (2 * q + 1)) as f64
        / (6 * p) as f64;

    // Deduce analytical variance
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
