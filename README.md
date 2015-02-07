# my-web-foundation
小規模Webサイト制作用テンプレート

## 使い方
**node.js, npmが必要です。**

1. このリポジトリをプロジェクトフォルダへコピー
2. シェルでプロジェクトフォルダに入って以下のコマンドを実行  
  `> npm i`  
  `> gulp`
3. srcフォルダ内で作業を行うと自動でビルドがかかります。

## ディレクトリ構成
```
Project
└ (release)         -- 自動的に生成されて、リリースビルドが保存される。
│　└ js
│　└ css
└ src
│　└ coffee         -- CoffeeScript (release/jsに出力される）
│　└ styl           -- Stylus (release/cssに出力される）
│　└ jade           -- Jade (release/に出力される）
│
└ Gulpfile.coffee   -- Gulp設定ファイル
└ package.json      -- npm設定ファイル
└ README.md
```
