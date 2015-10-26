//
//  HQRCodeUtils.swift
//  HQRCodeUtils
//
//  Created by JuanFelix on 10/26/15.
//  Copyright © 2015 SKKJ-JuanFelix. All rights reserved.
//

import UIKit

enum HCorrectionLevel{
    case Default, L, M, Q,H
    func stringValue() ->String{
        switch self {
        case .L:
            return "L"
        case .M:
            return "M"
        case .Q:
            return "Q"
        case .H:
            return "H"
        case .Default:
            return "M"
        }
    }
}

class HQRCodeUtils: NSObject {
    
    class func createNonInterpolatedUIImageFromCIImage(image: CIImage, size:CGFloat) -> UIImage{
        let extent = CGRectIntegral(image.extent)
        let scale = min(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent))
        let width = (size_t)(CGRectGetWidth(extent) * scale)
        let height = (size_t)(CGRectGetHeight(extent) * scale)
        let cs = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, CGImageAlphaInfo.None.rawValue)
        
        let context = CIContext.init(options: nil)
        let bitmapImage = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef, CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale)
        CGContextDrawImage(bitmapRef, extent, bitmapImage)
        
        let  scaledImage = CGBitmapContextCreateImage(bitmapRef)
        return UIImage(CGImage: scaledImage!)
    }
    
    static func createQRCodeForString(qrString:String, size:CGFloat,level:HCorrectionLevel) -> UIImage{
        let stringData = qrString.dataUsingEncoding(NSUTF8StringEncoding)
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue(level.stringValue(), forKey: "inputCorrectionLevel")//容错级 L,M,Q,H    容错级越高 可存储得数据越少 识读效率越高 我也是小白，详细分析可参考这篇文章 http://blog.csdn.net/johnsuna/article/details/8864046
        return self.createNonInterpolatedUIImageFromCIImage((qrFilter?.outputImage)!, size: size)
    }
    
    static func changeImageColor(image:UIImage, red:CGFloat, green:CGFloat, blue:CGFloat) -> UIImage{
        let imageWidth  = image.size.width
        let imageHeight = image.size.height
        let bytesPerRow = imageWidth * 4
        let rgbImageBuf = malloc((size_t)(bytesPerRow * imageHeight))
        
        //
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrder32Little.rawValue | CGImageAlphaInfo.NoneSkipLast.rawValue)
        let context = CGBitmapContextCreate(rgbImageBuf, (Int)(imageWidth), (Int)(imageHeight), 8, (Int)(bytesPerRow), colorSpace, bitmapInfo.rawValue)
        CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage)
        let pixelNum = imageWidth * imageHeight
        var pCurPtr = UnsafeMutablePointer<UInt32>(rgbImageBuf)
        
        for(var i = 0; i < (Int)(pixelNum); i++,pCurPtr++){
            if ((pCurPtr.memory & 0xFFFFFF00) < 0x99999900){
                // change color
                let ptr = (UnsafeMutablePointer<UInt8>)(pCurPtr)
                ptr[3] = UInt8(red) //0~255
                ptr[2] = UInt8(green)
                ptr[1] = UInt8(blue)
            }else{
                let ptr = UnsafeMutablePointer<UInt8>(pCurPtr)
                ptr[0] = 0;
            }
        }
        
        let dataProvider = CGDataProviderCreateWithData(nil, rgbImageBuf,  Int(bytesPerRow * imageHeight), nil)
        let imageRef = CGImageCreate(Int(imageWidth), Int(imageHeight), 8, 32, Int(bytesPerRow), colorSpace, bitmapInfo, dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
        let resultImage = UIImage(CGImage: imageRef!)
        
        return resultImage
    }
}
