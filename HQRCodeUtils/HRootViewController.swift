//
//  HRootViewController.swift
//  HQRCodeUtils
//
//  Created by JuanFelix on 10/26/15.
//  Copyright © 2015 SKKJ-JuanFelix. All rights reserved.
//

import UIKit

class HRootViewController: UIViewController {
    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        var image = HQRCodeUtils.createQRCodeForString("http://sk.qihulu.cn/ckkj-wechat/web/home/getHome?f=740691&promoCode=3733aa&inviteCode=3733aa", size: 200,level: HCorrectionLevel.Default)
        image = HQRCodeUtils.changeImageColor(image, red: 100, green: 200, blue: 125)
        imageView.image = image
        imageView.center = self.view.center
        
        self.view.addSubview(imageView)
        
        //
        let segMenu = UISegmentedControl(items: ["L","M","Q","H"])
        segMenu.frame = CGRectMake(0, 0, 200, 30)
        segMenu.center = CGPointMake(CGRectGetMidX(self.view.frame), imageView.center.y + 120)
        segMenu.selectedSegmentIndex = 1
        segMenu.tintColor = UIColor(red: 100 / 255.0, green: 200 / 255.0, blue: 125 / 255.0, alpha: 1.0)
        segMenu.addTarget(self, action: "segmentMenuChangeAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segMenu)
    }

    func segmentMenuChangeAction(seg:UISegmentedControl){
        var levelType = HCorrectionLevel.Default
        switch seg.selectedSegmentIndex{
            case 0:
                levelType = HCorrectionLevel.L
            case 1:
                levelType = HCorrectionLevel.M
            case 2:
                levelType = HCorrectionLevel.Q
            case 3:
                levelType = HCorrectionLevel.H
            default:
                levelType = HCorrectionLevel.Default
        }
        
        var image = HQRCodeUtils.createQRCodeForString("http://sk.qihulu.cn/ckkj-wechat/web/home/getHome?f=740691&promoCode=3733aa&inviteCode=3733aa", size: 200,level: levelType)
        image = HQRCodeUtils.changeImageColor(image, red: 100, green: 200, blue: 125)
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
