# ZCPasswordTextField
平时开发常用的几种密码输入框样式，如果有需要可以自行修改或者再次封装处理,如果发现有问题,请issue,谢谢.
![ZCPasswordField.gif](https://upload-images.jianshu.io/upload_images/1504763-ce5ec8cfb23ff9d0.gif?imageMogr2/auto-orient/strip)

---
## 安装方式
* 直接使用,git clone之后,把相关文件资源拉入到自己的项目中
---
## 使用方式
到达指定长度后触发`UITextFieldDelegate`代理事件停止接收键盘输入，拦截多余输入
```
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
     NSString *new_string = [textField.text stringByReplacingCharactersInRange:range withString:string];
     return new_string.length <= 6;
 }
```
达到指定位数键盘收回，输入完成触发`UITextFieldDelegate`代理
```
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"text:%@--%ld",textField.text, reason);
    if (reason == UITextFieldDidEndEditingReasonCommitted) {
        // your code
    }
}
```
#### 下面样式是目前使用比较多的样式:

* 下划线高亮明文输入框样式,如下图
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.01.55.png](https://upload-images.jianshu.io/upload_images/1504763-798515811c2705a5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* 下划线高亮密文样式,如下图:
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.02.04.png](https://upload-images.jianshu.io/upload_images/1504763-1426074158f1f4e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 矩形边框明文样式,如下图:
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.02.13.png](https://upload-images.jianshu.io/upload_images/1504763-62f24f99b3b90160.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 矩形边框密文样式,如下图:
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.03.59.png](https://upload-images.jianshu.io/upload_images/1504763-cda7346264101339.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 圆角边框明文文样式,如下图:
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.04.13.png](https://upload-images.jianshu.io/upload_images/1504763-b0ca32cf10249da6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 圆角边框密文文样式,如下图:
![
](https://upload-images.jianshu.io/upload_images/1504763-a903bb9531cb572c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 矩形块明文文样式,如下图:
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.04.35.png](https://upload-images.jianshu.io/upload_images/1504763-1ea81623a9209664.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 矩形块密文文样式,如下图:
![Simulator Screen Shot - iPhone 12 mini - 2021-02-13 at 15.04.44.png](https://upload-images.jianshu.io/upload_images/1504763-b89a52ba70f7dc13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)







