---
layout: post
title: "kawasaki.rb #028を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

9/30(水)にNTT-ATさんの会議室にて[kawasaki.rb #028](https://kawasakirb.doorkeeper.jp/events/31488)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/880984)

## パーフェクトRuby読書会

「4-1-8 特異メソッド」まで終えました。

### 4-1-6 クラスの継承

Rubyは単一継承をサポートしており、クラスを定義するときに1つだけスーパークラスを継承できます。

{% highlight ruby linenos %}
class Parent
  def greet
    puts 'Hi'
  end
end

class Chile
end

Child.superclass # => Parent
child = Child.new
child.greet # => "Hi" と表示
{% endhighlight %}

サブクラスはスーパークラスのインスタンスメソッド、クラスメソッドを継承します。しかし、サブクラスはインスタンス変数についての情報は継承しません。

{% highlight ruby linenos %}
class Parent
  def initialize
    @var = 'content'
  end
end

class Chlid < Parent
  def initialize
  end
end

p Parent.new # => #<Parent:0x007f80940a04f8 @var="content">
p Child.new # => #<Child:0x007f80940987f8 @var="content">
{% endhighlight %}

また、定数も引き継ぎます。

{% highlight ruby linenos %}
class Parent
  PARENT = 'parent\'s constant'
end

class Child < Parent
end

p Child.constants # => [:PARENT]
Child::PARENT # => "parent's constant"
{% endhighlight %}

余談で、Rubyでは定数の再定義はエラーとならず警告が出るだけという話をしました。

{% highlight ruby linenos %}
FOO = "foo"
FOO = "bar"

# (pry):81: warning: already initialized constant FOO
# (pry):80: warning: previous definition of FOO was here
{% endhighlight %}


### 4-1-7 メソッドのオーバーライド

Rubyはメソッドのオーバーライドをサポートしています。

{% highlight ruby linenos %}
class Parent
  def greet
    puts 'Hi'
  end
end

class Child < Parent
  def greet(name)
    puts "Hi #{name}"
  end
end

parent = Parent.new
p parent.greet # => "Hi"
child = Child.new
p child.greet('ruby') # => "Hi ruby"
p child.greet # => ArgumentError: wrong number of arguments (0 for 1)
{% endhighlight %}

スーパークラスのメソッドを呼び出すにはsuperを使います。スーパークラスのメソッドにはサブクラスで受け取った引数が自動的に渡されます

{% highlight ruby linenos %}
class GrandChild < Child
  def greet(name)
    super

    puts "Nice to meet you!"
  end
end

grandchild = GrandChild.new
grandchild.greet 'ruby' # => Hi ruby
# => Nice to meet you!

{% endhighlight %}

### 4-1-8 特異メソッド

オブジェクトは、クラスに定義されたメソッドの他に、そのオブジェクト固有のメソッドを持つことができます。これを特異メソッドと呼びます。

{% highlight ruby linenos %}
class Foo
end

foo = Foo.new
bar = Foo.new

def bar.singleton_method
  puts 'Called!'
end

bar.singleton_method # => Called!
foo.singleton_method # => undefined method `singleton_method'
{% endhighlight %}

なお、特異メソッドという名称については[こちら](http://togetter.com/li/881987)にまとめてあります。

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb028.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb028.ipynb)

## セッション

### 野球Hack!~Pythonを用いたデータ分析と可視化 from [@shinyorke](https://twitter.com/shinyorke)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/4Ho0Yg5hBBUaw3" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/shinyorke/hackpython-kwskrb-28-2015930" title="野球Hack!~Pythonを用いたデータ分析と可視化 #kwskrb #28 2015/9/30" target="_blank">野球Hack!~Pythonを用いたデータ分析と可視化 #kwskrb #28 2015/9/30</a> </strong> from <strong><a href="//www.slideshare.net/shinyorke" target="_blank">伸一 中川</a></strong> </div>

PyCon JPで発表する練習として、Pythonを用いて野球のデータ分析(発表者は「野球Hack」と命名)について発表されました。
Pythonの魅力と好きな言語でHackすること、データから見えてくる言葉の楽しさを伝えていただきました。

### 今回俺がいかにして転職したか晒す from [@Peranikov](https://twitter.com/Peranikov)さん

今月は特に技術的なエントリーを何も書いていなかったので、今回転職した時のノウハウについて発表しました。
おそらくKawasaki.rbで転職について発表したのはこれが初めてでしょう。

発表元の記事は[こちら](http://norizabuton.hateblo.jp/entry/2015/09/09/101231)

# 今回のブログを書いてくださった方々

[野球Hack!~Pythonを用いたデータ分析と可視化（素振り) - #kwskrb #28 に参加しました](http://shinyorke.hatenablog.com/entry/2015/10/03/162328)

# 次回予告

次回は10/25(毎月第4水曜日)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人だったが、今はDDDとScalaの人。
お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
