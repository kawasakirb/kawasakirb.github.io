---
layout: post
title: "kawasaki.rb #025を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

6/24(水)にNTT-ATさんの会議室にて[kawasaki.rb #025](https://kawasakirb.doorkeeper.jp/events/26876)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/839018)

## パーフェクトRuby読書会

「4-1-2 インスタンスメソッド」まで終えました。

### 4-1 クラス

### 4-1-1 インスタンスの生成/初期化

Rubyではクラスの定義は以下のように行います

{% highlight ruby linenos %}
class クラス名
end
{% endhighlight %}

クラス名は大文字のアルファベットで始める必要があります。また、ClassNameのようなキャメルケースで命名するのが慣習です。
クラス定義の中には自由に式を記述することができ、たとえば定数を定義するときは

{% highlight ruby linenos %}
class MyClass
  DEFAULT_VALUE = 4423
end

MyClass::DEFAULT_VALUE # => 4423
{% endhighlight %}

とし、定義した定数は::で参照できます。

ここで、会場ではClass#nameで取得できる値は、定数にClassのインスタンスを代入したタイミングで生成されるという話になりました。

{% highlight ruby linenos %}
Class.name # => "Class"
Class.new.name # => nil
hoge = Class.new
hoge.name # => nil
Hoge = Class.new
Hoge.name # => "Hoge"
HOGE = Class.new
HOGE.name # => "HOGE"
{% endhighlight %}

と、Class.newを変数に代入した場合、Class#nameはnilを返し、定数に代入した場合はその定数名が返るようになります。

### 4-1-2 インスタンスメソッド

クラス内でメソッドを定義するとインスタンスメソッドとなります

{% highlight ruby linenos %}
class MyClass
  def method_a
    puts 'method_a calld'
  end

  def method_b
    method_a
  end
end

my_object = MyClass.new
my_object.method_b # => 'method_a calld'
{% endhighlight %}

メソッド名の末尾には疑問符や感嘆符を使うことができます。

{% highlight ruby linenos %}
class Brownie
  def initialize
    @baked = false
  end

  def bake!
    @baked = true
    self
  end

  def baked?
    @baked
  end
end

b = Brownie.new
b.baked? # => false
b.bake!
b.baked? # => true
{% endhighlight %}

Rubyでは慣習として、真偽値を返すメソッドには疑問符を用いて「baked?」という名前で定義します。
感嘆符を用いる場合は、プログラマに対して注意を促したいときや、破壊的なメソッド(自身を更新するメソッド)に使われます。

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb025.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb025.ipynb)

## セッション

### Ruby でシェルがやってるようなコマンドのパイプライン処理を行ってそれぞれの exitstatus を取得する話 from [@kechako](https://twitter.com/kechako)さん

シェルでコマンドをパイプでつなぎ、各コマンドの終了コードを得たい場合、bashでは`$PIPESTATUS`(zshでは`$pipestatus`)で取得することができます。

{% highlight bash %}
$ true | false | (exit 1) | (exit 8)
$ echo ${PIPESTATUS[@]}
0 1 1 8
{% endhighlight %}

これをRubyで再現させた試みについて発表されました。
発表に使われたgistsは[こちら](https://gist.github.com/kechako/170b2b154e88708505cc)です。

gistsのcmd_pipeメソッドを以下のように呼んであげると、

{% highlight ruby linenos %}
 p cmd_pipe('true', 'false', '(exit 1)', '(exit 8)')
 # => [#<Process::Status: pid 4588 exit 0>, #<Process::Status: pid 4589 exit 1>, #<Process::Status: pid 4590 exit 1>, #<Process::Status: pid 4591 exit 8>]
{% endhighlight %}

のように出力することができます。

### Enjoy the Ansible from [@Y_Fujikawa](https://twitter.com/Y_Fujikawa)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/4VUwdAGvC73nQG" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/yasuyukifujikawa5/enjoy-the-ansible" title="Enjoy the Ansible" target="_blank">Enjoy the Ansible</a> </strong> from <strong><a href="//www.slideshare.net/yasuyukifujikawa5" target="_blank">Yasuyuki Fujikawa</a></strong> </div>

Ansibleの紹介から、勉強会を開くための準備、マインドマップを使用した思考整理術などについて発表されていました。

発表のベースとなったブログは[こちら](http://fujiyasu.hatenablog.com/entry/2015/06/20/125509)です。

# 次回予告

次回は7/22(水)開催で、LT大会を行う予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人。お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
