use std::cmp::min;
use rand::distr::{Distribution,Bernoulli};

fn simulate_proba_fortune(n:u32) -> f64 {
    /*
    Monte Carlo simulation to compute the probability of fortune before ruin
     */
    let mut p: f64 = 0.;
    let h: f64 = 1. / n as f64;
    let d = Bernoulli::new(2. / 3.).unwrap();
    for _ in 1..n {
        let mut s = 3;
        while s > 0 && s < 5 {
            // draw bernoulli with probability 2 / 3
            let b: bool = d.sample(&mut rand::rng());
            let c = min(s, 5-s);
            if b {
                s += c;
            } else {
                s -= c;
            }
        }
        if s == 5 {
            p += h;
        }
    }
    p
}

fn main() {
    let n = 1000000;
    let p_exp: f64 = 62. / 77.;
    let p_sim = simulate_proba_fortune(n);
    println!("Expected probability : {}", p_exp);
    println!("Simulated probability : {}", p_sim);
}
