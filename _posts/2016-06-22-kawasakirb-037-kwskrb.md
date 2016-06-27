---
layout: post
title: "kawasaki.rb #037を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

2016年6月22日(水)にNTT-ATさんの会議室にて[kawasaki.rb #037](https://kawasakirb.doorkeeper.jp/events/47273){:target="_blank"}を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/991302){:target="_blank"}

## パーフェクトRuby読書会

「5-3-3 量指定子」まで終えました。

# 5-3-1 パターンマッチ

文字列とマッチするかを判定するには`Regexp#===`を用います

{% highlight ruby linenos %}
/[0-9]/ === 'ruby' # => false
/[0-9]/ === 'ruby5' # => true
{% endhighlight %}

マッチした位置を返すには`Regexp#=~`を用います

{% highlight ruby linenos %}
/[0-9]/ =~ 'ruby' # => nil
/[0-9]/ =~ 'ruby5' # => 4
{% endhighlight %}

`Regexp#===`は、正規表現と文字列のどちらでも使うことができます。

{% highlight ruby linenos %}
def alice?(pattern)
  pattern === 'alice'
end

alice?(/Alice/i) # => true
alice?('alice') # => true
{% endhighlight %}

`Regexp#match`はマッチしなければnil、マッチした場合はMatchDataオブジェクトを返します。

{% highlight ruby linenos %}
/[0-9]/.match('ruby') # => nil
/[0-9]/.match('ruby5') # => #<MatchData "5">
{% endhighlight %}

MatchDataからはマッチした文字列の情報を取得することができます。これは$&などの組み込み変数からも取得できます。

{% highlight ruby linenos %}
/[0-9]/.match('ruby5')
$& # => 5 # 直前にマッチした文字列
$1 # => nil # 直前にマッチした文字列の1番目のキャプチャ
$` # => "ruby"
$' # => ""
{% endhighlight %}

また、`Regexp#last_match`で直前のMatchDataを取得することもできます。

{% highlight ruby linenos %}
/(あば).+(ばあ)/ =~ '「あばばばばばば、ばあ！」' # => 1
match = Regexp.last_match # => #<MatchData "あばばばばばば、ばあ" 1:"あば" 2:"ばあ">
match.pre_match # => "「"
match[0] # => "あばばばばばば、ばあ"
match[1] # => "あば"
match[2] # => "ばあ"
match[-1] # => "ばあ"
match.post_match # => "！」"
{% endhighlight %}

`String#scan`は与えられた正規表現にマッチした部分文字列を配列で返します。

{% highlight ruby linenos %}
str = 'Yamazaki Niizaki'
str.scan(/\w+zaki/) # => ["Yamazaki", "Niizaki"]
str.scan(/(\w+)zaki/) # => [["Yama"], ["Nii"]]
{% endhighlight %}

`String#scan`はブロックをうけとりマッチした部分文字列の数だけ繰り返し実行します。

{% highlight ruby linenos %}
str.scan(/\w+zaki/) {|s| puts s.upcase}
YAMAZAKI
NIIZAKI

# ここのパーフェクトRubyのコードでは下記のようになっていますが、キャプチャで取得した時の
# sは配列になるので`String#upcase`は呼ぶことができません。
# str.scan(/(\w+)zaki/) {|s| puts s.upcase}

# 例えば`Array#first`を通してあげれば通ります
str.scan(/(\w+)zaki/) {|s| puts s.first.upcase}
# => YAMA
# => NII
{% endhighlight %}

正規表現に記号を使用する場合バックスラッシュでエスケープします。
正規表現で式展開を用いる場合は必要に応じて`Regexp#quote`、`Regexp#escape`でエスケープできます。

{% highlight ruby linenos %}
part = Regexp.escape('(incomplete)') # => "\\(incomplete\\)"
/[^.]+#{part}\.txt/ # => /[^.]+\(incomplete\)\.txt/
{% endhighlight %}

# 5-3-2 文字クラス

[]で文字を囲むと文字クラスの指定になります。例えば`[abc]`はa,b,cのいずれかの1文字にマッチします。

{% highlight ruby linenos %}
/[abc]/ =~ 'xyaz' # => 2
/\w/ =~ '0' # => 0 (\wは[0-9A-Za-z]と同義)
/\w/ =~ 'Z' # => 0
/[\w\s]/ =~ ' ' # => 0 (\w\sは[0-9A-Za-z_\t\r\n\f]と同義)
/[\w\s]/ =~ "\t" # => 0
/[\w\s]/ =~ "\f" # => 0 (\fは改ページとのこと)
{% endhighlight %}

# 5-3-3 量指定子

「*」「+」「?」「{m,n}」などは量指定子です。パターンの繰り返しを表現します。

{% highlight ruby linenos %}
pattern = /\d{3}-\d{4}-\d{4}/
pattern === '080-1234-5678' # => true
pattern === '03-1234-5678' # => false
{% endhighlight %}

次回は「5-3-4 先頭と末尾」からです。

## セッション

### THETA Sを使った360度ライブ配信 from [@youkinjoh](https://twitter.com/youkinjoh)

7/1の川崎市民の日にあるミューザの日で展示する予定の、[THETA S](https://theta360.com/ja/about/theta/s.html)を使った360度ライブ配信の話をされ、  
WebGLを使ったウェブブラウザ上での全方位映像の配信と、Nexus5Xを使ったVRのデモが行われました。  
なお実装は全てJSで行われているとのことです。

### Twitterのリストを管理しやすいツールを作った話 from [@ryonext](https://twitter.com/ryonext)

<script async class="speakerdeck-embed" data-id="34b1d7b3f4114c0597c73d98a6870af1" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

公式Twitterや類似サービスののリスト編集が使いにくかったことから、RailsとVue.jsを駆使して新しいツールを作った話をされました。  
TwitterAPIを使い潰さないようにする工夫が盛り込まれた資料となっております。

## LINE botとGo言語とGAEとVision API from [@kechako](https://twitter.com/kechako)

発表資料は[こちら](https://docs.google.com/presentation/d/1mMUz6HyfVEfV0Ftb6H8y0lKtXwCBwdNERa5_BKYyBTM/edit#slide=id.g15073e308c_1_0)

GAE上でGoを用いてLINEBOTを動かし、GoogleのVision APIを使用した画像解析、位置情報からの天気予報取得、ズンドコキヨシのデモが行われました。  
ここで使ったGAEのサービスはほぼ無料で構築できたとのことです。

### Native Extensionのビルドどうしてますか? from [@xmisao](https://twitter.com/xmisao)

<iframe src="//www.slideshare.net/slideshow/embed_code/key/DIiocQVmJtVH8A" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/xmisao/native-extension" title="Native Extensionのビルドどうしてますか?" target="_blank">Native Extensionのビルドどうしてますか?</a> </strong> from <strong><a href="//www.slideshare.net/xmisao" target="_blank">Misao X</a></strong> </div>

Gemをインストールする時にNative Extensionのビルドに必要なパッケージを自動で取得したいというニーズから、  
DockerのコンテナOSとしてよく利用されるAlpine Linux上で動くGem「tirofinale」を作られた話がありました。  
このGemでいつかnokogiriをインストールするにはtirofinaleを使えば良い、という記事が増える未来が来ることを期待します。  

xmisaoさんが作成されたティロ・フィナーレは[こちら](https://github.com/xmisao/tirofinale)

# 告知

2016年8月20日に川崎Ruby会議を実施します。参加募集は近日公開いたします。お楽しみに!

[http://regional.rubykaigi.org/kwsk01/](http://regional.rubykaigi.org/kwsk01/)

# 次回予告

次回は2016年7月27日(水)(毎月第4水曜日)開催予定です。次回は「ほぼ3周年記念LT大会」を開催します!  
ご参加は[こちら](https://kawasakirb.doorkeeper.jp/events/47785)から。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

node.jsやiOSアプリ開発を経て今はRailsとDDDとScalaの人。
