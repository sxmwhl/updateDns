﻿##简介

此脚本可作为动态域名解析的替代方案，在无法实现动态域名解析时，可用此脚本实时将动态外网IP地址绑定至固定网址（URL），实现通过同一地址（URL）访问固定设备。

##使用条件

* 1、设备可运行shell命令；
* 2、与外网连接，且可直接通过ip地址访问；

##使用方法

* 1、登录http://www.3dant.cn注册申请一个固定Dns地址；
* 2、将本文件夹上传至设备，并定时运行updateDns.sh脚本。

参考如下crontab命令行：

  `*/20 * * * * /home/updateDns.sh 1 ddfd8XXXX`
  `*/20 * * * * `表示20分钟执行一次脚本；
  `/home/updateDns.sh` 为脚本位置；
  `1` 是固定Dns的ID
  `ddfd8XXXX` 是固定Dns的密码

##文件说明

 /
   ip.txt 最新外网ip地址
   oldIp.txt 上一次ip地址
   status.txt 更新状态，可查看此文件了解脚本执行情况
   updateDns.sh 执行更新脚本
   README.md 本文件
   
##脚本信息
  版本：v1.0
  作者：月夕人
  时间：2015.11.14
