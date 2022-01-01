<table border="0" width="10%" align="center">
  <tr>
    <td><img src="https://img1.github.io/tmp/1.jpg" height="80" width="82"></td>
    <td><img src="https://img1.github.io/tmp/2.jpg" height="80" width="82"></td>
    <td><img src="https://img1.github.io/tmp/3.jpg" height="80" width="82"></td>
  </tr>
  <tr>
    <td><img src="https://img1.github.io/tmp/4.jpg" height="80" width="82"></td>
    <td><img src="https://img.shields.io/github/stars/SFUMECJF/cmake-examples-Chinese.svg?style=social"></td>
    <td><img src="https://img1.github.io/tmp/6.jpg" height="82" width="82"></td>
  </tr>
   <tr>
    <td><img src="https://img1.github.io/tmp/7.jpg" height="82" width="82"></td>
    <td><img src="https://img1.github.io/tmp/8.jpg" height="82" width="82"></td>
    <td><img src="https://img1.github.io/tmp/9.jpg" height="82" width="82"></td>
  </tr>
</table>

<p align="center">
  <a href="https://github.com/vuejs/vue">
    <img src="https://img.shields.io/badge/ubuntu-1604/1804/2004-brightgreen.svg" alt="ubuntu">
  </a>
  <a href="https://github.com/vuejs/vue-router">
    <img src="https://img.shields.io/badge/Language-C++--shell-brightred.svg" alt="vue-router">
  </a>
  <a href="https://github.com/vuejs/vuex">
    <img src="https://img.shields.io/badge/学习方式-在线阅读-brightgreen.svg" alt="vuex">
  </a>
</p>  


仓库受到的关注度越来越高，考虑到大家学习容易出现问题，现在创建一个qq交流群：433323162。微信群可以扫码加入。    


# cmake-examples-Chinese

项目在线阅读电子书地址：[通过例子学习CMake](https://sfumecjf.github.io/cmake-examples-Chinese/)

本教程全部采用中文，通过一个个例子帮助读者由浅入深逐渐理解CMake的语法。教程主要来源于github优秀CMake项目，项目贡献者在翻译中，又查阅CMake官方手册，或者与已经工作的C++开发者交流，对于模糊的地方予以详细说明。

非常适合完全没接触过CMake以及shell的人从头阅读。

另外，在部署过程中，main分支的代码会比在线电子书的更新进度快，因为页面部署总是出现问题。最近打算弃用部署页面的`gitbook`工具（它已经过时了，过时至少2年）。


**觉得有用的话，希望给个star哦～**
##  什么是cmake
CMake是一个跨平台的安装（编译）工具，可以用简单的语句来描述所有平台的安装(编译过程)。他能够输出各种各样的makefile或者project文件，CMake 的组态档取名为 CMakeLists.txt。也就是在CMakeLists.txt这个文件中写cmake代码。
一句话：cmake就是将多个cpp、hpp文件组合构建为一个大工程的语言。

##  本cmake系列介绍
首先大家学习cmake一定会遇到《cmake practice》这本书，但是纯粹讲理论，如果没有实践的话是学不会的。<mark>learning by doing</mark>是学习各种知识的不二法门。

另外，在不太大的工程中，其实cmake也不需要钻研到多深入，日后工作用得多了自然就会了。比如说PRIVATE、INTERFACE、PUBLIC这三个参数在实际中的用途，当时请教了wps的一位前辈，最终的理解在这篇文章中[cmake-scope](https://github.com/SFUMECJF/cmake-examples-Chinese/blob/main/CMake-scope.md)。他自己也是偶尔有一次用这三个参数测试了一下，其他时候不怎么关心。

而如果作为在校学生，花费很多时间钻这块内容，不实践也很快会忘掉。所以，基本上cmake写出来，能用就行，学习阶段不要钻牛角尖，工作了再钻研。

如果想要快速入门，直接学习`01-basic`即可，学完就可以动手编写自己的工程了。有时间可以学习`02-sub-projects`以及`03-code-generation`。

另外，大家学习CMake的主要目的还是用于实操，所以本文作者在第4个文件夹`实践案例`中提供了使用CMake包含`Open CV`,`dcmtk`, `qt`的CMake工程，大家可以直接下载使用，根据里面的readme进行初步配置。如果遇到错误可以告诉我，我来修改。

## 学习途径

推荐在线阅读该电子书，快速过一遍知识点。

时间充足想打基础的人，可以结合[原项目例子](https://github.com/ttroy50/cmake-examples)，在Linux系统下载运行代码。当遇到有疑问的地方，查阅本项目手册。



点个star以后，直接将本github克隆到本地或者fork,欢迎PR。

```shell
git clone https://github.com/SFUMECJF/cmake-examples-Chinese.git
```
##  微信公众号
最后，博主也只是一个初学者罢了，只是把自己学习过程中的东西做了总结，如果大家有什么想法，欢迎指正。我的微信公众号如下：
现阶段主要总结计算机视觉知识：Qt，C++，CMake,OpenCV等等
公众号名称：三丰杂货铺

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200529103009878.gif#pic_center)
