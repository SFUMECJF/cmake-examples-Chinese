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

[贡献者主页](https://bye-lemon.github.io/)

# cmake-examples-Chinese
在线阅读地址：[通过例子学习CMake](https://sfumecjf.github.io/cmake-examples-Chinese/)

该CMake推荐学习方式是通过阅读在线阅读电子书。（也即gitPages分支）
此外，也可下载main分支，在Linux平台上运行相关代码。加深理解。如果不运行，其实在电子书中也有编译输出结果。


**觉得有用的话，希望给个star哦～**
##  什么是cmake
CMake是一个跨平台的安装（编译）工具，可以用简单的语句来描述所有平台的安装(编译过程)。他能够输出各种各样的makefile或者project文件，CMake 的组态档取名为 CMakeLists.txt。也就是在CMakeLists.txt这个文件中写cmake代码。
一句话：cmake就是将多个cpp、hpp文件组合构建为一个大工程的语言。
##  本cmake系列介绍
首先大家学习cmake一定会遇到《cmake practice》这本书，但是纯粹讲理论，如果没有实践的话是学不会的。所以我当时从知乎上看到了上面的github地址，它通过一个个例子来进行学习。而我的github就是在学习过程中做的翻译。会持续进行下去的。

我通过Robomaster这个比赛，迄今学习cmake一年了。而cmake作为一个和实践结合相当紧密的语言没有出版的读物教授这些内容。事实上，cmake也并不难，在实践中学习即可，忘记的内容直接查手册。而我比较推荐github上的[cmake例程](https://github.com/ttroy50/cmake-examples)，直接通过cmake程序学习。

另外，在不太大的工程中，其实cmake也不需要钻研到多深入，日后工作用得多了自然就会了。比如，我在学习过程中，也请教过网上一些已经工作的人cmake内容，比如说PRIVATE、INTERFACE、PUBLIC这三个参数在实际中的用途，当时请教了wps的一位前辈，他自己也是偶尔有一次用这三个参数测试了一下。而我花费很多时间钻这块内容，最终的理解在这篇文章中[cmake-scope](https://blog.csdn.net/weixin_42089190/article/details/105357050)。但是现在也已经忘掉了，而且在自己的实践中也很少用到。所以，感觉cmake写出来，差不多能用就行，工作了再钻研。
##  获取途径
直接将本github克隆到本地阅读即可。
```shell
git clone https://github.com/SFUMECJF/cmake-examples-Chinese.git
```
##  CSDN地址
其实和本github的内容是一样的。
CSDN专栏：https://blog.csdn.net/weixin_42089190/category_10449170.html

[视觉笔记CMake(一)hello-cmake](https://blog.csdn.net/weixin_42089190/article/details/104896748)

[视觉笔记CMake(二)hello-headers](https://blog.csdn.net/weixin_42089190/article/details/105046533)

[视觉笔记CMake（三）Static Library](https://blog.csdn.net/weixin_42089190/article/details/105343675)

[视觉笔记CMake（四）Shared Library](https://blog.csdn.net/weixin_42089190/article/details/106058822)

[视觉笔记CMake（五）build-type](https://blog.csdn.net/weixin_42089190/article/details/106420270)

[视觉笔记CMake（六） Compile Flags](https://blog.csdn.net/weixin_42089190/article/details/106836208)

[视觉笔记CMake（七） Including Third Party Library](https://blog.csdn.net/weixin_42089190/article/details/108942491)

[视觉笔记CMake-scope](https://blog.csdn.net/weixin_42089190/article/details/105357050)



如果没什么精力，看到[视觉笔记CMake（六） Compile Flags](https://blog.csdn.net/weixin_42089190/article/details/106836208)基本上就可以了。
##  微信公众号
最后，博主也只是一个初学者罢了，只是把自己学习过程中的东西做了总结，如果大家有什么想法，欢迎指正。我的微信公众号如下：
现阶段主要总结计算机视觉知识：Qt，C++，CMake,OpenCV等等
公众号名称：三丰杂货铺

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200529103009878.gif#pic_center)
