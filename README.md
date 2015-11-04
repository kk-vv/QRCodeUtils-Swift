#Swift-文本转换二维码

## 使用方法  
---
<br />

```
	var image = HQRCodeUtils.createQRCodeForString("http://www.baidu.com", size: 200,level: HCorrectionLevel.Default)
	image = HQRCodeUtils.changeImageColor(image, red: 100, green: 200, blue: 125)
	imageView.image = image
```

## 效果图
---
<br />
![screen shot](https://github.com/iFallen/QRCodeUtils-Swift/raw/master/ScreenShots/screenShot1.png "效果图")
