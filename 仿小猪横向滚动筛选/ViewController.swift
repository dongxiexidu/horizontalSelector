//
//  ViewController.swift
//  仿小猪横向滚动筛选
//
//  Created by lidongxi on 17/1/1.
//  Copyright © 2017年 lidongxi. All rights reserved.
//

import UIKit

let numberRow = 7
let screenWidth = UIScreen.main.bounds.width
var circleLabel = UILabel()
var titleScrollView = UIScrollView()

class ViewController: UIViewController {

    @IBOutlet weak var inNumberView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let titleArr = ["1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限","1","2","3","4","5","6","7","8","9","10","不限"];
        
        
        let labelWidth =  screenWidth/CGFloat(numberRow);
        titleScrollView = UIScrollView.init(frame: CGRect(x:0, y:0, width:screenWidth,height: 85))
        
        titleScrollView.contentOffset = CGPoint(x:CGFloat((titleArr.count+1)/2) * labelWidth - 10*labelWidth, y:0);
        self.inNumberView.addSubview(titleScrollView)
        titleScrollView.delegate = self;
        titleScrollView.showsHorizontalScrollIndicator = false;
        titleScrollView.contentSize = CGSize(width:CGFloat(titleArr.count)*labelWidth, height:0);

        circleLabel = UILabel.init(frame: CGRect(x:screenWidth/2-labelWidth/2,y:85/2-labelWidth/2,width:labelWidth,height:labelWidth))
        self.inNumberView.addSubview(circleLabel);
        circleLabel.layer.cornerRadius = labelWidth/2;
        circleLabel.layer.borderColor = UIColor.red.cgColor;
        circleLabel.backgroundColor = UIColor.white;
        circleLabel.text = "不限";
        circleLabel.textColor = UIColor.red;
        circleLabel.textAlignment = NSTextAlignment.center;
        circleLabel.layer.borderWidth = 1;
        circleLabel.font = UIFont.systemFont(ofSize: 13);
        
        for i in 0..<titleArr.count {
            let label = UILabel.init(frame: CGRect(x:CGFloat(i)*labelWidth, y:0, width:labelWidth, height:85))
            titleScrollView.addSubview(label)
            label.tag = i+100
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = NSTextAlignment.center
            label.text = titleArr[i]
        }

    }
}


extension ViewController : UIScrollViewDelegate{
    
    fileprivate func snapToNearestItem(){
    let pageSize = screenWidth/CGFloat(numberRow)
    let targetOffset =  self .nearestTargetOffsetForOffset(offset: titleScrollView.contentOffset)
    titleScrollView.setContentOffset(targetOffset, animated: true)
    let label = titleScrollView.viewWithTag(3+Int(targetOffset.x/pageSize)+100) as! UILabel
    circleLabel.text = label.text;
    circleLabel.textAlignment = NSTextAlignment.center;
    circleLabel.font = UIFont.systemFont(ofSize: 13);
    circleLabel.textColor = UIColor.red;
    circleLabel.backgroundColor = UIColor.white;
    }
    
    fileprivate func nearestTargetOffsetForOffset(offset:CGPoint) -> CGPoint{
        
        let pageSize = screenWidth/CGFloat(numberRow)
        let point = offset.x/pageSize
        let page = roundf(Float(point))
        let targetX = pageSize * CGFloat(page);
        return CGPoint(x:targetX,y:0);
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        circleLabel.textColor = UIColor.clear
        circleLabel.backgroundColor = UIColor.clear
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.snapToNearestItem()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.snapToNearestItem()
        }
    }
}
