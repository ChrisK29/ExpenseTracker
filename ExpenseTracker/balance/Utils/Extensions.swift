//
//  Extensions.swift
//  balance
//
//  Created by admin on 9/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomImageView : UIImageView{
    
    private var completion : (()->())? = nil
    
    func onTap(completion: @escaping ()->()){
        self.completion = completion
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! CustomImageView
        tappedImage.completion?()
    }
    
    @IBInspectable var rotateAngle : Bool{
        get{
            return self.rotateAngle
        }set{
            if(newValue){
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
        }
    }
}

@IBDesignable class CustomLabel : UILabel{
    
    private var completion : (()->())? = nil
    var isSelect : Bool = false
    
    func onTap(completion: @escaping ()->()){
        
        self.completion = completion
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! CustomLabel
        tappedImage.completion?()
    }
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
