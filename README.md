# Southgis iOS(OC) 移动支撑平台组件 - 常用类别组件

[![CI Status](http://img.shields.io/travis/Lee/SGSCategories.svg?style=flat)](https://travis-ci.org/Lee/SGSCategories)
[![Version](https://img.shields.io/cocoapods/v/SGSCategories.svg?style=flat)](http://cocoapods.org/pods/SGSCategories)
[![License](https://img.shields.io/cocoapods/l/SGSCategories.svg?style=flat)](http://cocoapods.org/pods/SGSCategories)
[![Platform](https://img.shields.io/cocoapods/p/SGSCategories.svg?style=flat)](http://cocoapods.org/pods/SGSCategories)

------

**SGSCategories**（OC版本）是移动支撑平台 iOS Objective-C 组件之一，该组件集成了一些常用的类别扩展，包括 `NSString` , `NSData`, `NSDate` , `UIColor` 等

## 安装
------

**SGSCategories** 可以通过 **Cocoapods** 进行安装，可以复制下面的文字到 Podfile 中：

```ruby
target '项目名称' do
pod 'SGSCategories', '~> 0.1.6'
end
```

如果自行导入需要在工程的 `General` 板块的 `Linked Frameworks and Libraries` 选项中添加 `libz.tbd`

## 代码结构
------
> * Foundation
>  - NSObject+SGS：扩展动态添加属性、使用 block 形式接收 KVO 等便捷方法
>  - NSString+SGS：扩展了字符串编码、转换、正则表达式验证等方法
>  - NSData+SGS：扩展了数据的编码、转换、便捷读取文件、解压缩等方法
>  - NSDate+SGS：扩展了日期的便捷属性获取、日期格式化、日期比较、日期增减等方法
>  - NSDateFormatter+SGS：扩展了常用日期格式的便捷获取方法
>  - NSNumber+SGS：扩展了 **NSString** 转换 **NSNumber** 的便捷方法
>  - NSArray+SGS：扩展了数组转换、读写文件操作等便捷方法
>  - NSMutableArray+SGS：扩展了可变数组的弹出、倒转、打乱顺序等便捷方法
>  - NSDictionary+SGS：扩展了字典转换、排序key等便捷方法
>  - NSMutableDictionary：扩展了可变字典的弹出元素、弹出key等便捷方法
>  - NSFileManager+SGS：扩展了文件操作的便捷方法
>  - NSUserDefaults+SGS：扩展了共享数据操作的便捷方法
>  - NSNotificationCenter+SGS：扩展了在主线程发送通知的便捷方法
>  - NSTimer+SGS：扩展了定时器使用block调用的便捷方法
>  - NSURL：扩展了创建 HTTP URL 的便捷方法
>  - NSMutableURLRequest+SGS：扩展了 HTTP 请求序列化的便捷方法
>  - NSURLSession+SGS：扩展轻量级网络请求的便捷方法
> * UIKit
>  - UIColor+SGS：扩展了颜色的便捷属性获取、十六进制生成颜色的便捷方法
>  - UIImage+SGS：扩展了图片的变形、便捷存储、高斯模糊的方法
>  - UIView+SGS：扩展了视图的便捷属性获取
>  - UIImageView+SGS：扩展了圆角图片视图的便捷获取方法
>  - UIVisualEffectView：扩展了模糊视图的便捷获取方法
> * QuartzCore
>  - CALayer+SGS：扩展核心动画的便捷方法

## 部分接口
------

由于扩展方法繁多，这里仅列出部分接口，更多接口请参考组件里各类别的头文件

### NSString+SGS

```
// 判断字符串是否包含特定字符
NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"e"];
BOOL result = [@"hello, world" containsCharacterSet:set]; // YES

// 将 JSON 对象快速转为字符串
NSString jsonStr = [NSString stringWithJSONObject:json];

// 将字符串转为 JSON 对象
NSDictionary *json = @"{\"name\":\"a\",\"age\":10}".toJSONObject;

// 返回Base-64编码的字符串
NSString *base64 = @"hello, world".base64EncodedString;

// Base-64解码
NSString originStr = [NSString stringWithBase64EncodedString:base64];

// 使用正则表达式验证字符串是否为6位数字
BOOL result = [@"abc123" validateByRegex:@"^\d{6}"]; // NO

// 使用正则表达式验证身份证号是否合法
BOOL result = @"123456".validIdentificationCard; // NO

// 使用正则表达式验证是否为中国的手机号码
BOOL result = @"13500001234".validChineseMobilePhoneNumber; // YES
```

### NSData+SGS

```
// 根据十六进制字符串生成NSData
NSData *data = [NSData dataWithHexString@"1f209a"];

// 将NSData转为十六进制字符串
NSString *hexString = data.toHexString;

// 将NSData转为UTF8编码格式的字符串
NSString *utf8String = data.toUTF8String;

// 读取指定目录的数据
NSData *data = [NSData dataWithContentsOfFile:@"/Video/a.mp4" relativeToDirectory:NSDocumentDirectory inDomain:NSUserDomainMask];

// gzip压缩
NSData *gzip = data.gzipDeflate;

// gzip解压
NSData *origin = gzip.gzipInflate;

// zlib压缩
NSData *zlib = data.zlibDeflate;

// zlib解压
NSData *origin = zlib.zlibInflate;
```

### NSDate+SGS

```
// 判断日期当月有多少天
NSUInteger numberOfDays = date.numberOfDaysInThisMonth;

// 返回明天此刻的日期
NSDate *tomorrow = [NSDate tomorrow];

// 返回当月的最后一天
NSDate *lastDay = date.lastDayInThisMonth;

// 三天后
NSDate *threeDaysLater = [[NSDate date] dateByAddingDays:3];

// 返回 yyyy-MM-dd HH:mm:ss 格式的字符串
NSString *dateString = date.stringWithISO8601FullDateAndTimeFormat;

// 返回 yyyy年M月d日 格式的字符串
NSString *dateString = date.stringWithChineseYearMonthAndDayFormat;

// 聊天中出现的时间字符串格式，例如：刚刚、xx分钟前、昨天等格式
NSString *dateString = [date stringWithCommonFormatAndShowThisYear:NO]; //如果参数为NO，今年的日期字符串格式将隐藏年份
```

### NSArray+SGS 与 NSDictionary+SGS

```
// 倒转数组
NSMutableArray *arr = @[@(1), @(2), @(3)].mutableCopy;
[arr reverse];

// 打乱数组顺序
[arr shuffle];

// 将数组转为JSON字符串
NSString *jsonStr = arr.toJSONString;

// 将字典转为JSON字符串
NSString *jsonStr = @{@"name": @"张三"}.toJSONString;

// 返回升序排序后的所有key
NSArray *sortedKeys = dict.allKeysSorted;

// 返回按key升序排序后的所有值
NSArray *sortedValues = dict.allValuesSortedByKeys;

// 判断字典是否包含key对应的值
BOOL result = [@{@"name": @"张三"} containsObjectForKey:@"name"]; // YES

```

### UIColor+SGS

```
// 根据十六进制字符串生成UIColor
UIColor *color = [UIColor colorWithHexString:@"#FF7F00"];

// 将UIColor转为十六进制（小写）的字符串
NSString *hexStr = color.rgbHexString; // #ff7f00

// 将UIColor转为十六进制数字
uint32_t rgb = color.rgbValue;

// 获取颜色值
CGFloat red   = color.redComponent;
CGFloat green = color.greenComponent;
CGFloat blue  = color.blueComponent;
CGFloat alpha = color.alphaComponent;
```

### UIImage+SGS

```
// 生成纯色的图片
UIImage *redImg = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(100, 50)];

// 生成圆形图片
UIImage *circleImg = img.circleImage;

// 生成圆角图片
UIImage *roundRectImg = [img roundRectWithCornerRadius:5];

// 左旋转90°
UIImage rotateLeftImg = img.rotateLeft90;

// 深色高斯模糊图片
UIImage *darkEffectImg = img.darkEffect;
```

## 结尾
------
**移动支撑平台** 是研发中心移动团队打造的一套移动端开发便捷技术框架。这套框架立旨于满足公司各部门不同的移动业务研发需求，实现App快速定制的研发目标，降低研发成本，缩短开发周期，达到代码的易扩展、易维护、可复用的目的，从而让开发人员更专注于产品或项目的优化与功能扩展

整体框架采用组件化方式封装，以面向服务的架构形式供开发人员使用。同时兼容 Android 和 iOS 两大移动平台，涵盖 **网络通信**, **数据持久化存储**, **数据安全**, **移动ArcGIS** 等功能模块（近期推出混合开发组件，只需采用前端的开发模式即可同时在 Android 和 iOS 两个平台运行），各模块间相互独立，开发人员可根据项目需求使用相应的组件模块

更多组件请参考：
> * [HTTP 请求模块组件](http://112.94.224.243:8081/kun.li/sgshttpmodule/tree/master)
> * [数据安全组件](http://112.94.224.243:8081/kun.li/sgscrypto/tree/master)
> * [数据持久化存储组件](http://112.94.224.243:8081/kun.li/sgsdatabase/tree/master)
> * [ArcGIS绘图组件](https://github.com/crash-wu/SGSketchLayer-OC)
> * [常用工具组件](http://112.94.224.243:8081/kun.li/sgsutilities/tree/master)
> * [集合页面视图](http://112.94.224.243:8081/kun.li/sgscollectionpageview/tree/master)
> * [二维码扫描与生成](http://112.94.224.243:8081/kun.li/sgsscanner/tree/master)

如果您对移动支撑平台有更多的意见和建议，欢迎联系我们！

研发中心移动团队

2016 年 08月 31日  

## Author
------
Lee, kun.li@southgis.com

## License
------
SGSCategories is available under the MIT license. See the LICENSE file for more info.
