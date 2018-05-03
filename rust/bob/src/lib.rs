extern crate regex;
use regex::Regex;

pub fn reply(message: &str) -> &str {
    match message.trim() {
        c if c == "" => "Fine. Be that way!",
        c if c.ends_with("?") && is_shouting(c) => "Calm down, I know what I'm doing!",
        c if is_shouting(c) => "Whoa, chill out!",
        c if c.ends_with("?") => "Sure.",
        _ => "Whatever.",
    }
}

fn is_shouting(c: &str) -> bool {
    let re = Regex::new(r"[a-zA-Z]").unwrap();
    let clean = re.replace_all(c, "");

    clean != c && c == c.to_uppercase()
}
