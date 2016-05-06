---
layout: post
title: "kawasaki.rb #035を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

4/27(水)にNTT-ATさんの会議室にて[kawasaki.rb #035](https://kawasakirb.doorkeeper.jp/events/42732)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/968290)

## パーフェクトRuby読書会

「5-2-5 繰り返し処理」まで終えました。

# 5-2-3 文字列の整形

String#stripは文字列の前後の空白文字(半角スペースと\t\r\n\f\v)を取り除いた文字列を返します。
右端のみはString#rstrip、左端のみはString#lstripを用います。

{% highlight ruby linenos %}
str = " hi \t"
str.strip # => "hi"
str.rstrip # => " hi"
str.lstrip # => "hi \t"
{% endhighlight %}

String#chompは末尾の改行コードを一つだけ取り除いた文字列を返します。

{% highlight ruby linenos %}
"hi    \n\n".chomp # => "hi    \n"
{% endhighlight %}

String#compは末尾の一文字を取り除いた文字列を返します。

{% highlight ruby linenos %}
'Users'.chop # => "User"
{% endhighlight %}

会場ではchopってそんなに使う?という話から他の手段がいくつか挙げられました。

{% highlight ruby linenos %}
# sub + 正規表現で末尾文字削除
"foo.".sub(/\.$/,'') # => "foo"
# indexで末尾文字削除
"foo."[0...-1] # => "foo"
{% endhighlight %}

String#squeezeは、文字列の中の連続した部分をまとめることができます。

{% highlight ruby linenos %}
'yahoooooooooooooooooo'.squeeze # => "yaho"
'aabbbccdd'.squeeze('abc') # => "abcdd"
'aabbbccdd'.squeeze('a-c') # => "abcdd"
'aabbbccdd'.squeeze('^a') # => "abcdd"
'      aabb'.squeeze("\s") # => " aabb"
# シングルクォートではスペース文字として判定されない
'      aabb'.squeeze('\s') # => "      aabb"
{% endhighlight %}

大文字や小文字の変換は以下のようなメソッドがあります。

{% highlight ruby linenos %}
# すべて小文字
'ABC'.downcase # => "abc"
# すべて大文字
'abc'.upcase # => "ABC"
# 大文字と小文字を変換
'Abc'.swapcase # => "aBC"
# 先頭のみ大文字
'tiTle'.capitalize # => "Title"
{% endhighlight %}

余談として、ActiveSupportにはさらにメソッドが用意されています。

{% highlight ruby linenos %}
"camel_case".camelize # => CamelCase
"SnakeCase".underscore # => "snake_case"
{% endhighlight %}

文字列置換にはString#subやString#gsubを使用します。
gsubはマッチする文字列全てを置換します。

{% highlight ruby linenos %}
'55-9-7-24'.sub(/[0-9]+/, 'x') # => "x-9-7-24"
'55-9-7-24'.gsub(/[0-9]+/, 'x') # => "x-x-x-x"
# ブロックも渡せる
'55-9-7-24'.gsub(/[0-9]+/) {|str| str.to_i.succ} # => "56-10-8-25"
'55-9-7-24'.gsub(/([0-9]+)/) { $1.to_i.succ } # => "56-10-8-25"
{% endhighlight %}

これらのメソッドには、破壊的メソッドが存在します。

{% highlight ruby linenos %}
str = ' hi '
str.strip! # => "hi"
str # => "hi"
# 変更がない場合nilが返ってたまにハマる
str.strip! # => nil
{% endhighlight %}

String#reverseは文字列を反転させます。

{% highlight ruby linenos %}
'dam'.reverse # => "mad"
'ダムダムダムダムダム'.reverse # => "ムダムダムダムダムダ"
{% endhighlight %}

# 5-2-4 配列への変換

String#splitは渡されたセパレータで文字列を分割します。

{% highlight ruby linenos %}
str = 'America, Briten, Canada'

str.split(',') # => ["America", " Briten", " Canada"]
# 正規表現も渡せる
str.split(/,\s+/) # => ["America", "Briten", "Canada"]
# 第二引数は分割する最大値を指定できる
str.split(/,\s+/, 2)[1] # => "Briten, Canada"
{% endhighlight %}

splitやeach_charで、文字列を文字ごとの配列にすることができます。

{% highlight ruby linenos %}
'Alice'.split(//) # => ["A", "l", "i", "c", "e"]
'Alice'.each_char.to_a # => ["A", "l", "i", "c", "e"]
{% endhighlight %}

# 5-2-5 繰り返し処理

each_charにはブロックを渡すこともできます。

{% highlight ruby linenos %}
'ブフー'.each_char { |c| c}
# =>
# "ブ"
# "フ"
# "ー"
{% endhighlight %}

改行ごとに繰り返すにはeach_lineを使用します。

{% highlight ruby linenos %}
"Alice\nBob\nCarrot".each_line{|line| line}
# =>
# "Alice\n"
# "Bob\n"
# "Carrot"
{% endhighlight %}

each_lineの引数には改行とみなす文字列を指定することができます。
デフォルトでは変数$/が使用されます。

{% highlight ruby linenos %}
$/ # => "\n" # 環境で変わる

"Alice\tBob\tCarrot".each_line("\t"){|line| line}
{% endhighlight %}

次回は「5-2-6 エンコーディングの扱い」からです。

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb035.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb035.ipynb)

## セッション

### Enumerableモジュールを機能(ほぼ)全部まとめ 〜 select, inject, take などなど from [@kon_yu](https://twitter.com/kon_yu)

Enumerableに備わっているメソッドの使い方と、それをeachで書いたらこんなに大変!という話をされました。
一方で、zipやlazyとか使う?という話から会場から意見さまざまな意見が出されました。

発表元となった記事は[こちら](http://qiita.com/kon_yu/items/402b9610f25c384a69aa)

# Rubyで体重を量る話 from [@xmisao](https://twitter.com/xmisao)

TANITAが販売している体組成計がWifiを経由してTANITAのサーバにデータを送っており、それをREST APIで取得できることから、Gemという形でクライアントを作った話をされました。

発表元となったGemは[こちら](https://github.com/xmisao/xhp)


# 次回予告

次回は2016/5/25(水)(毎月第4水曜日)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

node.jsやiOSアプリ開発を経て今はRailsとDDDとScalaの人。
最近ちょっとだけGoに浮気した。
