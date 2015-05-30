---
layout: post
title: "kawasaki.rb #024を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

5/27(水)にNTT-ATさんの会議室にて[kawasaki.rb #024](https://kawasakirb.doorkeeper.jp/events/25039)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/827464)

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">約2周年のkawasaki.rb、明日開催です！ご参加お待ちしております <a href="https://t.co/iJLoQMYuEs">https://t.co/iJLoQMYuEs</a> <a href="https://twitter.com/hashtag/kwskrb?src=hash">#kwskrb</a></p>&mdash; kawasakirb (@kawasakirb) <a href="https://twitter.com/kawasakirb/status/603056028440133632">2015, 5月 26</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

24回目ということで、なんとKawasaki.rbは今回で約2周年となりました。おめでとうございます!

## パーフェクトRuby読書会

「3-6-4 割り込みハンドラを定義する」まで終えました。

### 3-6-3 外部ファイルを読み込む

Karnel.#requireは、既存ライブラリや別ファイルに用意したプログラムを読み込む際に使います。

{% highlight ruby linenos %}
require 'erb'
# => true
{% endhighlight %}

requireに指定できるファイルはRubyスクリプトか拡張ライブラリ(.so,.dll,.bundle)です。拡張子は省略できます。
引数に相対パスが指定された場合、$LOAD_PATH($:)に含まれるディレクトリを順番に探し、最初に見つかったファイルをロードします。

{% highlight ruby linenos %}
$LOAD_PATH
# => ["/usr/local/opt/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/coderay-1.1.0/lib", "/usr/local/opt/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/slop-3.6.0/lib", "/usr/local/opt/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/method_source-0.8.2/lib", ...
{% endhighlight %}

requireされたファイルのパスは$LOADED_FEATURES($")に追加されます。
同じパスのファイルは一度しかロードされません。ただし、同じファイルをシンボリックリンク経由でrequireした場合、パスが違うため2回ロードされます。

{% highlight ruby linenos %}
$LOADED_FEATURES
# => ["enumerator.so", "rational.so", "complex.so", ...
{% endhighlight %}

Karnel.#require_relativeは、実行中のファイルからみた相対パスでrequireを行います。$LOAD_PATHは探索されません。

{% highlight ruby linenos %}
# 実行ファイルと同じディレクトリにmylib.rbが存在する場合
require_relative 'mylib'
# => true
{% endhighlight %}

Karnel.#loadはrequireと同じく外部ファイルを読み込みますが、拡張子の補完は行いません。また、requireと違い同じファイルパスを
何度でも読み込むことができるので、設定ファイルを読み込むことに多く用いられます。

{% highlight ruby linenos %}
require './mylib'
# => true
require './mylib'
# => false
load __dir__ + '/mylib.rb'
# => true
load __dir__ + '/mylib.rb'
# => true
{% endhighlight %}

$:や$LOAD_PATHには探索パスが配列で格納されており、パスを追加することで探索パスを追加することができます。

{% highlight ruby linenos %}
require 'mylib'
# => LoadError: cannot load such file -- mylib from /usr/local/opt/rbenv/versions/2.2.2/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
$LOAD_PATH << File.dirname(__FILE__)
# => ["/usr/local/opt/rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/coderay-1.1.0/lib", ... ,"."]
require 'mylib'
# => true
{% endhighlight %}

### 3-6-4 割り込みハンドラを定義する

Kernel.#trapを使用すると、割り込みのシグナルに対応するハンドラを登録することができます。
以下のプログラムを実行中に、SIGINTを送信するとメッセージを出力して終了します。

{% highlight ruby linenos %}
trap :INT do
  puts "\nInterrupted!"
  exit # exitを呼んでおかないとSIGINTで終了されなくなる
end

loop do
  sleep 1
end
{% endhighlight %}

また、trapは上書きすることができ、下記のプログラムの場合、SIGINT送信後に"Interrupted2"が表示されます。

{% highlight ruby linenos %}
trap :INT do
  puts "\nInterrupted1"
  exit
end

trap :INT do
  puts "\nInterrupted2"
  exit
end

loop do
  sleep 1
end
{% endhighlight %}

そして、trapの戻り値は上書きする前のシグナルハンドラとなっているので、再定義の際に前のシグナルハンドラを保存することができます。
下記の例では、"Interrupted2"が表示された後、old_handler.callによって"Interrupted1"が表示されます。

{% highlight ruby linenos %}
trap :INT do
  puts "\nInterrupted1"
  exit
end

old_handler = trap :INT do
  puts "\nInterrupted2"
  old_handler.call
  exit
end

loop do
  sleep 1
end
{% endhighlight %}

書籍「なるほどUnixプロセス - Rubyで学ぶUnixの基礎」では、これを利用した例としてgemのmemprofを紹介しています。 [リンク](https://github.com/ice799/memprof/blob/d4bc228aca323b58fea92dbde20c1f8ec36e5386/lib/memprof/signal.rb#L8-16)

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb024.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb024.ipynb)

Kawasaki.rbで2年に渡って進めてきたパーフェクトRuby読書会ですが、今回で無事3章が終了し、次回は4章「クラスとモジュール」になります。

## セッション

今回は発表者が多く、4名の方に発表していただきました。

### Docker 基本のおさらい from [@nk_ngzm](https://twitter.com/nk_ngzm)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/rklPcZcnlAICq7" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ngzm/docker-48648898" title="Docker 基本のおさらい" target="_blank">Docker 基本のおさらい</a> </strong> from <strong><a href="//www.slideshare.net/ngzm" target="_blank">Naoki Nagazumi</a></strong> </div>

社内講習会で発表したDocker初学者向けの資料を一部抜粋し発表していただきました。Dockerについて懇切丁寧に解説されていて、翌日の
はてブのテクノロジー欄でホットエントリー入りもされていました。拍手。

### Unix プロセスと Docker の罠 from [@kechako](https://twitter.com/kechako)さん

Dockerでゾンビプロセスが大量に発生したことを調査するため、「なるほどUnixプロセス」をもとにRubyのプロセスを調査し、さらにDocker上での
挙動をまとめた内容について発表されていました。

発表されたエントリーは[こちら](http://blog.kechako.com/entry/2015/05/27/210459)

### Rubyistがgemの前にPypiデビューするのは間違っているだろうか from [@chezou](https://twitter.com/chezou)さん

<iframe src="//www.slideshare.net/slideshow/embed_code/key/nzuS2SusU9LaBR" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/chezou/py-48654458" title="Rubyistがgemの前にPypiデビューするのは間違っているだろうか" target="_blank">Rubyistがgemの前にPypiデビューするのは間違っているだろうか</a> </strong> from <strong><a href="//www.slideshare.net/chezou" target="_blank">康顕 有賀</a></strong> </div>

Rubyistであり本勉強の発起人でありRubyKajaにも選ばれたchezouさんがgemよりも先にPypiデビューしたという話をされました。
今回作成したpipは形態素解析器であるKyTeaを、Pythonから扱えるようにした[Mykytea-python](https://github.com/chezou/Mykytea-python)で、
本発表ではpip化するにあたっての苦労した点などを話されていました。

### React.jsでRailsのScaffoldを再現してみた from [@Peranikov](https://twitter.com/Peranikov)

以前にQiitaに投稿した、RailsのScaffoldで生成したようなアプリケーションをReact.jsを使って作成したという記事を紹介しました。

発表したエントリーは[こちら](http://qiita.com/Peranikov/items/ba6f31a88139543db6b8)

この記事は以前に[すぎゃーんさんの記事](http://d.hatena.ne.jp/sugyan/20150407/1428412140)で紹介され、そのことについても触れました。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">.<a href="https://twitter.com/Peranikov">@Peranikov</a> さん「sugyanさんが同じようなコンセプトのReact.jsのScaffoldのを使っていた。 sugyan さんはワシが育てた」 <a href="https://twitter.com/hashtag/kwskrb?src=hash">#kwskrb</a></p>&mdash; kawasakirb (@kawasakirb) <a href="https://twitter.com/kawasakirb/status/603531495454552064">2015, 5月 27</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

申し訳ありませんでした。

# 次回予告

次回は6/24(水)開催の予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

RailsからiOSから何でもやってる人。お酒を投稿するサイト[Puhaar!](http://puhaar.jp/)を運営しています。
