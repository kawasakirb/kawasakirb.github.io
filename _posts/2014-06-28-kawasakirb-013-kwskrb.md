---
layout: post
title: "kawasaki.rb #013を開催しました #kwskrb"
description: ""
category: kawasakirb
tags: [ruby, kawasaki.rb]
---
{% include JB/setup %}

6/25(水)にNTT-ATさんの会議室にて[kawasaki.rb #013](http://kawasakirb.doorkeeper.jp/events/12509)を開催しました。

今度こそ、一周年です。

<blockquote class="twitter-tweet" lang="ja"><p>kawasaki.rb 1周年おめでとうございました🎂 <a href="https://twitter.com/hashtag/kwskrb?src=hash">#kwskrb</a></p>&mdash; ごしゅじん (@kk_Ataka) <a href="https://twitter.com/kk_Ataka/statuses/481804716901298176">2014, 6月 25</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

[togetter](http://togetter.com/li/684939)

## パーフェクトRuby読書会
"3-2-1 条件分岐"の`case when`の前までやりました。
1節終わらなかった...。

レシピブックと違って長さがまちまちなのが読む時気をつけないといけないですね。


## [@kk_Ataka](https://twitter/kk_Ataka) さん「SIerでもSphinxを使いたい！ 前編」

<iframe src="//www.slideshare.net/slideshow/embed_code/36299157" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px 1px 0; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="https://www.slideshare.net/kk_Ataka/20140625-sphinx" title="SIerでもSphinxを使いたい！ 前編" target="_blank">SIerでもSphinxを使いたい！ 前編</a> </strong> from <strong><a href="http://www.slideshare.net/kk_Ataka" target="_blank">kk_Ataka</a></strong> </div>

Wordの日付管理いやだよね、というところからSphinxを使い始めたというお話。
次回が楽しみですね。


## [@youkinjoh](https://twitter/youkinjoh)さん「WebRTCの話」

<iframe src="//www.slideshare.net/slideshow/embed_code/36293601" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px 1px 0; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="https://www.slideshare.net/You_Kinjoh/20140627-story-ofwebrtc" title="WebRTCの話" target="_blank">WebRTCの話</a> </strong> from <strong><a href="http://www.slideshare.net/You_Kinjoh" target="_blank">You_Kinjoh</a></strong> </div>

[ハイパフォーマンス ブラウザネットワーキング](http://www.oreilly.co.jp/books/9784873116761/)の翻訳レビューもされた金城さんのWebRTCのトーク。
[WebRTC](http://ja.wikipedia.org/wiki/WebRTC)はウェブブラウザでボイスチャット、ビデオチャット、ファイル共有ができるAPIとのことです。
フル版の資料は[こちら](http://www.slideshare.net/mobile/You_Kinjoh/fundamentals-andapplicationsofhtml5secondedition)。

デモで見せていただいた、[VCMap](http://vcmap.net/)はWebRTCを使ったビデオチャットシステムです。
特徴的なのは、JSで顔検出をして追従しつつ、地図上に描画することです。
実際、ブラウザだけで各自がテザリングした回線でP2Pでビデオチャットできたデモには驚きました。

なお、シグナリングにはサーバが必要なのですが、[SkyWay](http://nttcom.github.io/skyway/)を使えばそのサーバを肩代わりしてくれるようです。
また、Heroku上でも動くWebRTCサーバ[PeerServer](http://qiita.com/atskimura/items/132a39181ad69fab2d63)があるので、そちらを利用してみるのも良いかもしれません。


## 雑感


懇親会では [@harupong](http://twitter.com/harupong)さんと翻訳トークで盛り上がったり、[jekyllrb-ja](http://jekyllrb-ja.github.io/)のv2に向けたキックオフの機運が高まったりと良い話ができました。

まさかの、[rebuild.fm](http://rebuild.fm/)のtranscriptionの宣伝がkawasaki.rbで聞けるとは思っていませんでした。

<blockquote class="twitter-tweet" lang="ja"><p>今日のハイライト。lean analyticsの翻訳とrebuild.fmの書き起こしは <a href="https://twitter.com/harupong">@harupong</a> さんの仕事が暇になったから出ることらしい。Matzもだけど、仕事が暇になるのは世の中に貢献するようだ。定時退勤が生産性を、増している</p>&mdash; chezou (@chezou) <a href="https://twitter.com/chezou/statuses/481800456927080450">2014, 6月 25</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

あと、[kk_Atakaさんの提案](https://github.com/kawasakirb/meetups/pull/17)でmeetupsにちょっと手を加えると、kawasakirb.github.ioに[自己紹介が連動して出る]({{ site.url }}/meetups/members/gosyujin.html)ようになりました。
Pull Requestお待ちしております！

