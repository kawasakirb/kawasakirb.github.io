---
layout: post
title: "kawasaki.rb #039を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

2016年7月27日(水)にNTT-ATさんの会議室にて[kawasaki.rb #039](https://kawasakirb.doorkeeper.jp/events/50947){:target="_blank"}を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/1016269){:target="_blank"}

## パーフェクトRuby読書会

# 5-3-4 先頭と末尾

「\A」は文字列の先頭、「\z」は末尾を表します。

{% highlight ruby linenos %}
pattern = /\A\d{3}-\d{4}-\d{4}\z/

pattern === '080-1234-5678' # => true
pattern === 'Phone: 080-1234-5678' # => false
pattern === '080-1234-5678 (mobile)' # => false
{% endhighlight %}

「^」と「$」は文字列全体ではなく行頭と行末を表します。

{% highlight ruby linenos %}
lines = "1234\nabcd"

/\A\d+\z/ === lines # => false
/\^\d+\$/ === lines # => true (1行目でマッチする)
{% endhighlight %}

# 5-3-5 グルーピングと後方参照/部分式呼び出し

()によるグルーピングを行った箇所は後で「\1」や「\2」という形で参照できます。
「/(B)\ to\ \1/」には 'B to B'がマッチします。これを後方参照といいます。

todo

{% highlight ruby linenos %}
/(B)\ to\ \1/ === 'B to B' # => true ('B to B'がマッチ)

$1 # => "B" (直前にマッチした文字列)
{% endhighlight %}

グルーピングにはラベルをつけることができます。

{% highlight ruby linenos %}
/(?<number>[0-9]+)/ === 'abc-123'

Regexp.last_match[:number] # => "123"
{% endhighlight %}

「\k<name>」のようにして後方参照にも使用できます。

{% highlight ruby linenos %}
/(?<num>[0-9]+)[a-c\-]+\k<num>/ === '123-abc-123'
{% endhighlight %}

なおRuby 2.4では MatchData#named_captures が追加されるようです。
既に2.4.0のpreviewに含まれているので試すことが可能です。

[Ruby Doc](http://ruby-doc.org/core-2.4.0_preview1/MatchData.html#method-i-named_captures)

[ISSUE](https://bugs.ruby-lang.org/issues/11999)

「\g<n>」と記述することで部分式呼び出しを使用することができます。

{% highlight ruby linenos %}
phone = '080-1234-5678'

# 「\g<1>」は「([0-9]+)」に置き換えられる
/([0-9]+)-\g<1>-\g<1>/ === phone # => true

# 「\1」は最初にマッチした "080" となるため、これはマッチしない
/([0-9]+)-\1-\1/ === phone # => false

# こちらはマッチする
/([0-9]+)-\1-\1/ === '080-080-080' # => true

# ラベルの指定も可能
/(?<num>[0-9]+)-\g<num>-\g<num>/ === phone # => true
{% endhighlight %}


正規表現の後方参照は他の言語にも採用されているのか?という話になり、調べたところ正規表現エンジンの鬼車(Ruby 2.0からは鬼雲)由来のものらしく、これを搭載した言語であれば使えそう、という結論になりました。[参考](http://d.hatena.ne.jp/atzy/20080910/p1)

次回は「5-3-6 先読みと後読み」からです。

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb039.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb039.ipynb)

## セッション

本日のセッションは4本(うち2本はオフレコ)ありました。

# 英語ブログをhugoで書き始めた話 from [@chezouさん](https://twitter.com/chezou)

英語ブログをGOで実装された、JekyllライクWebサイトエンジンHUGOで運営しはじめた話をされました。
HUGOの良い所はJekyllのようにRubyとGemをインストールする手間がなくbrew installで完結(Goを入れる必要もない)し、Webページのビルドも高速なところだそうです。
また、ドメインはgandi.netで取得したそうです。(メールボックスが5個までついてくるらしい)

chezouさんの英語ブログは[こちら](https://chezo.uno/)

[HUGO](https://gohugo.io/)

[gandi.net](http://www.gandi.net/)

# capistranoでエラーが発生する相談 from [@take_she12](https://twitter.com/take_she12)

capistrano経由でコマンドを実行したらエラーで失敗してしまう、という話をされました。
具体的には

{% highlight linenos %}
$ /usr/bin/env if test true;then echo "hoge";fi
-bash: 予期しないトークン `then' 周辺に構文エラーがあります
{% endhighlight %}

というエラーが発生するというもの。
/usr/bin/env からtestが見つからないのは恐らくtimeがbashの組み込み関数によるからで、
bash -c 経由でコマンドを渡してあげれば良いかもしれない、という結論になりました。

# 次回予告

次回は2016年9月28日(水)(毎月第4水曜日)開催予定です。お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

node.jsやiOSアプリ開発を経て今はRailsとDDDとScalaの人。
