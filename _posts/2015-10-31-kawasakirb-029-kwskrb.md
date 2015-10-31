---
layout: post
title: "kawasaki.rb #029を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

10/28(水)にNTT-ATさんの会議室にて[kawasaki.rb #029](https://kawasakirb.doorkeeper.jp/events/33525)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/892863)

## パーフェクトRuby読書会

「4-2-2 メソッドをクラスのインスタンスメソッドとして取り込む」まで終えました。

### 4-1-9 クラス変数とそのスコープ

Rubyでは、クラス変数を `@@` で表現します。

{% highlight ruby linenos %}
class Parent
  @@val = 'foo'

  def self.say
    puts @@val
  end
end

class Child
  def say2
    puts @@val
  end
end

Parent.say # => "foo"
Child.say # => "foo"
Child.new.say2 # => "foo"
{% endhighlight %}

また、トップレベルで定義したクラス変数はどこからでもアクセスできます。
(ただし警告がでます)

{% highlight ruby linenos %}
@@bar = "kawasaki"

class Parent
  def self.say
    puts @@bar
  end
end

Parent.say
 # => -:3: warning: class variable access from toplevel
 # => "kawasaki"
{% endhighlight %}

### 4-1-10 クラス定義のネスト

クラス定義の中に、さらに他のクラスを定義することができます。
また、以下のように同名のクラスが定義された場合、ネストされたクラスが優先されます。

{% highlight ruby linenos %}
class FooClass
  def self.say
    puts "is FooClass"
  end
end

class BooClass
  class FooClass # こっちが参照される
    def self.say
      puts "is nest FooClass"
    end
  end
end

BooClass::FooClass.say # => "is nest FooClass"
{% endhighlight %}

### 4-1-11 ネストした定数の参照

定数をネストした場合でも、そのクラス・モジュール内に定数が定義されていればそちらが参照され、なければネストが低い位置の定数が評価されます。

{% highlight ruby linenos %}
VALUE = 'toplevel'

class Foo
  VALUE = 'in Foo class'

  def self.value
    VALUE
  end
end

class Foo::Baz
  def self.value
    VALUE
  end
end

Foo.value # => in Foo class
Foo::Baz.value # => toplevel
{% endhighlight %}

### 4-2 モジュール

### 4-2-1 モジュールの特徴

Rubyでは `module` キーワードを使用してモジュールを定義できます。
また、特異メソッドを定義することもできます。

{% highlight ruby linenos %}
module Language
  def self.lot
    %w(ruby python C# VB Perl).sample
  end
end

p Language.lot # => "VB" (ランダムで変わる)
p Language.lot # => "ruby" (ランダムで変わる)
{% endhighlight %}

### 4-2-2 モジュールの特徴

モジュールに定義されたメソッドは、 `include` を使用してClassにMix-inすることができます。

{% highlight ruby linenos %}
module Greetable
  def greet_to(name)
    puts "Hello, #{name}. My name is #{self.class}."
  end
end

class Alice
  include Greetable
end

alice = Alice.new
alice.greet_to 'Bob' # => "Hello, Bob. My name is Alice."
{% endhighlight %}

Mix-inの代表的なものとして、ArrayやHashにincludeされているEnumerableモジュールがあります。
Enumerableモジュールをeachメソッドが定義されているクラスにincludeすると、mapやfindなどのメソッドが使えるようになります。

{% highlight ruby linenos %}
class FriendList
  include Enumerable

  def initialize(*friends)
    @friends = friends
  end

  def each
    for v in @friends
      yield v
    end
  end
end

friend_list = FriendList.new('A', 'B', 'C')
p friend_list.count
friend_list.map {|v| v.downcase}
{% endhighlight %}

会場では `include` の他に `prepend` もあるのでは?という話になりましたが、 [prepend](http://docs.ruby-lang.org/ja/2.0.0/method/Module/i/prepend.html) はメタプログラミングの章で扱うので今回は割愛...

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb029.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb029.ipynb)

## セッション

### TinySegmenterをJulia移植したらMITの先生に指導してもらえた話 from [@chezou](https://twitter.com/chezou)さん

JavaScript向けに作った日本語のコンパクトな分かち書きツール、TinySegmenterをJuliaに移植したTinySegmenter.jlを作ったとchezouさんが、
MITの@stevengj先生からパッケージの命名規則について指摘を受けたことをきっかけに、時差をフル活用したIssue指導と、日本語が読めないにも
かかわらずオリジナル実装のバグを報告されたという話をされました。

発表元となる記事は[こちら](http://chezou.hatenablog.com/entry/2015/10/21/234317)

# 次回予告

次回は11/25(毎月第4水曜日)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人だったが、今はDDDとScalaの人。
お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
