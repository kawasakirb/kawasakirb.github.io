---
layout: post
title: "kawasaki.rb #034を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

3/23(水)にNTT-ATさんの会議室にて[kawasaki.rb #034](https://kawasakirb.doorkeeper.jp/events/41521)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/954516)

## パーフェクトRuby読書会

「5-2-2 部分文字列の取得」まで終えました。

本日は自己紹介に45分費やしてからのスタートです。

# 5-2 String

# 5-2-1 基本的な振る舞い

RubyのStringには長さや内容を問い合わせるためのメソッドが用意されています。

{% highlight ruby linenos %}
'hogehoge'.empty? # => false
''.empty? # => true
'hogehoge'.length # => 8
'ほげほげ'.length # => 4
'ほげほげ'.bytesize # => 12
'ほげほげ'.each_char {|c| p c} # =>
# "ほ"
# "げ"
# "ほ"
# "げ"
"ほげほげ\nふがふが".each_line {|l| p l} # =>
# "ほげほげ\n"
# "ふがふが"
'Alice Bob Charlie'.include?('Bob') # => true
'foobar'.index('ob') # => 2
'こんにちは'.index('にち') # => 2
'興味あります'.start_with?('興味') # => true
{% endhighlight %}

演算子を用いることで新たな文字列を得ることも出来ます。

{% highlight ruby linenos %}
'クラッシュ' + 'クラウン' # => "クラッシュクラウン"
'とら' * 3 # => "とらとらとら"
'Result: %04d' % 42 # => "Result: 0042"
{% endhighlight %}

<< を用いると、破壊的な左辺の文字列に右辺の文字列を破壊的に追加できます。

{% highlight ruby linenos %}
str = 'Pine'
str << 'apple'
str # => "Pineapple"
{% endhighlight %}

# 5-2-2 部分文字列の取得

部分文字列を取得するにはString#sliceを用います。

{% highlight ruby linenos %}
str = "今日は盛り上がりすぎて進みませんでした"
str.slice(4) # => "り"
str.slice(5, 4) # => "上がりす"
str.slice(5...8) # => "上がり"
str.slice(/[ぁ-ん]{2,}/) # => "がりすぎて"
str.slice(-2, 2) # => "した"
{% endhighlight %}

String#[]はsliceのショートハンドです。

{% highlight ruby linenos %}
str[4] # => "り"
str[5, 4] # => "上がりす"
str[5...8] # => "上がり"
str[/[ぁ-ん]{2,}/] # => "がりすぎて"
{% endhighlight %}

slice!はレシーバを更新する破壊的メソッドです。

{% highlight ruby linenos %}
str.slice!(-2, 2) # => "した"
str # => "今日は盛り上がりすぎて進みませんで"
str << "したか？" # => "今日は盛り上がりすぎて進みませんでしたか？"
{% endhighlight %}

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb034.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb034.ipynb)

## セッション

### Sparc Solaris向けにGoのクロスコンパイル環境を作った話 from [@snowcrush](https://twitter.com/snowcrush)さん

発表資料は[こちら](https://tanstaafl.0pt.jp/slides/solaris-gccgo/)

"歴史的経緯"によりSparc/Solarisが稼働している社内において、使用可能な言語がJava/Perlしかない状況を打開すべくGoをクロスコンパイルした話をされました。
Goの様々な環境にクロスコンパイルできるところや、アウトプットが1バイナリになりデプロイが容易なのは、充分Goの強みと言えますね。

### TwitterではScalaをどのように活用しているのか? from [@okapies](https://twitter.com/okapies)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/bpqBuXOj1fENSp" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/okapies/reactive-architecture-20160218-58403521" title="リアクティブ・アーキテクチャ ～大規模サービスにおける必要性と課題〜 #devsumi" target="_blank">リアクティブ・アーキテクチャ ～大規模サービスにおける必要性と課題〜 #devsumi</a> </strong> from <strong><a target="_blank" href="//www.slideshare.net/okapies">Yuta Okamoto</a></strong> </div>

Developers Summit 2016で発表された「リアクティブ・アーキテクチャ ～大規模サービスにおける必要性と課題〜」の資料から一部抜粋し、TwitterでのScalaの活用について離されました。
Twitter社が開発したRPCフレームワークである[Finagle](https://github.com/twitter/finagle)、分散トレーシングシステムの[Zipkin](https://github.com/openzipkin/zipkin)、[Scala:The Industrial Parts](https://monkey.org/~marius/scala2015.pdf)の紹介がありました。

### ScalaMatsuriのCode of Conductについて from [@okapies](https://twitter.com/okapies)さん

2016年1月末に行われた(ScalaMatsuri)[http://scalamatsuri.org/]を実施するにあたり、行動規範を制定した話をされました。
ScalaMatsuriで上映された高クオリティな動画を必見です!

ScalaMatsuriの行動規範ページは[こちら](http://scalamatsuri.org/ja/code-of-conduct/)

# 次回予告

次回は2016/4/27(水)(毎月第4水曜日)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

node.jsやiOSアプリ開発を経て今はRailsとDDDとScalaの人。
一眼レフカメラ買いました。
