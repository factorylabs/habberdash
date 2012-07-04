String::trim = -> @replace(/^\s+|\s+$/g, '')
String::toCamel = -> @replace(/([\-|_][a-z])/g, ($1) -> $1.toUpperCase().replace(/[\-|_]/, ''))
String::toDash = -> @replace(/([A-Z])/g, ($1) -> "-#{$1.toLowerCase()}").replace(/\s+/, '-').replace(/^-|-$/, '').replace(/-+/, '-')
String::toUnderscore = -> @replace(/([A-Z])/g, ($1) -> "_#{$1.toLowerCase()}")
