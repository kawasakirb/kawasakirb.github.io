---
layout: post
title: "kawasaki.rb #036を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

2016年5月25日(水)にNTT-ATさんの会議室にて[kawasaki.rb #036](https://kawasakirb.doorkeeper.jp/events/45621){:target="_blank"}を開催しました。

togetterのまとめは[こちら](http://togetter.com/li/980013){:target="_blank"}

## パーフェクトRuby読書会

「5-2-6 エンコーディングの扱い」まで終えました。

# 5-2-6 エンコーディングの扱い

Rubyでは1.9から文字列にエンコーディング情報を保持しています。
String#encodingでエンコーディング情報を取得できます。

{% highlight ruby linenos %}
'いろはに'.encoding # => #<Encoding:UTF-8>
{% endhighlight %}

文字列のエンコーディングを変更するにはString#encodeを使用します。

{% highlight ruby linenos %}
str = 'こんにちは'
str.encoding # => #<Encoding:UTF-8>

new_str = str.encode(Envoding::EUC_JP) # => "\x{A4B3}\x{A4F3}\x{A4CB}\x{A4C1}\x{A4CF}"
new_str.encoding # => #<Encoding:EUC-JP>

# 破壊的メソッド
str = 'こんにちは'
str.encoding # => #<Encoding:UTF-8>
str.encode!(Envoding::EUC_JP) # => "\x{A4B3}\x{A4F3}\x{A4CB}\x{A4C1}\x{A4CF}"
str.encoding # => #<Encoding:EUC-JP>
{% endhighlight %}

主にマルチバイトの場合、同じ文字列でもエンコーディングが異なると同値にはなりません。

{% highlight ruby linenos %}
utf8 = 'こんにちは'.encode('UTF-8')
eucjp = 'こんにちは'.encode('EUC-JP')

# 比較
utf8 == eucjp # => false
utf8.eql?(eucjp) # => false (eql?はハッシュのキーが同じか調べるときに使う)

# 連結
utf8 + eucjp # => Encoding::CompatibilityError: incompatible character encodings: UTF-8 and EUC-JP
{% endhighlight %}

ただし、ASCII互換エンコーディングな文字列とASCIIのみの文字列の比較や結合はエンコーディングに関わらず行えます。

{% highlight ruby linenos %}
eucjp = 'Hello'.encode('EUC-JP')
utf8 = 'Hello'.encode('UTF-8')
utf16 = 'Hello'.encode('UTF-16')
ascii = 'Hello'.encode('ASCII-8BIT')

# 比較
utf8 == eucjp # => true
utf8 == ascii # => true
utf8 == utf16 # => false

# 連結
utf8 + eucjp # => "HelloHello"
utf8 + ascii # => "HelloHello"
utf8 + utf16 # => Encoding::CompatibilityError: incompatible character encodings: UTF-8 and UTF-16
{% endhighlight %}

会場では、UTF-8とEUC-JPを結合した場合どちらのエンコーディングになるのかという質問があがりました。

{% highlight ruby linenos %}
(utf8 + eucjp).encoding # => #<Encoding:UTF-8>
(eucjp + utf8).encoding # => #<Encoding:EUC-JP>
{% endhighlight %}

このように、レシーバのエンコーディングが優先されるようです。
こういったエンコーディング周りの話は[プログラマのための文字コード技術入門](http://www.amazon.co.jp/dp/477414164X)を読むとソフトウェア界の歴史が分かり良いそうです。

次回は「5-3 Regexp」からです。

今回のiruby notebookは以下のとおりです。

<iframe src="http://nbviewer.ipython.org/github/kawasakirb/meetups/blob/master/pruby/kawasakirb036.ipynb" width="100%" height="400px"></iframe>

[別タブで開く](https://github.com/kawasakirb/meetups/blob/master/pruby/kawasakirb036.ipynb)

## セッション

### Let’s EncryptのDNS-01を使用して無料のSSL証明書をWebサーバなしで取得する from [@xmisao](https://twitter.com/xmisao)

無料でSSLを使用することができるLet’s Encryptの証明書をを
Webサーバを用意せずにDNSサーバで取得した話をされました。

発表元となった記事は[こちら](http://www.xmisao.com/2016/04/18/get-free-certification-by-letsencrypt-dns-01-authentication.html)

### データを一箇所に集めることでデータ活用の民主化が進んだ話 from [@chezou](https://twitter.com/chezou)

データを一箇所に集め整備することで、エンジニアの手を借りずWebディレクター陣だけで分析を行うことができるようになったこととその背景について語られました。

発表元となった記事は[こちら](http://chezou.hatenablog.com/entry/2016/05/05/222046)

また、chezou氏が配信している[rubyistclub #9](https://rubyist.club/9/)では、最近はデータ移行業を生業としている[jocker1007](https://twitter.com/jocker1007)氏との対談でRedshiftとBigQueryの比較などの話を聴くことができます。

# 告知

2016年8月20日に川崎Ruby会議を実施します。参加募集は近日公開いたします。お楽しみに!

[http://regional.rubykaigi.org/kwsk01/](http://regional.rubykaigi.org/kwsk01/)

# 次回予告

次回は2016年6月22日(水)(毎月第4水曜日)開催予定です。ご参加お待ちしております。

# 寄稿者について

松久保 敬人 ([@Peranikov](https://twitter.com/Peranikov))

node.jsやiOSアプリ開発を経て今はRailsとDDDとScalaの人。
