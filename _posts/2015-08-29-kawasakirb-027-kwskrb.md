---
layout: post
title: "kawasaki.rb #027を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

8/26(水)にNTT-ATさんの会議室にて[kawasaki.rb #027](https://kawasakirb.doorkeeper.jp/events/30006)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/866173)

## パーフェクトRuby読書会

「4-1-5 メソッドの呼び出し制限」まで終えました。

### 4-1-3 インスタンス変数へのアクセス

Rubyではattr_accessorを使用することで、インスタンス変数のアクセサを生成することができます。

{% highlight ruby linenos %}
class Ruler
  attr_accessor :length
end

ruler = Ruler.new
ruler.length = 30
ruler.length # => 30
{% endhighlight %}

上のコードは、次のコードと同義になります。

{% highlight ruby linenos %}
class Ruler
  def length=(len)
    @length = len
  end

  def length
    @length
  end
end

ruler = Ruler.new
ruler.length = 30
ruler.length # => 30
{% endhighlight %}

### 4-1-4 クラスメソッド

Rubyでは、メソッド名の直前に「self.」を付けることでクラスメソッドになります。

{% highlight ruby linenos %}
class Ruler
  def self.pair
    [new, new]
  end
end

Ruler.pair # => [#<Ruler:0x007f8da20c2880>, #<Ruler:0x007f8da20c2858>]
{% endhighlight %}

クラスメソッドの中ではクラスがselfとなるので、Ruler.newの呼び出しはレシーバを省略してnewと記述できます。
クラスメソッドの記述は、以下のようにも書けます。

{% highlight ruby linenos %}
class Ruler
  class << self
    def pair
      [new, new]
    end

    def trio
      [new, new, new]
    end
  end
end
{% endhighlight %}

「class << self ... end」は特異クラスと呼ばれるクラス定義で、この特異クラス定義に記述したメソッドはRulerクラスのクラスメソッドになります。

### 4-1-5 メソッド呼び出しの制限

Rubyの呼び出し制限には、public、priate、protectedがあり、以下のように定義できます。

{% highlight ruby linenos %}
class Processor
  def process
    protected_process
  end

  protected

  def protected_process
    private_process
  end

  private

  def private_process
    puts "Done!"
  end
end
{% endhighlight %}

protectedはJavaやC++と意味が異なり、同じクラスに属しているインスタンスのメソッドの中であれば、異なるインスタンスのprotectedなメソッドを呼び出せます。

{% highlight ruby linenos %}
class Processor
  def process(other)
    other.protected_process
  end

  protected

  def protected_process
    puts "Called"
  end
end

processor = Processor.new
processor.process(Processor.new) # => Called
processor.protected_process # => NoMethodError
{% endhighlight %}

ここで、private以降にクラスメソッドを定義したらどんな挙動をするか?という話になりました。

{% highlight ruby linenos %}
class Ruler
  private

  class << self
    def pair
      [new, new]
    end
  end
end

Ruler.pair # => [#<Ruler:0x007fecfb822c20>, #<Ruler:0x007fecfb822bf8>]
{% endhighlight %}

と、private以降にクラスメソッドを定義してもクラスメソッドは呼び出せます。

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb027.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb027.ipynb)

## セッション

### 東京五輪エンブレム for Ruby from [@Peranikov](https://twitter.com/Peranikov)

Rubyの画像描画ライブラリであるcairoを使って東京五輪エンブレムを描画したという話をしました。

発表元のQiitaの記事は[こちら](http://qiita.com/Peranikov/items/5997cd4437e7aaa8ddab)です。

### イカのギアで持ってないのを調べるやつを作った話 from [@ryonext](https://twitter.com/ryonext)

スプラトゥーンで自分が持っていないギアを管理したい、というニーズからRailsでツールを作ったという話をされました。

イカのギアで持ってないのを調べるやつは[こちら](http://ika-gear.herokuapp.com/)

持っていないギアにチェックをつけて、下部のCSV出力から、持っていないギアのリストを出力できます。


### RubyのC拡張部分をGoにした話 from [@kechako](https://twitter.com/kechako)さん

Goの1.5から、Cのshared libraryを生成できるようになったということで、RubyのC拡張をGoで実装し、Rubyから呼び出すというデモをされました。
現在はGoからRubyのコードを呼び出し、Gemの生成時にGoのコードをコンパイルするということを試しているそうです。

### ActiveDecorator from [@kon_yu](https://twitter.com/kon_yu)さん

RailsでViewに分岐やロジックがあり複雑化していたものを、ActiveDecoratorを導入して改善したという話をされました。
これにより、デザイナーが作成したHTMLモックをRailsに組み込む作業が楽になったということです。

ActiveDecoratorのリポジトリは[こちら](https://github.com/amatsuda/active_decorator)

# 次回予告

次回は9/30(水)開催です(いつもの第4水曜日ではありません!)。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人。お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
