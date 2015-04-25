---
layout: post
title: "kawasaki.rb #023を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---

{% include JB/setup %}

4/23(水)にNTT-ATさんの会議室にて[kawasaki.rb #023](https://kawasakirb.doorkeeper.jp/events/23536)を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/811934)

## パーフェクトRuby読書会

3-6-2 外部コマンドを実行するまで終えました。

### 3-6-2 外部コマンドを実行する

Rubyでは外部コマンドを呼び出す際に`(バッククォート)を使用します

{% highlight ruby %}
num = 1
`head -#{num} ~/.vimrc` # => (~/.vimrcの1行目が表示される)
{% endhighlight %}

この時、戻り値は外部コマンドの標準出力となります。
外部コマンドの戻り値が必要でない場合は、Kernel.#systemを用います。
この時、外部コマンドの終了ステータスが0の場合はtrue、それ以外の場合はfalseを返します。

{% highlight ruby %}
system('uname') # => true
{% endhighlight %}

直前に実行したコマンドの終了ステータスは組み込み変数$?で確認できます。

{% highlight ruby %}
system('uname') # => true
$? # => => #<Process::Status: pid 2087 exit 0>
{% endhighlight %}

Kernel.#execはKernel.#systemと同じく、引数に与えられた外部コマンドを実行します。systemとの違いは、実行中のRubyプロセスは外部コマンドのプロセスに変わり、外部コマンドの実行が終了しても制御は戻らずプロセスが終了します。

{% highlight ruby %}
exec('uname')
puts 'hello' # この行は実行されない
{% endhighlight %}

Kernel.#`やKernel.#systemは外部コマンドが終了するまで処理を同期的に待ちますが、Kernel.#spawnは即座に子プロセスのPIDを返します。

{% highlight ruby %}
pid = spawn('sleep 10; uname') # 10秒後に標準出力で"Darwin"と表示される
{% endhighlight %}

system,exec,spawnメソッドには第一引数にハッシュを指定する指定することができ、これを用いて環境変数の追加/変更することができます。

{% highlight ruby %}
ENV['HOGE'] = 'hoge'
system('echo $HOGE') # => hoge

system({'HOGE' => 'piyo'}, 'echo $HOGE') # => piyo

pid = spawn({"HOGE" => 'piyo'}, 'sleep 10; echo $HOGE')
Process.waitpid pid

exec({"HOGE" => 'piyo'}, 'echo $HOGE')
{% endhighlight %}


第二引数(第一引数に環境変数を指定した場合には第三引数)にはハッシュでオプションを指定することができます

{% highlight ruby %}
system('echo `pwd`', chdir: '/tmp') # => Macの場合、シンボリックリンクが張られているため"/private/tmp"と表示された
{% endhighlight %}

なお、このオプションについてはRubyリファレンスのspwanのページに記載されていました。

[http://docs.ruby-lang.org/ja/2.2.0/method/Kernel/m/spawn.html](http://docs.ruby-lang.org/ja/2.2.0/method/Kernel/m/spawn.html)

会場では、オプションからchdirを指定しなくても内部でcdすれば良いのではないか?という議論がありましたが、下記のような挙動の差がありました。

{% highlight ruby %}
# /dummyは存在しないパス
system('echo `pwd`', chdir: '/dummy') # => nil
system('cd /dummy; echo `pwd`') # => cd失敗後にpwd実行後、trueが返される
{% endhighlight %}

と、オプションのchdirに存在しないパスを指定した場合、処理を実行せず戻り値をnilで返すという挙動をしてくれました。

## セッション

### 日本のJuliaもっと盛り上げてこ⤴⤴ [@chezou](https://twitter.com/chezou)さん

2015/4/25に開催された[Julia Tokyo](http://juliatokyo.connpass.com/event/13218/)で発表するスライドを使ってJuliaの紹介をしていただきました。

Juliaはスクリプト言語の感覚で書ける科学技術計算向け言語であり、こちらの[ベンチマーク](http://julialang.org/benchmarks/)にもあるように、処理によってはC並みのパフォーマンスが出せる、ということが売りの言語のようです。

また、Juliaの入門には[X分で学ぶJulia - りんごがでている](http://bicycle1885.hatenablog.com/entry/2014/12/01/050522)が良いとのご紹介もありました。

# まとめ

次回は5/20(水)に開催します。
