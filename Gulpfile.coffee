g       = require("gulp")
$       = do require "gulp-load-plugins"

spawn   = require("child_process").spawn
bs      = require "browser-sync"
nib     = require "nib"

# coffeescript task
g.task "cs", ->
    g.src [
        "./src/coffee/**/*.coffee",
        "!./src/coffee/**/_*.coffee",
        "!./src/coffee/_*/**"
    ]
        .pipe $.plumber()
        .pipe $.coffee()
        .pipe $.uglify()
        .pipe g.dest("./release/js/")

# stylus task
g.task "stylus", ->
    g.src [
        "./src/styl/**/*.styl",
        "!./src/styl/**/_*.styl",
        "!./src/styl/_*/**"
    ]
        .pipe $.plumber()
        .pipe $.stylus
            use         : nib()
            compress    : true
            sourcemap   :
                #inline      : true
                sourceRoot  : '.'
        .pipe g.dest("./release/css/")

# jade task
g.task "jade", ->
    g.src [
        "./src/jade/**/*.jade",
        "!./src/jade/**/_*.jade",
        "!./src/jade/_*/**"
    ]
        .pipe $.plumber()
        .pipe $.jade()
        .pipe $.prettify()
        .pipe g.dest("./release/")

# Image copy task
g.task "images", ->
    g.src [
        "./src/img/**/*",
        "!./src/img/**/_*.*",
        "!./src/img/_*/**",
    ]
        .pipe g.dest("./release/img/")

# File watch task
g.task "watch", ->
    g.watch "./src/coffee/**/*.coffee", ["cs"]
    g.watch "./src/styl/**/*.styl", ["stylus"]
    g.watch "./src/jade/**/*.jade", ["jade"]
    g.watch "./src/img/**/*", ["images"]

# Browser-sync task
g.task "bs", ->
    bs
        port    : 3000
        open    : true
        notify  : true
        files   : "release/**"
        index   : "index.html"
        server  :
            baseDir : "release/"

# Gulpfile watcher
g.task "self-watch", ["cs", "stylus", "jade", "images", "bs"], ->
    proc = null
    spawnChildren = ->
        proc.kill() if proc?
        proc = spawn 'gulp', ["watch"], {stdio: 'inherit'}

    g.watch ["Gulpfile.coffee"], spawnChildren
    spawnChildren()

    # watch `./release` dir
    g.watch "./release/**/*", bs.reload

g.task "default", ["self-watch"]
