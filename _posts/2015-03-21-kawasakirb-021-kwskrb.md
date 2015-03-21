---
layout: post
title: "kawasaki.rb #021を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

2/25(水)にNTT-ATさんの会議室にて[kawasaki.rb #021](https://kawasakirb.doorkeeper.jp/events/20894)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/788732)

## パーフェクトRuby読書会

3-5-10 キーワード引数まで終えました。

iruby notebookは以下のとおり。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb021.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb021.ipynb)

今回のハイライトはキーワード引数に`true`という引数が使えるという話でした。

<blockquote class="twitter-tweet" lang="ja"><p>```&#10;def bar(true: )&#10; p true&#10;end&#10;&#10;bar(true: false)&#10;&#10;=&gt; true&#10;```&#10;&#10;キモい <a href="https://twitter.com/hashtag/kwskrb?src=hash">#kwskrb</a></p>&mdash; We&#39;re hiring (@ryonext) <a href="https://twitter.com/ryonext/status/570540633577779200">2015, 2月 25</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


## [@xmisao](http://twitter.com/xmisao)さん「Gem::Specification#filesの話」

[技あり! gemspec中でファイル一覧を取得する -- ぺけみさお](http://www.xmisao.com/2014/08/26/get-all-files-in-gemspec.html)の話をまとめていただきました。

ファイル一覧をどうとるか、gemごとに紹介していました。

## [@ryonext](https://twitter.com/ryonext)さん「PumaでActiveRecordのErrorが出てハマった話」

[PumaでActiveRecordのErrorが出てハマった話 - 月曜日までに考えておきます](http://ryonext.hatenablog.com/entry/2015/02/25/164928)の話をしていただきました。

外部APIサーバが重くてUnicornでは死ぬのでPumaを使っていたけど、コネクションプールを増やさないとスレッド数増やす効果がでなかったようです。


## chezou「数字で振り返る神奈川Ruby会議」

神奈川Ruby会議のアンケートの内容を振り返りました。

## まとめ

「ブログを書くまでが勉強会です」と言ったら、多くの方がブログを書いてくれました。多謝

- [Kawasaki.rb 参加してきました #kwskrb - 月曜日までに考えておきます](http://ryonext.hatenablog.com/entry/2015/02/26/212557)
- [kawasaki.rb #21に参加してきました #kwskrb - 海苔座布団日記](http://norizabuton.hateblo.jp/entry/2015/02/27/142616)
- [新米プログラマがWebサービスで起業を目論む: kawasaki.rb でのruby勉強会(1)](http://ohmyrails.blogspot.jp/2015/02/kawasakirb-ruby1.html)
- [新米プログラマがWebサービスで起業を目論む: kawasaki.rb でのruby勉強会(1)](http://ohmyrails.blogspot.jp/2015/02/kawasakirb-ruby1.html)


次回は、3/25(水)に開催します。参加募集は[こちら](https://kawasakirb.doorkeeper.jp/events/22368)
