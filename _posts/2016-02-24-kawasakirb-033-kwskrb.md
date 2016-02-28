---
layout: post
title: "kawasaki.rb #033を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

2/24(水)にNTT-ATさんの会議室にて[kawasaki.rb #033](https://kawasakirb.doorkeeper.jp/events/39331)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/943957)

## パーフェクトRuby読書会

「5-1-8 Complex」まで終えました。

# 5-1-5 Integer

Rubyでは小さな整数はFixnum, 大きい整数はBignumのインスタンスとして扱われます

{% highlight ruby linenos %}
100.class # => Fixnum
10000000000000000000.class # => Bignum
{% endhighlight %}

2の何乗からBignumになるのか?を検証したところ62乗からBignumとなりました。

{% highlight ruby linenos %}
60.upto(70) {|i| puts "#{i}: #{(2 ** i).class}" }
# 60: Fixnum
# 61: Fixnum
# 62: Bignum
# 63: Bignum
# 64: Bignum
# 65: Bignum
# 66: Bignum
# 67: Bignum
# 68: Bignum
# 69: Bignum
# 70: Bignum
{% endhighlight %}

Integerには様々な述語メソッドが用意されています.

{% highlight ruby linenos %}
1.odd? # => true
2.even? # => true
2.next # => 3
2.succ # => 3
2.pred # => 1
{% endhighlight %}

0除算を行うと例外ZeroDivisionErrorが発生します
{% highlight ruby linenos %}
1 / 0 # => ZeroDivisionError: divided by 0
{% endhighlight %}

Integer#to_sで文字列に変換でき、基数を指定することもできます。

{% highlight ruby linenos %}
30.to_s # => "30"
30.to_s(2) # => "11110"
30.to_s(8) # => "36"
30.to_s(16) # => "1e"
{% endhighlight %}

Integer#chrを用いると、数値に対応する文字を得ることができます。

{% highlight ruby linenos %}
(65..70).map {|n| n.chr} # => => ["A", "B", "C", "D", "E", "F"]
12354.chr("UTF-8") # => "あ"
{% endhighlight %}

また、数値と文字列の相互変換には[Array#pack](http://docs.ruby-lang.org/ja/2.3.0/method/Array/i/pack.html)や[String#unpack](http://docs.ruby-lang.org/ja/2.3.0/method/String/i/unpack.html)もあります。

{% highlight ruby linenos %}
"あいうえお".unpack("U*")
# => [12354, 12356, 12358, 12360, 12362]
[12354, 12356, 12358, 12360, 12362].pack("U*")
# => "あいうえお"
{% endhighlight %}

いくつかのクラスに定義されているto_iメソッドを用いれば整数として表現した結果を得られます。

{% highlight ruby linenos %}
'123'.to_i # => 123
Time.now.to_i # => 1456650331
{% endhighlight %}

また、Kernel.#Integerを用いることもできます。Kernel.#Integerは、to_iと違い例外を発生させます。

{% highlight ruby linenos %}
"a".to_i # => 0
Integer("a") # => ArgumentError: invalid value for Integer(): "a"
Integer(["a"]) # => TypeError: can't convert Array into Integer
{% endhighlight %}

余談として、Arrayを使って初期化すれば、Integer、Array、nilを判別せずにArrayを得られるというテクニックが紹介されました。

{% highlight ruby linenos %}
Array(1) # => [1]
Array([1,2,3]) # => [1, 2, 3]
Array(nil) # => []
{% endhighlight %}

# 5-1-6 Float

Rubyでは浮動小数点をFloat型で表現します。
Rubyでも、Floatを繰り返し加算していくと誤差が生じます。

{% highlight ruby linenos %}
sum = 0.0; 10.times{|i| sum += 0.1 }; p sum # => 0.9999999999999999
{% endhighlight %}

Integerでは0除算を行うと例外ZeroDivisionErrorが発生しましたが、浮動小数点の場合はNaNもしくはInfinityが返ります。

{% highlight ruby linenos %}
1.0 / 0 # => Infinity
-1.0 / 0 # => -Infinity
0.0 / 0 # => NaN
{% endhighlight %}

# 5-1-7 Rational

有理数はRationalで表します

{% highlight ruby linenos %}
r = Rational(1, 3) # => (1/3)
{% endhighlight %}

Ruby2.1.0以降はRational型のリテラルが用意されています。

{% highlight ruby linenos %}
1/3r # => (1/3)
{% endhighlight %}

# 5-1-8 Complex

複素数はComplexで表します

{% highlight ruby linenos %}
c = Complex(2, 3)
c.real # => 2
c.imaginary # => 3
{% endhighlight %}

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb033.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb033.ipynb)

## セッション

### 清貧Docker from [@harupong](https://twitter.com/harupong)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/2cn6QlMcZX8iHQ" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/harupong/docker-docker-58661634" title="清貧Docker ～個人がDockerを使う理由～" target="_blank">清貧Docker ～個人がDockerを使う理由～</a> </strong> from <strong><a target="_blank" href="//www.slideshare.net/harupong">harupong</a></strong> </div>

Dockerを個人でコストを抑えて運用する方法について発表されました。安価なVPS、計量なDockerイメージを作る方法など、とても参考になる情報が含まれています。

# 次回予告

次回は2016/3/30(水)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSアプリ開発を経て今はDDDとScalaの人。
映画オデッセイと火星の人は最高。
