//
//  HeaderTitleView.swift
//  Alamofire使用
//
//  Created by 何晓文 on 2016/11/22.
//  Copyright © 2016年 何晓文. All rights reserved.
//

import UIKit

class HeaderTitleView: UIView {

//    @IBOutlet weak var titleLabel: UILabel!
//    
//    @IBOutlet weak var spreadBtn: UIButton!
    
    var titleLabel: UILabel?
    
    var spreadBtn: UIButton?
    var baseImg: UIImageView!
    typealias callBackBlock = (_ index:NSInteger, _ isSelect: Bool) -> ()
    
    var spreadBlock: callBackBlock!
    
    
    func needSpread(block:@escaping callBackBlock) -> () {
        self.spreadBlock = block
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        baseImg = UIImageView(image: UIImage(named: "logon_button_enter"))
//        baseImg.isUserInteractionEnabled = true
//        
//        self.addSubview(baseImg)
//        
//        baseImg.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview().offset(5)
//        }
        
        spreadBtn = UIButton(type: UIButtonType.custom)
        spreadBtn?.setBackgroundImage(UIImage(named:"icon_down"), for: .normal)
        spreadBtn?.setBackgroundImage(UIImage(named:"icon_up"), for: .selected)
        spreadBtn?.addTarget(self, action: #selector(self.spreadBtnClick), for: .touchUpInside)
        spreadBtn?.imageView?.contentMode = .center
        self.addSubview(spreadBtn!)
        spreadBtn?.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
        }
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo((spreadBtn?.snp.left)!)
            make.centerY.equalToSuperview()
        })
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
    }

   func spreadBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if let _ = spreadBlock {
            
            spreadBlock(self.tag, sender.isEnabled)
            
        }
        
    }
    

}
