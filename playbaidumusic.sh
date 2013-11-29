#!/bin/bash
#脚本作用，调用mplayer播放百度音乐，需要预装mplayer

#定义各种变量
title=${1:-'大约在冬季'} #歌曲名
performer=${2:-'齐秦'}   #歌手名

getmp3url(){
    url='http://box.zhangmen.baidu.com/x?op=12&count=1&title='$title'$$'$performer'$$$$'
    xml=`curl -s ''$url''`
    count=`echo $xml | xmllint --xpath '/result/count/text()' - `
    if [ "$count" -eq 0 ]
    then
        exit 1
    fi
    encode=`echo $xml | xmllint --xpath '/result/url[1]/encode[1]/text()' - | sed -r 's/<\!\[CDATA\[(.+)\]\]>/\1/g'`
    decode=`echo $xml | xmllint --xpath '/result/url[1]/decode[1]/text()' - | sed -r 's/<\!\[CDATA\[(.+)\]\]>/\1/g'`
    echo `dirname $encode`/$decode
}
url=`getmp3url` && mplayer $url || echo "检索结果不存在，请选用别的歌曲名和歌手检索！" && exit 1
