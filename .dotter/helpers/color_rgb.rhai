fn reverse(string) {
    if string.len == 1 {
        return string;
    } else {
        return reverse(string.sub_string(1)) + string[0];
    }
}

fn hexToNum(hex) {
    let base = 16;
    // Maps have to have strings as keys even though this should be a character.
    let hexValue = #{
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "a": 10,
        "b": 11,
        "c": 12,
        "d": 13,
        "e": 14,
        "f": 15,
    };


    let power = 0;
    let num = 0;
    for char in reverse(hex).chars() {
        num += hexValue[char.to_string()] * (base**power);
        power += 1;
    }

    return num;
}

let hex = params[0];
if hex.len == 3 {
    hex = "" + hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
}
if hex.len != 6 {
    throw "Input length must be 3 or 6"
}

"rgb(" + hexToNum(hex.sub_string(0, 2)) + ", " + hexToNum(hex.sub_string(2, 2)) + ", " + hexToNum(hex.sub_string(4, 2)) + ")"
