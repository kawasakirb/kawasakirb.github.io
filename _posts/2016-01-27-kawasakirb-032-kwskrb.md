---
layout: post
title: "kawasaki.rb #032を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

1/27(水)にNTT-ATさんの会議室にて[kawasaki.rb #032](https://kawasakirb.doorkeeper.jp/events/37742)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/931082)

## パーフェクトRuby読書会

「5-1-4 繰り返し処理」まで終えました。

# 4-3-2 オブジェクトの変更を禁止する

Object#freezeを呼び出すと、レシーバへの破壊的な操作を禁止することができます。

{% highlight ruby linenos %}
s = "hoge"
s.freeze # 変更を禁止する
s.frozen? # => true
s << "2" # can't modify frozen String (RuntimeError)
{% endhighlight %}

以下のように、Hashの変更も禁止されます。

{% highlight ruby linenos %}
DEFAULT_CONST = {foo: 123}.freeze
DEFAULT_CONST[:foo] = 456
{% endhighlight %}

ただし、以下のような再代入は禁止されません。

{% highlight ruby linenos %}
i = 1
i.freeze # 変更を禁止する
i += 2 # 再代入なので例外は発生しない
{% endhighlight %}

# 4-3-3 オブジェクトをコピーする

オブジェクトをコピーするにはObject#dupやObject#cloneを用います。どちらのメソッドも汚染状態を含めてコピーされます。

{% highlight ruby linenos %}
original = Object.new
p original.object_id # => 70295490884320
original.freeze

dup = original.dup
p dup.object_id # => 70295490884200
p dup.frozen? # => false

clone = original.clone
p clone.object_id # => 70138977021500
p clone.frozen? # => true # cloneではfreezeの情報もコピーされる
{% endhighlight %}

Arrayでの挙動も調べてみました

{% highlight ruby linenos %}
value = 'foo'
array = [value]
array_dup   = array.dup
array_clone = array.clone

p value.object_id # => 70265087245460
p array_dup[0].object_id # => 70265087245460
p array_clone[0].object_id # => 70265087245460
{% endhighlight %}

dupした配列に破壊的な変更を加えてみます。

{% highlight ruby linenos %}
array_dup[0] << "2"
p array_dup[0] # => "foo2"
p array[0] # => "foo2"
{% endhighlight %}

このように、オリジナルのarrayにも破壊的な変更が加えられます。
これを避けるには、 `Marshal.load/dump` を使用してコピーすればよいのではないか?という話題になりました。

{% highlight ruby linenos %}
array_dump = Marshal.load(Marshal.dump(array))
p array_dump[0].object_id # => 70265086490020
array_dump[0] << "0"
p array_dump[0] # => "foo20"
p array[0] # => "foo2"
{% endhighlight %}

この場合、コピー先の破壊的変更はオリジナルに影響を与えません。(ただしパフォーマンスは度外視)

# 4-3-4 汚染されたオブジェクト

Rubyには、セーフレベルという危険な操作を防ぐ機能があります。

※セーフレベル2以降は2.3.0より廃止されました。くわしくは[こちら](http://docs.ruby-lang.org/ja/2.3.0/doc/spec=2fsafelevel.html)をご確認ください。

Rubyでは、外部から入力されたものは汚染されたオブジェクトとして扱われます。オブジェクトが汚染されているかどうかはObject#tainted?で確認できます。

{% highlight ruby linenos %}
p $SAFE # => 0
p ENV['HOME'].tainted? # => true

o = Object.new
p o.tainted? # => false
o.taint # オブジェクトを汚染させる
p o.tainted? # => true
{% endhighlight %}


一度上げたセーフレベルを下げることはできません。

{% highlight ruby linenos %}
$SAFE = 1
$SAFE = 0 # => SecurityError: tried to downgrade safe level from 1 to 0

rcfile = ENV["HOME"] + '/test_file'
{% endhighlight %}

セーフレベル1では、汚染されたオブジェクトを使ってファイルを削除することを禁止できます。
※なおpryで試した場合、pryの履歴を残す挙動によりファイル操作以外でも例外が発生することが確認されました。

{% highlight ruby linenos %}
$SAFE = 1

rcfile = ENV["HOME"] + '/test_file'
File.unlink rcfile # unlink: Insecure operation - unlink (SecurityError)
{% endhighlight %}

# 5章

# 5-1 Numeric

全ての数値クラスはNumericクラスから派生します。

{% highlight ruby linenos %}
p Integer.ancestors # => [Integer, Numeric, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
p Float.ancestors # => [Float, Numeric, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
p Rational.ancestors # => [Rational, Numeric, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
p Complex.ancestors # => [Complex, Numeric, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
p Fixnum.ancestors # => [Fixnum, Integer, Numeric, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
p Bignum.ancestors # => [Bignum, Integer, Numeric, Comparable, Object, PP::ObjectMixin, Kernel, BasicObject]
{% endhighlight %}

数値クラスには、いくつかの述語メソッドが定義されています。
その中の `zero?` や `nonzero?` はいつ使えば良いのか?という話になり、以下のように使うことでスマートに記述することができる、という話になりました。

{% highlight ruby linenos %}
ary = [1, 0, 3]
p ary.select(&:zero?) # => [0]
p ary.reject(&:zero?) # => [1, 3]
p ary.select(&:nonzero?) # => [1, 3]
{% endhighlight %}

# 5-1-1 算術演算

除算はInt同士だと結果もIntになる、という話をしました。

{% highlight ruby linenos %}
p 10 / 3 # => 3
p 10.0 /3 # => 3.3333333333333335

num = 10
p num / 3 # => 3
p num.to_f / 3 # => 3.3333333333333335
{% endhighlight %}

# 5-1-2 比較演算

同値であればIntとFloatを比較してもtrueとなる、という話をしました。

{% highlight ruby linenos %}
123 == 123.0 # => true
{% endhighlight %}

# 5-1-3 丸め操作

`round`, `ceil`, `floor`, `truncate` についての挙動は以下のようになります。

{% highlight ruby linenos %}
p 1.4.round # => 1
p 1.5.round # => 2
p -1.5.round # => -2
p 1.4.ceil # => 2
p 1.5.ceil # => 2
p -1.5.ceil # => -1
p -1.4.ceil # => -1
p 1.5.floor # => 1
p 1.4.floor # => 1
p -1.4.floor # => -2
p 1.5.truncate # => 1
p -1.5.truncate # => -1
p 1.6.truncate # => 1
p 1.7.truncate # => 1
p 1.9.truncate # => 1
p -0.9.truncate # => 0
p -1.9.truncate # => -1
{% endhighlight %}

# 5-1-4 繰り返し処理

繰り返しのためのメソッドとして`Numeric#step`があります。

{% highlight ruby linenos %}
3.step 5 do |num|
  puts num
end
# 3
# 4
# 5
{% endhighlight %}

第二引数に増加していく数値を指定できます。

{% highlight ruby linenos %}
1.2.step 2.0, 0.2 do |num|
  puts num
end
{% endhighlight %}

他にもよく使うメソッドとして `upto` があります。

{% highlight ruby linenos %}
3.upto(5) do |num|
  puts num
end
{% endhighlight %}

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb032.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb032.ipynb)

## セッション

今日はLTの発表はなく、RubyおよびRailsについてのトークをしました。

# RailsのEnum使ってる?

Rails4で追加された[Enum](http://api.rubyonrails.org/v4.1/classes/ActiveRecord/Enum.html)ですが、プロダクションでどれだけ使っているか?という質問がありました。

会場ではあまり意識的に使っているようではありませんでしたが、同一クラス内で重複するキーが使えないなど、ハマりどころはありそうです。

参考: [ActiveRecord::Enum の注意点](http://qiita.com/kakipo/items/092cc523849ea324d268)

また、同じハマりどころとしてdefault_scopeがあげられました。

参考: [Railsのdefault_scopeは悪だ！(default_scope is evil) ということらしい](http://qiita.com/yusabana/items/f0b3a80111d6bd4ec8b0)

# 管理画面どうやって作ってる?

Railsでサービスを作る際、管理画面をどのように作っているかという質問がありました。

回答として[RailsAdmin](https://github.com/sferik/rails_admin)を使うか、Gemに依存したくなければScaffoldで作った方が良い、ということがあげられました。

また、Railsの[Mountable Engine](http://techlife.cookpad.com/entry/2015/04/06/155940)を使う方法もあげられました。

# 次回予告

次回は2016/2/24(水)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSアプリ開発を経て今はDDDとScalaの人。  
お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
