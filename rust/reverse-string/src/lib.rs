pub fn reverse(input: &str) -> String {
    let mut res = String::from("");

    for c in input.chars() {
        res.insert(0, c);
    }
    res
}
