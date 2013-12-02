#!/usr/bin/python
#coding:utf8
#python脚本，利用百度音乐API直接播放百度音乐

import httplib2
from xml.dom import minidom
import os

def getmp3url(title='安静',performer='周杰伦'):
    urlrequest = httplib2.Http()
    xml=urlrequest.request('http://box.zhangmen.baidu.com/x?op=12&count=1&title={0}$${1}$$$$'.format(title,performer))[1]
    xml_parse = minidom.parseString(xml.encode('utf-8'))
    count = xml_parse.getElementsByTagName('count')[0]
    print count.childNodes[0].data
    
if __name__ == '__main__':
    getmp3url()
