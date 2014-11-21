g       = require("gulp")
$       = do require "gulp-load-plugins"

bs      = require "browser-sync"
nib     = require "nib"

g.task "bs", ->
    bs
        port    : 3000
        open    : true
        notify  : true
        files   : "release/**"
        index   : "index.html"
        server  :
            baseDir : "release/"

g.task "cs", ->
    g.src ["./src/coffee/**/*.coffee", "!**/_*.coffee", "!**/_*/**"]
        .pipe $.coffee()
        .pipe $.uglify()
        .pipe g.dest("./release/js/")

g.task "stylus", ->
    g.src ["./src/styl/**/*.styl", "!**/_*.styl", "!**/_*/**"]
        .pipe $.stylus
            use         : nib()
            compress    : true
            sourcemap   :
                #inline      : true
                sourceRoot  : '.'
        .pipe g.dest("./release/css/")

g.task "jade", ->
    g.src ["./src/jade/**/*.jade", "!**/_.jade", "!**/_*/**"]
        .pipe $.jade()
        .pipe g.dest("./release/")

g.task "watch", ["bs"], ->
    g.watch "./src/coffee/**/*.coffee", ["cs"]
    g.watch "./src/stylus/**/*.styl", ["stylus"]
    g.watch "./src/jade/**/*.jade", ["jade"]

g.task "default", ["watch"]
