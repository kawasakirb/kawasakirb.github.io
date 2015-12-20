---
layout: post
title: "kawasaki.rb #031を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

12/16(水)にNTT-ATさんの会議室にて[kawasaki.rb #031](https://kawasakirb.doorkeeper.jp/events/35645)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/914894)

## パーフェクトRuby読書会

「4-3-1 オブジェクトの基本的な振る舞い」まで終えました。

# 4-3 オブジェクト

ほとんどのクラスはObjectから派生したサブクラスです。スーパークラスを指定しなかった場合、自動的にObjectクラスを継承します。

{% highlight ruby linenos %}
class MyClass
end

MyClass.superclass #=> Object
{% endhighlight %}

また、すべてのクラスは[BasicObject](http://docs.ruby-lang.org/ja/2.2.0/class/BasicObject.html)を継承しており、BasicObjectにはメソッドがほとんど定義されておらず、委譲やプロキシの実装などの特定の用途に使用されるとのことです。

BasicObjectを継承しているクラスの1つに、[Delegatorクラス](http://docs.ruby-lang.org/ja/2.2.0/class/Delegator.html)が紹介されました。

{% highlight ruby linenos %}
require 'delegate'
puts Delegator.superclass # => BasicObject
{% endhighlight %}

# 4-3-1 オブジェクトの基本的な振る舞い

Objectクラスには、そのオブジェクトの情報を返すメソッドや比較演算子など、オブジェクトとしての基本的な機能が実装されています。

{% highlight ruby linenos %}
o = Object.new

# 自身についての情報を返す
o.class # => Object(どのクラスのオブジェクトか)
o.is_a?(Object) # => true(Objectのインスタンスか)
o.object_id # => 70235618382160 (オブジェクト固有のID)
o.nil? # => false (nilか)
o.frozen? # => false (freezeされているか)

# 自身をブロック引数にしてブロックを実行し、自身を返す
o.tap { |v| puts v } # => #<Object:0x007fc2022a13b0>
{% endhighlight %}

ここで少し `freeze` の挙動について触れました。
freezeはオブジェクトの内容の変更を禁止するメソッドです。

{% highlight ruby linenos %}
s = "hoge".freeze
s.frozen? # => true
s.upcase! # => can't modify frozen String (RuntimeError)
{% endhighlight %}

文中のtapの使い方についても触れました。
tapは、例えば次のように処理のコンテキストを表したい時に使ったり、

{% highlight ruby linenos %}
Recipe.make.tap do |r|
  Author.make(recipd_id: r.id)
end
{% endhighlight %}

もしくはメソッドチェーンの途中でデバッグしたい時に使用することが多い、という話をしました。

{% highlight ruby linenos %}
"kawasaki.rb".upcase.
  tap { |s| puts s }. # => メソッドチェーン中の処理が表示される
  reverse
{% endhighlight %}

なお、この書き方を省略するために[tapp](https://github.com/esminc/tapp)というgemが存在します。

Object#==は同一性を返す演算子メソッドですが、ほとんどのクラスでは同値性を返すようオーバーライドしています。

{% highlight ruby linenos %}
p Object.new == Object.new # => false
p [1,2,3] == [1,2,3] # => true
p /pattern/ == /pattern/ # => true
p 'Alice' == 'Alice' # => true
{% endhighlight %}

同値性を返すようにオーバーライドするには、例えば以下のようにします。

{% highlight ruby linenos %}
class Ruler
  attr_accessor :length

  def initialize(length)
    self.length = length
  end

  def ==(other)
    length == other.length
  end
end

r1 = Ruler.new(10)
r2 = Ruler.new(10)
p r1 == r2 # => true
{% endhighlight %}

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb031.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb031.ipynb)

## セッション

本日のKawasaki.rbのセッションではPythonの発表が2つありました。

### SympyとJupyter notebookで数式のメモを取ろう from [@chezou](https://twitter.com/chezou)さん

SympyとJupyter notebookを使って、数式をレンダリングしたり、方程式の展開、微分・積分ができる！という発表をされました。

発表元の記事は[こちら](http://chezou.hatenablog.com/entry/2015/11/23/210207)

### RubyエンジニアがPythonをdisるためにPythonを勉強してみた from [@kon_yu](https://twitter.com/kon_yu)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/7t1imwAFXdlUB8" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/kon_yu/rubypythondispython" title="RubyエンジニアがPythonをdisるためにPythonを勉強してみた" target="_blank">RubyエンジニアがPythonをdisるためにPythonを勉強してみた</a> </strong> from <strong><a href="//www.slideshare.net/kon_yu" target="_blank">Yusuke Kon</a></strong> </div>

@kon_yuさんがPyladies Tokyoで発表されたLTの再演をしていただきました。会場ではKawasaki.rb主催者との掛け合いが白熱しました。

# 次回予告

次回は2016/1/27(水)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人だったが、今はDDDとScalaの人。
お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
