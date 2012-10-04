class dotdeb($key = 'http://www.dotdeb.org/dotdeb.gpg', $lenny_php53 = '') {
    class{ "dotdeb::install":
    } -> anchor { 'dotdeb::end': }
}
