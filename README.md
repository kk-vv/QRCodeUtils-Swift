#Swift-文本转换二维码

## 使用方法  
---
<br />

```
	var image = HQRCodeUtils.createQRCodeForString("http://www.baidu.com", size: 200,level: HCorrectionLevel.Default)
	image = HQRCodeUtils.changeImageColor(image, red: 100, green: 200, blue: 125)
	imageView.image = image
```
##### Tips
---

- 容错级 L,M,Q,H    
容错级越高 可存储得数据越少 识读效率越高 我也是小白，详细分析可参考[这篇文章](http://blog.csdn.net/johnsuna/article/details/8864046)


## 效果图
---
<br />
![screen shot](https://github.com/iFallen/QRCodeUtils-Swift/raw/master/ScreenShots/screenShot1.png "效果图")
