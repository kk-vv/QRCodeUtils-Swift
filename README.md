# QRCodeUtils-Swift
文本转换成二维码 并修改颜色

使用方法：

生成二维码：
var image = HQRCodeUtils.createQRCodeForString("http://sk.qihulu.cn/ckkj-wechat/web/home/getHome?f=740691&promoCode=3733aa&inviteCode=3733aa", size: 200,level: HCorrectionLevel.Default)

修改颜色：
image = HQRCodeUtils.changeImageColor(image, red: 100, green: 200, blue: 125)

显示：
imageView.image = image
