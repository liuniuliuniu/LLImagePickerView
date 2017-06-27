# LLImagePicker
完整的媒体库选择和展示的框架。包括本地图片、视频选取，拍摄、录像等，并得到对应的用于上传的数据类型，媒体文件上传从此简单上手。

![LLImagePickerGif.gif](https://github.com/liuniuliuniu/LLImagePicker/blob/master/LLImagePickerDemo.gif)

## 导航
* [基本要求](#Requirements)
* [实现功能](#function)
* [结构层次](#Architecture)
* [如何添加](#add)
* [使用详情](#detail)
* [属性自定义](#custom)
* [V1.1更新](#V1.1Update)
* [Hope](#hope)


## <a id="Requirements"></a>基本要求

* iOS 8.0  or later

* Xcode 7.0 or later

* 用到github上第三方：[TZImagePickerController](https://github.com/banchichen/TZImagePickerController)和[MWPhotoBrowser](https://github.com/mwaterfall/MWPhotoBrowser)和 [ACAlertController](https://github.com/honeycao/ACAlertController)


## <a id="function"></a>实现功能
* 本地图片视频选择、拍照录制等一条龙轻松实现
* 框架主体是一个view，已经实现高度配置，不用再去做任何处理
* 框架主体形势支持：添加媒体、预览展示媒体、混合编辑（添加和预览展示一起实现）
* 选择媒体上支持：删除、限定最大选择数数量、同个媒体资源是否多次选择等。、
* 从本地相册选择图片用到了`TZImagePickerController`；查看图片视频用到了`MWPhotoBrowser`；底部弹出框用到`ACAlertController`替代系统弹框
* 自定义媒体model，返回图片、视频上传数据类型，如：NSData或视频路径。不用为了得到上传的数据类型做任何处理了。

## <a id="Architecture">结构层次

### <a id="add"></a>如何添加

* 不支持cocopod<因为这个LLImagePicker名字已经被占用了   宝宝也很无奈呀>


* 手动添加
- 把`LLImagePicker`文件拉到项目中
- 添加头文件`#import "LLImagePicker.h"`

### <a id="detail"></a>使用详情（具体看 `LLImagePickerDemo` 示例）
*demo目录分析*
* `AddLLImagePickerVC`        添加媒体的演示
* `DisplayLLImagePickerVC`    预览媒体的演示
* `EditLLImagePickerVC`       添加和预览混合编排的演示
```
// 唯一获取初始化高度的方法
CGFloat height = [LLImagePickerView defaultViewHeight];

// 初始化
LLImagePickerView *pickerV = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];

// 需要展示的媒体的资源类型，当前是仅本地图库
pickerV.type = LLImageTypePhoto;

// 是否允许 同个图片或视频进行多次选择
pickerV.allowMultipleSelection = YES;

//视情况看是否需要改变高度，目前单独使用且作为tableview的header，并不用监控并改变高度
[pickerV observeViewHeight:^(CGFloat height) {

}];

// 随时获取选择好媒体文件
[pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
for (LLImagePickerModel *model in list) {
// 在这里取到模型的数据
NSLog(@"%@",model.imageUrlString);
}
}];

// 添加到控件上
self.tableView.tableHeaderView = pickerV;
```
-------

### <a id="custom"></a>属性自定义

>demo中有些属性可能没用上，不同属性的设置可以达成不同的效果

* `type`
>需要展示的媒体的资源类型：如仅显示图片等，默认是 LLImageTypePhotoAndCamera
```
点击加号按钮，自定义所想要的媒体资源选项
pickerV.type = LLImageTypePhoto
```

* `preShowMedias`
>预先展示的媒体数组。如果一开始有需要显示媒体资源，可以先传入进行显示，没有的话可以不赋值。
传入的如果是图片类型，则可以是：UIImage，NSString，至于其他的都可以传入 LLImagePickerModel类型
包括网络图片和gif图片

```
在预览或者之前已经有图片的情况下，需要传入进行预先展示
pickerV.preShowMedias = @[@"4",@"1",@"http://s1.dwstatic.com/group1/M00/AA/B8/b9a8f39ed9c8609354a07cc38452aef9.gif"];
```

* `maxImageSelected`
>最大图片、视频选择个数，包括 `preShowMedias`的数量. default is 9
```
自定义从本地相册中所选取的最大数量
pickerV.maxImageSelected = 5;
```

* `showDelete`
>是否显示删除按钮. Defaults is YES
```
一般在预览情况下设置为 NO
pickerV.showDelete = NO;
```

* `showAddButton`
>是否需要显示添加按钮. Defaults is YES 
```
一般在预览情况下设置为 NO
pickerV.showAddButton = NO;
```

* `allowPickingVideo`
>是否允许 在选择图片的同时可以选择视频文件. default is NO
>选择的本地视频只是简单加载显示，当需要立刻播放选择的本地视频时，会有一个转码加载的过程，请等待（注意）
```
如果希望在选择图片的时候，出现视频资源，那么可以设置为 YES
pickerV.allowPickingVideo = NO;
```

* `allowMultipleSelection`
>是否允许 同个图片或视频进行多次选择. default is YES
如果设置为 NO，那么在已经选择了一张以上图片之后，就不能同时选择视频了（注意）
```
如果不希望已经选择的图片或视频，再次被选择，那么可以设置为 NO
pickerV.allowMultipleSelection = NO;
```

* `backgroundColor`
>底部collectionView的背景颜色，有特殊颜色要求的可以单独去设置


## <a id="V1.1Update"></a>V1.1更新

> 修复了将LLImagePicker 添加到Present出来的控制器的时候出现的一些bug

------

## <a id="hope"></a>Hope
* 代码使用过程中，发现任何问题，可以随时issue
* 如果有更多建议或者想法也可以直接联系我 QQ:416997919
* 本人简书地址  也可随时在简书留言[LLPhotoBrowser](http://www.jianshu.com/p/54ef9f9f17e9)
* 觉得框架对你有一点点帮助的，就请支持下，点个赞。

## Licenses
All source code is licensed under the MIT License.

