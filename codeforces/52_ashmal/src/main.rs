fn main() {
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let n: u32 = input.split_whitespace().next().unwrap().parse().unwrap();

    for i in 0..n {
        let mut m_ = String::new();
        std::io::stdin().read_line(&mut m_).unwrap();
        let m: u32 = m_.split_whitespace().next().unwrap().parse().unwrap();

        let mut l = String::new();
        std::io::stdin().read_line(&mut l).unwrap();
        let words: Vec<String> = l.split_whitespace().map(|s| s.to_string()).collect();

        let s = words.iter().fold(String::new(), |acc, word| {
            let prepend = format!("{}{}", word, acc);
            let append = format!("{}{}", acc, word);
            if prepend < append { prepend } else { append }
        });
        println!("{}", s);
    }
}
