//
//  ViewController.swift
//  Alamofire使用
//
//  Created by 何晓文 on 2016/11/17.
//  Copyright © 2016年 何晓文. All rights reserved.
//

import UIKit
import SnapKit
//import SwiftyJSON
//import Alamofire
//import AlamofireSwiftyJSON
//import ObjectMapper



//class GlassResponse: Mappable {
//    var Success: String?
//    var ReList: [Glass]?
//    
//    required init?(map: Map){
//        
//    }
//    
//    func mapping(map: Map) {
//        Success <- map["Success"]
//        ReList <- map["ReList"]
//    }
//}

class Glass: NSObject {
    var ClassName: String?
    var ID: Int?
    var Pic: String?
    
//    required init?(map: Map){
//        
//    }
    
//    func mapping(map: Map) {
//        ClassName <- map["ClassName"]
//        ID <- map["ID"]
//        Pic <- map["Pic"]
//    }
}

class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    let urlString = "http://api.yp.atjubo.com/atapi/GetClassList"
    var arr = Array<Any>()
    
    let sentionTitles = ["ATS(App Transport Security)设置问题","HTTP图片发送失败","集成QQ，链接时报i386错误","分享面板很多平台没显示"]
    
    let cellTitles = ["类似HTTP图片发送失败问题，支持HTTP网络图片分享需开启NSAllowsArbitraryLoads。由于2017年1月1日开始强制应用支持HTTPS的苹果审核政策，NSAllowsArbitraryLoads的关闭也需要本地策略的变更，如以下两种： 1. 分享图片仅适用本地图片加载，如UIImage或NSData数据传输。 2. 如需使用网络图片，确保URL为HTTPS图片链接，以便于U-Share SDK下载并进行分享，否则会分享失败。",
                      
                      "iOS9以上访问HTTP链接时需加入HTTP白名单，而图片链接无法确定域名，所以建议加入NSAllowsArbitraryLoads=True参数",
                      
                      "QQ平台TencentOpenApi.framework对模拟器不支持i386 CPU架构，仅提供x86_64 CPU架构支持，可在项目Target-Build Settings-Architectures中移除i386参数。",
                      
                      "这是U-Share SDK内部处理，对于模拟器以及在设备上未安装或不支持授权/分享的平台应用进行了隐藏，以增强分享体验及解决审核App时可能被拒的问题"]
    
    let flagArray : NSMutableArray = NSMutableArray()
    let cellArray : NSMutableArray   = NSMutableArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeData()
       createTabelView()
        
//        let param:[String:Any] = ["tag":"Swift", "count":4]
//        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode:[200,201,202]).responseSwiftyJSON { (response) in
//            
//           
////            let value = JSON(response)
//             debugPrint(response.result.value?["ReList"].array!)
//            
//            
//        }
//
    }
    func createTabelView(){
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView.init()
        tableView.estimatedRowHeight = 200;
        tableView.rowHeight = UITableViewAutomaticDimension
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.separatorStyle = .none
    
    }
    //初始数据
    func makeData() -> () {
        
        for _ : NSInteger in 0...sentionTitles.count - 1 {
        flagArray.add(false)
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let identify = "cell\(indexPath.section)\(indexPath.section)"
    self.tableView.register(UINib.init(nibName: "AFQCell", bundle:Bundle.main), forCellReuseIdentifier: identify)
        let cell : AFQCell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! AFQCell
        //文字
        let content : String = cellTitles[indexPath.section]
        
        let attributeStr = NSMutableAttributedString(string: content)
        
        let paraghStyle = NSMutableParagraphStyle()
        
        paraghStyle.lineSpacing = cell.detailLabel.font.lineHeight
        
        //添加属性
        attributeStr.addAttributes([NSParagraphStyleAttributeName : paraghStyle], range:NSMakeRange(0, content.characters.count))
        cell.detailLabel.attributedText = attributeStr;
        
        cell.selectionStyle = .none
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : HeaderTitleView = HeaderTitleView()
        
        view.tag = section + 100
        
        view.spreadBtn?.isSelected = flagArray[section] as! Bool
        
        view.needSpread { (index:NSInteger, isSelect:Bool) in
            let ratio = index - 100
            
            if  self.flagArray[ratio] as! Bool{
            
            self.flagArray[ratio] = false
            } else {
            self.flagArray[ratio] = true
            
            }
            
            self.tableView.reloadSections(IndexSet.init(integer: index - 100), with: .automatic)
            
        }
        view.titleLabel?.text = sentionTitles[section]
        
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flagArray[section] as! Bool{
            return 1
        }else{
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sentionTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
 

}

