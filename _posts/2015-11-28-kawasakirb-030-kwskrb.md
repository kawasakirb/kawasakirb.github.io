---
layout: post
title: "kawasaki.rb #030を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

11/25(水)にNTT-ATさんの会議室にて[kawasaki.rb #030](https://kawasakirb.doorkeeper.jp/events/34922)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/904951)

## パーフェクトRuby読書会

「4-2-5 クラスやモジュールを自動的にロードする」まで終えました。

# 4-2-3 メソッドをオブジェクトに取り込む

モジュールに定義されたメソッドは、`extend`を使用してオブジェクトに取り込むことができます。

{% highlight ruby linenos %}
module Greetable
  def greet_to(name)
    puts "Hello, #{name}. I'm a #{self.class}"
  end
end

o = Object.new
o.extend Greetable

o.greet_to 'World'
{% endhighlight %}

クラスもまたオブジェクトの1つなので、同じく`extend`することができます。


{% highlight ruby linenos %}
module Greetable
  def greet_to(name)
    puts "Hello, #{name}. I'm a #{self.class}"
  end
end

class Alice
  extend Greetable
end

Alice.greet_to 'World' # "Hello, World."
{% endhighlight %}


Moduleに対しても同様です。

{% highlight ruby linenos %}
#!usr/bin/env ruby

module Greetable
  def greet_to(name)
    puts "Hello, #{name}. I'm a #{self.class}"
  end
end

module Alice
  extend Greetable # Moduleに対してextend
end

Alice.greet_to 'World' # "Hello, World."
{% endhighlight %}

# 4-2-4 モジュール関数

サブルーチンとして利用されることを目的としたメソッドはモジュール関数として定義されることがあります。

{% highlight ruby linenos %}
Math.sqrt(4) # => 2.0

include Math
sqrt(4) # => 2.0
{% endhighlight %}

複数のモジュール関数を定義する場合は、`module_function`を使用します。

{% highlight ruby linenos %}
module MyFunctions
  module_function

  def my_first_function
    puts 'first'
  end

  def my_second_function
    puts 'second'
  end
end
{% endhighlight %}

また、モジュール関数は「privateなインスタンスメソッドであると同時に、モジュールの特異メソッドでもある」とのことから、privateであることを確かめるため、
以下のコードを検証しました。

{% highlight ruby linenos %}
module MyFunction
  def outer_function
    first_function
    second_function
  end

  module_function

  def first_function
    puts 'first'
  end

  def second_function
    puts 'second'
  end
end

o2 = Object.new
o2.extend MyFunction
o2.outer_function
# => first
# second

o2.first_function #  モジュール関数とはprivateなインスタンスメソッドのためエラー
{% endhighlight %}

# 4-2-5 クラスやモジュールを自動的にロードする

毎回必ずロードする必要がないクラスやモジュールは、autoloadを使用して、必要になったタイミングでrequireすることができます。

{% highlight ruby linenos %}
autoload :MySweets, 'my_library/my_sweeets'

MySweets # ここでrequireされる。
{% endhighlight %}

ネストしたクラス・モジュールのautoloadは以下のように記述します。

{% highlight ruby linenos %}
module MySweets
  autoload :Cake, 'my_library/my_sweeets/cake'
end

MySweets::Cake # ここでrequireされる。
{% endhighlight %}



今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb030.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb030.ipynb)

## セッション

今回はなんと発表者が4人(!)もおり会場が大変盛り上がりました。

### 先週末、3連休でRailsの乗り方を身につけた from [@rojiuratech](https://twitter.com/rojiuratech)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/wnLGLiP9Wy5gZd" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/rojiuratech/camp-report-forkwskrb-55531773" title="Camp report for_kwskrb" target="_blank">Camp report for_kwskrb</a> </strong> from <strong><a href="//www.slideshare.net/rojiuratech" target="_blank">rojiuratech</a></strong> </div>

朝から夜までRailsをみっちり教えてくれるという[ELITES CAMP](http://lp.spartacamp.jp/201511_ruby/)に3連休を使って参加された経験を発表されました。
TAが付いて丁寧に教えてくれるらしいのですが、これが35,000円で参加できるということに会場が驚きに包まれていました。

### Rubyistを誘うScalaの世界 from [@Peranikov](https://twitter.com/Peranikov)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/Kb77fszNVfOW5t" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/yutomatsukubo/rubyistscala" title="Rubyistを誘うScalaの世界" target="_blank">Rubyistを誘うScalaの世界</a> </strong> from <strong><a href="//www.slideshare.net/yutomatsukubo" target="_blank">Yuto Matsukubo</a></strong> </div>

RubyistをScalaの世界に誘うべく、Rubyの魅力をScalaを使って再現しました。
静的型付け言語ということもありRubyほど簡単に書くことはできませんが、それでもここまで実現できるのはScalaの素晴らしいところだと思っています。

### Ruby 2.3.0-preview1 がリリースされたので新機能を試してみた from [@kechako](https://twitter.com/kechako)さん

発表元となる記事は[こちら](http://blog.kechako.com/entry/2015/11/25/145428)

Ruby 2.3.0のプレビュー版が公開されたのをきっかけに、新機能を実際に試してみた結果を発表されました。
最近話題の、文字列リテラルがimmutableになるという機能の他、一通りの新機能がまとめられていました。
Hashの比較演算子なんて何に使うんだろう...

### Railsを使って1週間でサイト構築した from [@pachirel](https://twitter.com/pachirel)さん

Rails、Docker、Elastick Beanstalkなどを組み合わせ、1週間ほどでサイトを構築した話をされました。
即興のためスライドは未公開ですが、詳細な技術については後日Qiitaに投稿されるとのことです。

# 次回予告

次回の予定はまだ未定です。DoorKeeperやFaceBookチャンネルなどでお知らせします。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人だったが、今はDDDとScalaの人。
お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
