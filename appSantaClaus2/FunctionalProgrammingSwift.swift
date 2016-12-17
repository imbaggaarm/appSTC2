//
//  FunctionalProgrammingSwift.swift
//  appLayoutMP3ZING
//
//  Created by Dung Duong on 12/9/16.
//  Copyright © 2016 Tai Duong. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    public func loadImageFromURL(urlString: String)
    {
        let url: URL = URL(string: urlString)!
        do
        {
            let data: Data = try Data(contentsOf: url)
            self.image = UIImage(data: data)
        }
        catch
        {
            print("LOAD IMAGE ERROR!");
        }
        
    }
}
//extension UIView
//{
//    func addConstraintsWithFormat(format: String, views: UIView...)
//    {
//        var dic = Dictionary<String, UIView>()
//        for view in views
//        {
//            let key = "v\(views.index(of: view))"
//            view.translatesAutoresizingMaskIntoConstraints = false
//            dic[key] = view
//        }
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dic))
//    }
//}
extension UIView
{
    func addConstraintsWithFormat(format: String, views: UIView...)
    {
        var dic = Dictionary<String, UIView>()
        for (index, view) in views.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            dic[key] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dic))
    }
    
}
extension UILabel
{
    class func setLbl(backgroundColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, isClips: Bool, title: String, font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor) -> UILabel
    {
        let temp = UILabel()
        temp.backgroundColor = backgroundColor
        temp.layer.cornerRadius = cornerRadius
        temp.clipsToBounds = isClips
        temp.layer.borderColor = borderColor.cgColor
        temp.layer.borderWidth = borderWidth
        temp.text = title
        temp.font = font
        temp.textColor = textColor
        temp.textAlignment = textAlignment
        return temp
    }
}
extension UIColor
{
    class func rgb(red:CGFloat, green: CGFloat, blue: CGFloat) -> UIColor
    {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1);
    }
    class func rgba(red:CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha);
    }
}
