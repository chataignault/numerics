
fn simulate_proba_fortune(N:u32) -> f64 {
    /*
    Monte Carlo simulation to compute the probability of fortune before ruin
     */
    let mut p: f64 = 0.;
    let h: f64 = 1. / N;
    for k in 1..N {
        let mut s = 3;
        while s > 0 and s < 5 {
            // draw bernoulli with probability 2 / 3
            let b: u8 = 0;
            let c = max(s, 5-s);
            if b == 1 {
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
    let N = 10000;
    let p_exp: f64 = .8;
    let p_sim = simulate_proba_fortune(N);
    println!("Expected probability : {}", p_exp);
    println!("Simulated probability : {}", p_sim);
}
