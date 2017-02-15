//
//  WTKHomeTableViewCell.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/8.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKHomeTableViewCell: UITableViewCell {
    
    var bgImageView = UIImageView()
    var titleLabel = UILabel()
    var starBgView : UIButton!
    var starImageView = UIImageView()
    var starTitleLabel = UILabel()
    
    
    var model : WTKHomeModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = WTKColor(r: 239, g: 239, b: 243, a: 1)
        initView()
    }
    
    
    func updateWithModel(model : WTKHomeModel) {
        self.model = model
        bgImageView.sd_setImage(with: URL.init(string: model.cover_image_url), placeholderImage: UIImage.init(named: "placehoder1"))
        titleLabel.text = model.title
        
//        计算star宽度
        if starTitleLabel.text?.characters.count != model.likes_count.characters.count {
            let width = WTKTools.calculateStringWidth(text: model.likes_count, stringFont: 12)
            starBgView.snp.remakeConstraints({ [unowned self] (make) in
                make.top.equalTo(self).offset(10 * kScaleWidth)
                make.right.equalTo(self).offset(-10 * kScaleWidth)
                make.width.equalTo(40 * kScaleWidth + width)
                make.height.equalTo(30 * kScaleWidth)
            })
        }
        starTitleLabel.text = model.likes_count
        if model.liked == "0" {
            starImageView.image = UIImage.init(named: "w_heart1N")
            starBgView.isSelected = false
        } else {
            starImageView.image = UIImage.init(named: "w_heart1")
            starBgView.isSelected = true
        }
        
    }
    
    func starBtnClick(sender : UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            starImageView.image = UIImage.init(named: "w_heart1")
            self.model.liked = "1"
        } else {
            starImageView.image = UIImage.init(named: "w_heart1N")
            self.model.liked = "0"
        }
        
    }
    
    // initView
    func initView() {
        self.addSubview(bgImageView)
        bgImageView.layer.cornerRadius = 4
        bgImageView.layer.masksToBounds = true
        bgImageView.snp.makeConstraints { [unowned self](make) in
            make.center.equalTo(self)
            make.edges.equalTo(self).inset(UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        self.addSubview(titleLabel)
        titleLabel.font = wSystemFont(size: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.snp.makeConstraints { [unowned self] (make) in
            make.bottom.equalTo(self).offset(-2)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(40 * kScaleWidth)
        }
        
        starBgView = UIButton.init(type: .custom)
        starBgView.backgroundColor = WTKColor(r: 70, g: 70, b: 70, a: 0.7)
        starBgView.addTarget(self, action: #selector(WTKHomeTableViewCell.starBtnClick(sender:)), for: .touchUpInside)
        self.addSubview(starBgView)
        starBgView.layer.cornerRadius = 15 * kScaleWidth
        starBgView.layer.masksToBounds = true
        starBgView.snp.makeConstraints { [unowned self] (make) in
            make.top.equalTo(self).offset(10 * kScaleWidth)
            make.right.equalTo(self).offset(-10 * kScaleWidth)
            make.width.equalTo(60 * kScaleWidth)
            make.height.equalTo(30 * kScaleWidth)
        }
        
        starImageView.image = UIImage.init(named: "w_heart1N")
        starBgView.addSubview(starImageView)
        starImageView.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(self.starBgView).offset(5)
            make.centerY.equalTo(self.starBgView)
            make.width.equalTo(20 * kScaleWidth)
            make.height.equalTo(20 * kScaleWidth)
        }
        
        starTitleLabel.font = wSystemFont(size: 12)
        starTitleLabel.text = ""
        starTitleLabel.textColor = UIColor.white
        starTitleLabel.textAlignment = .center
        starBgView.addSubview(starTitleLabel)
        starTitleLabel.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(self.starImageView.snp.right).offset(5)
            make.centerY.equalTo(self.starImageView)
            make.height.equalTo(self.starImageView)
            make.right.equalTo(self.starBgView.snp.right).offset(-5)
        }
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
