//
//  ViewController.swift
//  appSantaClaus
//
//  Created by Dung Duong on 12/9/16.
//  Copyright © 2016 Tai Duong. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController: UIViewController, GADInterstitialDelegate, GADBannerViewDelegate {
    
    let userDefault = UserDefaults()
    let heightOfScreen = UIScreen.main.bounds.size.height
    let widthOfScreen = UIScreen.main.bounds.size.width
    
    let viewRecognizerTapGesture  = UIView()
    
    var bottomAnchorOfSantaClaus = NSLayoutConstraint()
    var timerHandleSantaClausDeath = Timer()
    var timerHandleDeadWhenImpacted = Timer()
    var timerHandleJumpDown = Timer()
    var timerHandleJumpUp = Timer()
    var timerHandleMovingColAndSnowBall = Timer()
    var timerHandleRunSantaClaus = Timer()
    var timerGetScore = Timer()
    var timerHandleCheckForLose = Timer()
    var timerLetJumpDown = Timer()
    var timerPrepareForJumpDown = Timer()
    var timerTimeOfJumpUp = Timer()
    var timeOfJumpUp: Double = 0
    
    
    var snowBallLeftAnchor = NSLayoutConstraint()
    var snowBallYAnchor = NSLayoutConstraint()
    
    var snowBallLeftAnchor1 = NSLayoutConstraint()
    var snowBallYAnchor1 = NSLayoutConstraint()
    
    var snowBallLeftAnchor2 = NSLayoutConstraint()
    var snowBallYAnchor2 = NSLayoutConstraint()
    
    var isJumpUp = false
    var isJumpDown = false
    var isClickedGetShieldButton = false
    
    var isClickedUpgrateShieldButton = false
    var isSilverShield = false
    var isGoldShield = false
    
    var numberOfShield = 1
    
    let butPause: UIButton = {
        let temp = UIButton(type: .system)
        //temp.imageView?.image = UIImage.init(named: "butPause")
        //temp.imageView?.contentMode = .scaleAspectFill
        temp.setBackgroundImage(UIImage.init(named: "butPause"), for: .normal)
        temp.backgroundColor = .clear
        return temp
    }()
    
    let vShowWhenPause: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.clear
        temp.isHidden = true
        return temp
        
    }()
    
    let butContinue: UIButton =
        {
            let temp = UIButton(type: .custom)
            temp.setImage(UIImage.init(named: "butContinue"), for: .normal)
            temp.imageView?.contentMode = .scaleAspectFit
            //temp.setTitle("Continue", for: .normal)
            return temp
        }()
    
    let butReadMeForPause: UIButton =
        {
            let temp = UIButton(type: .system)
            temp.setBackgroundImage(UIImage.init(named: "butReadMe"), for: .normal)
            //temp.imageView?.contentMode = .scaleAspectFit
            temp.translatesAutoresizingMaskIntoConstraints = false
            //temp.setTitle("Continue", for: .normal)
            return temp
    }()

    let butGetShieldForPause: UIButton =
        {
            let temp = UIButton(type: .system)
            temp.setBackgroundImage(UIImage.init(named: "butGetShieldOn"), for: .normal)
            //temp.imageView?.contentMode = .scaleAspectFit
            temp.translatesAutoresizingMaskIntoConstraints = false
            //temp.setTitle("Continue", for: .normal)
            return temp
    }()
    let butReadMeForResult: UIButton =
        {
            let temp = UIButton(type: .system)
            temp.setBackgroundImage(UIImage.init(named: "butReadMe"), for: .normal)
            //temp.imageView?.contentMode = .scaleAspectFit
            temp.translatesAutoresizingMaskIntoConstraints = false
            //temp.setTitle("Continue", for: .normal)
            return temp
    }()
    
    let butUpgradeForResult: UIButton =
        {
            let temp = UIButton(type: .system)
            temp.setBackgroundImage(UIImage.init(named: "butUpgradeSilverShield"), for: .normal)
            //temp.imageView?.contentMode = .scaleAspectFit
            temp.translatesAutoresizingMaskIntoConstraints = false
            //temp.setTitle("Continue", for: .normal)
            return temp
    }()
    
    
    let imgVCup: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .clear
        //temp.image = UIImage.init(named: "goldCup")
        temp.contentMode = .scaleAspectFit
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()

    let snowBall: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .clear
        temp.image = UIImage.init(named: "snowBall")
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    let snowBall1: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .clear
        temp.image = UIImage.init(named: "snowBall")
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    let snowBall2: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .clear
        temp.image = UIImage.init(named: "snowBall")
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    let vColBottom: UIView = {
            let temp = UIView()
            temp.backgroundColor = #colorLiteral(red: 0.7349527478, green: 0.1905075312, blue: 0.153483361, alpha: 1)
            temp.translatesAutoresizingMaskIntoConstraints = false
            let imgVTemp = UIImageView()
            imgVTemp.image = UIImage.init(named: "snowView")
            imgVTemp.contentMode = .scaleAspectFill
            imgVTemp.translatesAutoresizingMaskIntoConstraints = false
            imgVTemp.backgroundColor = .clear
            temp.addSubview(imgVTemp)
            temp.addConstraintsWithFormat(format: "V:|-(-20)-[v0(\(55/375*UIScreen.main.bounds.size.height))]", views: imgVTemp)
            temp.addConstraintsWithFormat(format: "H:|[v0]|", views: imgVTemp)
            return temp
    }()
    var heightAnchorOfVColumn = NSLayoutConstraint()
    var leftAnchorOfVColumn = NSLayoutConstraint()
    var bottomAnchorOfVColumn = NSLayoutConstraint()
    
    let lblScore: UILabel = {
        let temp = UILabel.setLbl(backgroundColor: .clear, cornerRadius: 0, borderWidth: 3, borderColor: .clear, isClips: true, title: "0", font: UIFont.init(name: "Carnetdevoyage", size: 40)!, textAlignment: .center, textColor: .white)
        return temp
    }()
    let SantaClaus: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .black
        temp.contentMode = .scaleAspectFill
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    
    let vSnowGround: UIView = {
        let temp = UIView()
        temp.backgroundColor = #colorLiteral(red: 0.2775979312, green: 0.6410215736, blue: 0.2576972957, alpha: 1)
        return temp
    }()
    let imgMenu = UIImageView()
    
    
    let imgTxtScore: UIImageView =
        {
            let temp = UIImageView()
            temp.image = UIImage.init(named: "txtScore")
            temp.contentMode = .scaleToFill
            temp.translatesAutoresizingMaskIntoConstraints = false
            return temp
    }()
    
    let imgTxtBestScore: UIImageView =
        {
            let temp = UIImageView()
            temp.image = UIImage.init(named: "txtScore")
            temp.contentMode = .scaleToFill
            temp.translatesAutoresizingMaskIntoConstraints = false
            return temp

    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adMobInterstitialAd = loadAdMobInterstitialAd()
        SantaClaus.image = UIImage.init(named: "jumpDown")
        addSubViews()
        setUpSantaClaus()
        setUpColumn()
        setUpVResult()
        let menu = UIImage.init(named: "menuImg")
        imgMenu.image = menu
        imgMenu.contentMode = .scaleAspectFill
        view.addSubview(imgMenu)
        view.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: imgMenu)
        let heightAfterAFit = (menu?.size.height)! * (widthOfScreen - 200) / (menu?.size.width)!
        imgMenu.heightAnchor.constraint(equalToConstant: heightAfterAFit).isActive = true
        imgMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48/375*heightOfScreen).isActive = true
        
        // load banner
        loadAllBannersViews()
        
        
    }
    func loadAllBannersViews()
    {
        loadBannerView(with: bannerView)
        loadBannerView(with: bannerView2)
    }
    func handleHiddenAllBanners()
    {
        bannerView.isHidden = true
        bannerView2.isHidden = true
    }
    func handleUnHiddenAllBanners()
    {
        bannerView.isHidden = false
        bannerView2.isHidden = false
    }

    func loadBannerView(with bannerView: GADBannerView)
    {
        bannerView.rootViewController = self
        bannerView.adUnitID = "ca-app-pub-5636400042166583/7935684953"
        bannerView.load(GADRequest())
        
    }
    let lblScoreWhenLose: UILabel =
        {
        let temp = UILabel()
        temp.text = "0"
        temp.textColor = .white
        temp.font = UIFont.init(name: "Carnetdevoyage", size: 40)
        temp.textAlignment = .center
        temp.adjustsFontSizeToFitWidth = true
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
        }()
    let lblBestScore: UILabel =
        {
            let temp = UILabel()
            temp.text = "0"
            temp.textColor = .white
            temp.font = UIFont.init(name: "Carnetdevoyage", size: 40)
            temp.textAlignment = .center
            temp.adjustsFontSizeToFitWidth = true
            temp.translatesAutoresizingMaskIntoConstraints = false
            return temp
    }()

    func setUpVResult()
    {
        view.addSubview(vResult)
        vResult.isHidden = true
        
        vResult.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 3/4).isActive = true
        vResult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        vResult.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        let imgTemp = UIImage.init(named: "resultMenu")
        let imgV = UIImageView()
        imgV.image = imgTemp
        imgV.contentMode = .scaleAspectFill
        let widthOfImage = (imgTemp?.size.width)!*(heightOfScreen*3/4)/(imgTemp?.size.height)!
        vResult.widthAnchor.constraint(equalToConstant: widthOfImage).isActive = true
        vResult.addSubview(imgV)
        vResult.addConstraintsWithFormat(format: "V:|[v0]|", views: imgV)
        vResult.addConstraintsWithFormat(format: "H:|[v0]|", views: imgV)
        vResult.addSubview(butReplay)
        butReplay.translatesAutoresizingMaskIntoConstraints = false
        vResult.addConstraint(NSLayoutConstraint.init(item: butReplay, attribute: .centerX, relatedBy: .equal, toItem: vResult, attribute: .centerX, multiplier: 1, constant: 0))
        butReplay.heightAnchor.constraint(equalToConstant: 60/375*heightOfScreen).isActive = true
        butReplay.widthAnchor.constraint(equalTo: butReplay.heightAnchor, multiplier: 1).isActive = true
        vResult.addConstraint(NSLayoutConstraint.init(item: butReplay, attribute: .centerY, relatedBy: .equal, toItem: vResult, attribute: .centerY, multiplier: 1.2, constant: 0))
        vResult.addSubview(butReadMeForResult)
        vResult.addSubview(butUpgradeForResult)
        butReadMeForResult.heightAnchor.constraint(equalTo: butContinue.heightAnchor, constant: 0).isActive = true
        butUpgradeForResult.heightAnchor.constraint(equalTo: butContinue.heightAnchor, constant: 0).isActive = true
        butReadMeForResult.widthAnchor.constraint(equalToConstant: widthOfImage/3.5).isActive = true
        butUpgradeForResult.widthAnchor.constraint(equalTo: butReadMeForResult.widthAnchor, constant: 0).isActive = true
        vResult.addConstraint(NSLayoutConstraint.init(item: butUpgradeForResult, attribute: .centerX, relatedBy: .equal, toItem: vResult, attribute: .centerX, multiplier: 1.45, constant: 0))
        vResult.addConstraint(NSLayoutConstraint.init(item: butReadMeForResult, attribute: .centerX, relatedBy: .equal, toItem: vResult, attribute: .centerX, multiplier: 0.55, constant: 0))
        vResult.addConstraint(NSLayoutConstraint.init(item: butReadMeForResult, attribute: .centerY, relatedBy: .equal, toItem: vResult, attribute: .centerY, multiplier: 1.55, constant: 0))
        butUpgradeForResult.centerYAnchor.constraint(equalTo: butReadMeForResult.centerYAnchor, constant: 0).isActive = true
        
        butUpgradeForResult.addTarget(self, action: #selector(handlePresentInterstitialAd(sender: )), for: .touchUpInside)
        butReadMeForResult.addTarget(self, action: #selector(handleShowReadMe), for: .touchUpInside)
        
        
        vResult.addSubview(imgVCup)
        imgVCup.heightAnchor.constraint(equalToConstant: 50/375*heightOfScreen).isActive = true
        imgVCup.widthAnchor.constraint(equalTo: imgVCup.heightAnchor, multiplier: 1).isActive = true
        imgVCup.topAnchor.constraint(equalTo: vResult.topAnchor, constant: 3).isActive = true
        vResult.addConstraint(NSLayoutConstraint.init(item: imgVCup, attribute: .centerX, relatedBy: .equal, toItem: vResult, attribute: .centerX, multiplier: 1, constant: 0))
        
        vResult.addSubview(imgTxtScore)
        vResult.addSubview(imgTxtBestScore)
        imgTxtScore.centerYAnchor.constraint(equalTo: imgTxtBestScore.centerYAnchor, constant: 0).isActive = true
        imgTxtScore.rightAnchor.constraint(equalTo: butReadMeForResult.rightAnchor, constant: 0).isActive = true
        imgTxtBestScore.leftAnchor.constraint(equalTo: butUpgradeForResult.leftAnchor, constant: 0).isActive = true
        imgTxtScore.widthAnchor.constraint(equalTo: imgTxtBestScore.widthAnchor, constant: 0).isActive = true
        imgTxtBestScore.widthAnchor.constraint(equalTo: butReadMeForResult.widthAnchor, constant: 0).isActive = true
        imgTxtScore.heightAnchor.constraint(equalTo: butReadMeForResult.heightAnchor, constant: 0).isActive = true
        imgTxtBestScore.heightAnchor.constraint(equalTo: butReadMeForResult.heightAnchor, constant: 0).isActive = true
        imgTxtScore.bottomAnchor.constraint(equalTo: butReplay.topAnchor, constant: -7.5).isActive = true
        
        
        
        vResult.addSubview(lblScoreWhenLose)
        lblScoreWhenLose.centerXAnchor.constraint(equalTo: imgTxtScore.centerXAnchor, constant: 0).isActive = true
        lblScoreWhenLose.centerYAnchor.constraint(equalTo: imgTxtScore.centerYAnchor, constant: 0).isActive = true
        lblScoreWhenLose.widthAnchor.constraint(equalTo: imgTxtScore.widthAnchor, multiplier: 0.85).isActive = true
        lblScoreWhenLose.heightAnchor.constraint(equalTo: imgTxtScore.heightAnchor, multiplier: 0.75).isActive = true
        
        vResult.addSubview(lblBestScore)
        lblBestScore.centerXAnchor.constraint(equalTo: imgTxtBestScore.centerXAnchor, constant: 0).isActive = true
        lblBestScore.centerYAnchor.constraint(equalTo: imgTxtBestScore.centerYAnchor, constant: 0).isActive = true
        //lblBestScore.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        lblBestScore.widthAnchor.constraint(equalTo: imgTxtBestScore.widthAnchor, multiplier: 0.85).isActive = true
        lblBestScore.heightAnchor.constraint(equalTo: imgTxtBestScore.heightAnchor, multiplier: 0.75).isActive = true
        //vResult.addConstraintsWithFormat(format: "V:[v0(50)]-20-[v1]-30-|", views: lblScoreWhenLose, butReplay)
        //lblScoreWhenLose.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        //lblScoreWhenLose.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        vResult.backgroundColor = .clear

    }
    
    let kRotationAnimationKey = "com.myapplication.rotationanimationkey" // Any key
    
    func rotateView(view: UIView, duration: Double = 1)
    {
        if view.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(M_PI * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
    func setUpColumn()
    {
        bottomAnchorOfVColumn = vColBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomAnchorOfVColumn.isActive = true
        vColBottom.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 70/667).isActive = true
        heightAnchorOfVColumn = vColBottom.heightAnchor.constraint(equalToConstant: 53/375*heightOfScreen)
        heightAnchorOfVColumn.isActive = true
        leftAnchorOfVColumn = vColBottom.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 70/667*view.frame.size.width + 10)
        leftAnchorOfVColumn.isActive = true
    }
    let imgVBackGround: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage.init(named: "BG")
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    let imgVSnowGround: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage.init(named: "2")
        temp.contentMode = .scaleToFill
        return temp
    }()

    let butShield1: UIButton =
    {
        let temp = UIButton(type: .custom)
        temp.setImage(UIImage.init(named: "imgBronzeShield"), for: .normal)
        temp.imageView?.contentMode = .scaleAspectFit
        temp.backgroundColor = .clear
        return temp
    }()
    let butShield2: UIButton =
        {
            let temp = UIButton(type: .custom)
            temp.setImage(UIImage.init(named: "imgBronzeShield"), for: .normal)
            temp.imageView?.contentMode = .scaleAspectFit
            temp.backgroundColor = .clear
            temp.isHidden = true
            return temp
    }()
    let butShield3: UIButton =
        {
            let temp = UIButton(type: .custom)
            temp.setImage(UIImage.init(named: "imgBronzeShield"), for: .normal)
            temp.imageView?.contentMode = .scaleAspectFit
            temp.backgroundColor = .clear
            temp.isHidden = true
            return temp
    }()

    
    let bannerView: GADBannerView = {
        let temp = GADBannerView()
        temp.backgroundColor = .clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.heightAnchor.constraint(equalToConstant: 50).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 320).isActive = true
        //let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(regconizeUserClickIntoAds(tap:)))
        //temp.addGestureRecognizer(tapGesture)
        return temp
    }()
    
//    func regconizeUserClickIntoAds(tap: UITapGestureRecognizer)
//    {
//        print("tap adds")
//    }
    let bannerView2: GADBannerView = {
        let temp = GADBannerView()
        temp.backgroundColor = .clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.heightAnchor.constraint(equalToConstant: 50).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 320).isActive = true
        return temp
    }()

    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("click")
    }
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("click Banner")
    }
    func addSubViews()
    {
        

        viewRecognizerTapGesture.backgroundColor = .clear
        viewRecognizerTapGesture.isUserInteractionEnabled = true
        viewRecognizerTapGesture.isMultipleTouchEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(tapGesture:)))
        viewRecognizerTapGesture.addGestureRecognizer(tapGesture)
        
        view.addSubview(imgVBackGround)
        view.addSubview(vColBottom)
        view.addSubview(SantaClaus)
        view.addSubview(vSnowGround)
        
        vSnowGround.addSubview(imgVSnowGround)
        self.view.addSubview(lblScore)
        view.addSubview(snowBall)
        view.addSubview(snowBall1)
        view.addSubview(snowBall2)
        
        view.addSubview(viewRecognizerTapGesture)
        view.addConstraintsWithFormat(format: "V:|-30-[v0(35)]", views: lblScore)
        lblScore.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lblScore.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        // but pause
        view.addSubview(butPause)
        butPause.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        butPause.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint.init(item: butPause, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 0.1, constant: 0))
        view.addConstraint(NSLayoutConstraint.init(item: butPause, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.15, constant: 0))
        butPause.widthAnchor.constraint(equalToConstant: 40/375*heightOfScreen).isActive = true
        butPause.heightAnchor.constraint(equalTo: butPause.widthAnchor, multiplier: 1).isActive = true
        

        // v how when pause
        view.addSubview(vShowWhenPause)
        let imgVTemp = UIImageView()
        let imgTemp = UIImage.init(named: "pauseMenu")
        let widthOfImage = (imgTemp?.size.width)!*(heightOfScreen*3/4)/(imgTemp?.size.height)!
        imgVTemp.image = imgTemp
        imgVTemp.backgroundColor = .clear
        imgVTemp.contentMode = .scaleAspectFill
        vShowWhenPause.addSubview(imgVTemp)
        vShowWhenPause.translatesAutoresizingMaskIntoConstraints = false
        vShowWhenPause.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        vShowWhenPause.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        vShowWhenPause.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/4).isActive = true
        vShowWhenPause.widthAnchor.constraint(equalToConstant: widthOfImage).isActive = true
        
        vShowWhenPause.addConstraintsWithFormat(format: "V:|[v0]|", views: imgVTemp)
        vShowWhenPause.addConstraintsWithFormat(format: "H:|[v0]|", views: imgVTemp)
        
        butContinue.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        //butContinue.setTitle("Continue", for: .normal)
        vShowWhenPause.addSubview(butContinue)
        vShowWhenPause.addConstraintsWithFormat(format: "H:[v0(\((60/667)*widthOfScreen))]", views: butContinue)
        butContinue.heightAnchor.constraint(equalTo: butContinue.widthAnchor, multiplier: 1).isActive = true
        vShowWhenPause.addConstraint(NSLayoutConstraint.init(item: butContinue, attribute: .centerY, relatedBy: .equal, toItem: vShowWhenPause, attribute: .centerY, multiplier: 0.8, constant: 0))

        //butContinue.bottomAnchor.constraint(equalTo: vShowWhenPause.bottomAnchor, constant: -20).isActive = true
        vShowWhenPause.addConstraint(NSLayoutConstraint.init(item: butContinue, attribute: .centerX, relatedBy: .equal, toItem: vShowWhenPause, attribute: .centerX, multiplier: 1, constant: 0))
        vShowWhenPause.addSubview(butReadMeForPause)
        vShowWhenPause.addSubview(butGetShieldForPause)
        butReadMeForPause.heightAnchor.constraint(equalTo: butContinue.heightAnchor, constant: 0).isActive = true
        
        butReadMeForPause.addTarget(self, action: #selector(handleShowReadMe), for: .touchUpInside)
        butGetShieldForPause.addTarget(self, action: #selector(handlePresentInterstitialAd(sender: )), for: .touchUpInside)
       
        butGetShieldForPause.heightAnchor.constraint(equalTo: butContinue.heightAnchor, constant: 0).isActive = true
        butReadMeForPause.widthAnchor.constraint(equalToConstant: widthOfImage/3.5).isActive = true
        butGetShieldForPause.widthAnchor.constraint(equalTo: butReadMeForPause.widthAnchor, constant: 0).isActive = true
        vShowWhenPause.addConstraint(NSLayoutConstraint.init(item: butGetShieldForPause, attribute: .centerX, relatedBy: .equal, toItem: vShowWhenPause, attribute: .centerX, multiplier: 1.3, constant: 0))
        vShowWhenPause.addConstraint(NSLayoutConstraint.init(item: butReadMeForPause, attribute: .centerX, relatedBy: .equal, toItem: vShowWhenPause, attribute: .centerX, multiplier: 0.7, constant: 0))
        butGetShieldForPause.centerYAnchor.constraint(equalTo: butReadMeForPause.centerYAnchor, constant: 0).isActive = true
        vShowWhenPause.addConstraint(NSLayoutConstraint.init(item: butReadMeForPause, attribute: .centerY, relatedBy: .equal, toItem: vShowWhenPause, attribute: .centerY, multiplier: 1.4, constant: 0))
        
        
        
        // but Shield
        view.addSubview(butShield1)
        //view.addConstraintsWithFormat(format: "V:|-30-[v0(40)]", views: butShield)
        //view.addConstraintsWithFormat(format: "H:[v0(40)]-10-|", views: butShield)
        butShield1.translatesAutoresizingMaskIntoConstraints = false
        butShield1.topAnchor.constraint(equalTo: butPause.topAnchor, constant: 0).isActive = true
        butShield1.heightAnchor.constraint(equalTo: butPause.heightAnchor, multiplier: 1).isActive = true
        butShield1.widthAnchor.constraint(equalTo: butPause.widthAnchor, multiplier: 1).isActive = true
        //butShield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: <#T##CGFloat#>)
        view.addConstraint(NSLayoutConstraint.init(item: butShield1, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.9, constant: 0))
        butShield1.layer.cornerRadius = 15
        butShield1.clipsToBounds = true
        butShield1.addTarget(self, action: #selector(handleCanNotDie(with:)), for: .touchUpInside)
        
        view.addSubview(butShield2)
        view.addSubview(butShield3)
        view.addConstraintsWithFormat(format: "H:[v0(v2)]-15-[v1(v2)]-15-[v2]", views: butShield3, butShield2, butShield1)
        butShield2.topAnchor.constraint(equalTo: butPause.topAnchor, constant: 0).isActive = true
        butShield3.topAnchor.constraint(equalTo: butPause.topAnchor, constant: 0).isActive = true
        butShield2.heightAnchor.constraint(equalTo: butPause.heightAnchor, multiplier: 1).isActive = true
        butShield3.heightAnchor.constraint(equalTo: butPause.heightAnchor, multiplier: 1).isActive = true
        butShield2.addTarget(self, action: #selector(handleCanNotDie(with:)), for: .touchUpInside)
        butShield3.addTarget(self, action: #selector(handleCanNotDie(with:)), for: .touchUpInside)
        // banner View
        view.addSubview(bannerView)
        bannerView.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        bannerView.delegate = self
        // banner View2
        view.addSubview(bannerView2)
        bannerView2.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bannerView2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        bannerView2.delegate = self

        
        snowBall.widthAnchor.constraint(equalToConstant: 20/667*view.frame.size.width).isActive = true
        snowBall.heightAnchor.constraint(equalTo: snowBall.widthAnchor, multiplier: 1).isActive = true
        snowBallLeftAnchor = snowBall.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        snowBallLeftAnchor.isActive = true
        
        snowBallYAnchor = snowBall.topAnchor.constraint(equalTo: view.topAnchor, constant: 50/375*view.frame.size.height)
        snowBallYAnchor.isActive = true
        
        snowBall1.widthAnchor.constraint(equalToConstant: 20/667*view.frame.size.width).isActive = true
        snowBall1.heightAnchor.constraint(equalTo: snowBall1.widthAnchor, multiplier: 1).isActive = true
        snowBallLeftAnchor1 = snowBall1.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 120/667*view.frame.size.width)
        snowBallLeftAnchor1.isActive = true
        
        snowBallYAnchor1 = snowBall1.topAnchor.constraint(equalTo: view.topAnchor, constant: 150/375*view.frame.size.height)
        snowBallYAnchor1.isActive = true
        
        snowBall2.widthAnchor.constraint(equalToConstant: 20/667*view.frame.size.width).isActive = true
        snowBall2.heightAnchor.constraint(equalTo: snowBall2.widthAnchor, multiplier: 1).isActive = true
        snowBallLeftAnchor2 = snowBall2.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 200/667*view.frame.size.width)
        snowBallLeftAnchor2.isActive = true
        
        snowBallYAnchor2 = snowBall2.topAnchor.constraint(equalTo: view.topAnchor, constant: 250/375*view.frame.size.height)
        snowBallYAnchor2.isActive = true

        
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: viewRecognizerTapGesture)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: viewRecognizerTapGesture)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: imgVBackGround)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: imgVBackGround)
        view.addConstraintsWithFormat(format: "V:[v0(\(50/375*view.frame.size.height))]|", views: vSnowGround)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: vSnowGround)
        vSnowGround.addConstraintsWithFormat(format: "V:|[v0]|", views: imgVSnowGround)
        vSnowGround.addConstraintsWithFormat(format: "H:|[v0]|", views: imgVSnowGround)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("check go to ad and return")
    
        setRotate()
    }
    
    func setUpSantaClaus()
        {
            bottomAnchorOfSantaClaus = SantaClaus.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50/375*heightOfScreen)
            bottomAnchorOfSantaClaus.isActive = true
            SantaClaus.heightAnchor.constraint(equalToConstant: 65/375*heightOfScreen).isActive = true
            let img = UIImage(named: "jumpDown")
            SantaClaus.widthAnchor.constraint(equalToConstant: 50/667*widthOfScreen).isActive = true
            //let heightAfterAspect = img?.size.height*SantaClaus.frame.size.width/img?.size.width
            SantaClaus.image = img
            view.addConstraint(NSLayoutConstraint.init(item: SantaClaus, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 0.85, constant: 0))
        }

    
    func setTimers()
    {
        timerHandleMovingColAndSnowBall = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleMoveColAndSnowBall), userInfo: nil, repeats: true)
        timerHandleRunSantaClaus = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(handleRunSantaClaus), userInfo: nil, repeats: true)
        timerGetScore = Timer.scheduledTimer(timeInterval: 1.99, target: self, selector: #selector(getScore), userInfo: nil, repeats: true)
        timerHandleCheckForLose = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(handleCheckForLose), userInfo: nil, repeats: true)
    }
    
    var isDead: Bool = false
    
    struct OriginToCheck {
        var x: CGFloat
        var xR: CGFloat
        var y: CGFloat
        var yB: CGFloat
    }
    
    func handleCheckForLose()
    {
        let xSantaClaus = SantaClaus.frame.origin.x + 63/353*SantaClaus.frame.size.width
        let xRightSantaClaus = SantaClaus.frame.origin.x + SantaClaus.frame.size.width - 90/353*SantaClaus.frame.size.width
        let ySantaClaus = SantaClaus.frame.origin.y // + 8/375*heightOfScreen
        let yBotSantaClaus = ySantaClaus + (SantaClaus.frame.size.height) // - 20/375*heightOfScreen)
        
        let originOfSantaClaus = OriginToCheck.init(x: xSantaClaus, xR: xRightSantaClaus, y: ySantaClaus, yB: yBotSantaClaus)
        
        
        
        let xSnow = snowBall.frame.origin.x
        let xRightSnow = xSnow + snowBall.frame.size.width
        let ySnow = snowBall.frame.origin.y
        let yBotSnow = ySnow + snowBall.frame.size.height
        
        let originOfSnowBall = OriginToCheck.init(x: xSnow, xR: xRightSnow, y: ySnow, yB: yBotSnow)

        
        
        
        let xSnow1 = snowBall1.frame.origin.x
        let xRightSnow1 = xSnow1 + snowBall1.frame.size.width
        let ySnow1 = snowBall1.frame.origin.y
        let yBotSnow1 = ySnow1 + snowBall1.frame.size.height
        
        let originOfSnowBall1 = OriginToCheck.init(x: xSnow1, xR: xRightSnow1, y: ySnow1, yB: yBotSnow1)
        
        
        let xSnow2 = snowBall2.frame.origin.x
        let xRightSnow2 = xSnow2 + snowBall2.frame.size.width
        let ySnow2 = snowBall2.frame.origin.y
        let yBotSnow2 = ySnow2 + snowBall2.frame.size.height
        
        let originOfSnowBall2 = OriginToCheck.init(x: xSnow2, xR: xRightSnow2, y: ySnow2, yB: yBotSnow2)
        
        let xCol = vColBottom.frame.origin.x
        let xRightCol = xCol + vColBottom.frame.size.width
        let yCol = vColBottom.frame.origin.y // + 0/375*heightOfScreen
        let yBotCol = yCol + vColBottom.frame.size.height + 25/375*heightOfScreen
        
//        let bolSnow = (( (xSantaClaus < xSnow && xSnow < xRightSantaClaus ) || ( xSantaClaus < xRightSnow && xRightSnow < xRightSantaClaus ) ) && ( ( ySantaClaus < ySnow && ySnow < yBotSantaClaus ) || (ySantaClaus < yBotSnow && yBotSnow < yBotSantaClaus ) )) ? true : false
//        
//        let bolSnow1 = (( (xSantaClaus < xSnow1 && xSnow1 < xRightSantaClaus ) || ( xSantaClaus < xRightSnow1 && xRightSnow1 < xRightSantaClaus ) ) && ( ( ySantaClaus < ySnow1 && ySnow1 < yBotSantaClaus ) || (ySantaClaus < yBotSnow1 && yBotSnow1 < yBotSantaClaus ) )) ? true : false
//
//        let bolSnow2 = (( (xSantaClaus < xSnow2 && xSnow2 < xRightSantaClaus ) || ( xSantaClaus < xRightSnow2 && xRightSnow2 < xRightSantaClaus ) ) && ( ( ySantaClaus < ySnow2 && ySnow2 < yBotSantaClaus ) || (ySantaClaus < yBotSnow2 && yBotSnow2 < yBotSantaClaus ) )) ? true : false
        
        let bolSnow = checkSnowBallForLose(snowballOrigins: originOfSnowBall, santaClausOrigins: originOfSantaClaus)
        let bolSnow1 = checkSnowBallForLose(snowballOrigins: originOfSnowBall1, santaClausOrigins: originOfSantaClaus)
        let bolSnow2 = checkSnowBallForLose(snowballOrigins: originOfSnowBall2, santaClausOrigins: originOfSantaClaus)
        
        let bolCol = (( ( xCol < xSantaClaus && xSantaClaus < xRightCol) || ( xCol < xRightSantaClaus && xRightSantaClaus < xRightCol ) ) && ( ( yCol < ySantaClaus  && ySantaClaus < yBotCol ) || ( yCol < yBotSantaClaus && yBotSantaClaus < yBotCol ) )) ? true : false

        if bolSnow || bolSnow1 || bolSnow2 || bolCol
        {
            handleInvalidateTimers()
            isDead = true
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(delayForDead), userInfo: nil, repeats: false)
        }

    }
    
    func checkSnowBallForLose(snowballOrigins a: OriginToCheck, santaClausOrigins b: OriginToCheck) -> Bool
    {
        let result = (( (b.x < a.x && a.x < b.xR ) || ( b.x < a.xR && a.xR < b.xR ) ) && ( ( b.y < a.y && a.y < b.yB ) || (b.y < a.yB && a.yB < b.yB ) )) ? true : false
        return result
    }
    
    let vResult: UIView =
    {
        let temp = UIView()
        temp.backgroundColor = .clear
        /*temp.layer.cornerRadius = 10
        temp.layer.borderColor = UIColor.black.cgColor
        temp.layer.borderWidth = 3*/
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    lazy var butReplay: UIButton =
    {
        let temp = UIButton(type: .custom)
        temp.isEnabled = true
        //temp.setTitle("Replay", for: .normal)
        //temp.setTitleColor(.darkGray, for: .normal)
        //temp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        temp.addTarget(self, action: #selector(replay), for: .touchUpInside)
        //temp.imageView?.image = UIImage.init(named: "butPause")
        temp.setImage(UIImage.init(named: "butReplay"), for: .normal)
        temp.imageView?.contentMode = .scaleAspectFit
        //temp.backgroundColor = .clear
        //temp.layer.cornerRadius = 10
        //temp.layer.borderWidth = 3
        //temp.layer.borderColor = UIColor.lightGray.cgColor
        return temp
    }()
    func handleReplayAndShowVResult()
    {
        var hScore = userDefault.string(forKey: "highestScore")
        if hScore == nil
        {
            hScore = "0"
        }
        let result = checkHighestScore(cur: hScore!, newS: lblScore.text!)
        if result
        {
            userDefault.set(lblScore.text, forKey: "highestScore")
            hScore = lblScore.text!
            //handle New Best Score
            lblScoreWhenLose.textColor = UIColor.red
            lblBestScore.textColor = UIColor.red
            lblScoreWhenLose.text = "score: " + lblScore.text!
            lblBestScore.text = "NEW BEST: " + hScore!
        }
        else
        {
            lblScoreWhenLose.text = "score: " + lblScore.text!
            lblBestScore.text = "best: " + hScore!
        }
        let tempScore = Int(lblScore.text!)!
        if tempScore < 15
        {
            imgVCup.image = UIImage.init(named: "bronzeCup")
        }
        else if tempScore >= 15 && tempScore < 30
        {
            imgVCup.image = UIImage.init(named: "silverCup")
        }
        else
        {
            imgVCup.image = UIImage.init(named: "goldCup")
        }
        lblScore.isHidden = true
        vResult.isHidden = false
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionCurlUp, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    func checkHighestScore(cur: String, newS: String) -> Bool
    {
        let curInt = Int(cur)
        let newSInt = Int(newS)
        if curInt! >= newSInt!
        {
            return false
        }
        return true
    }

    func replay()
    {
        setDefault()
    }

    func delayForDead()
    {
        timerHandleDeadWhenImpacted = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleDeadWhenImpacted), userInfo: nil, repeats: false)
    }
    
    func handleDeadWhenImpacted()
    {
        timerHandleJumpDown.invalidate()
        handleUnHiddenAllBanners()
        bottomAnchorOfSantaClaus.constant = -45/375*heightOfScreen
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(handleReplayAndShowVResult), userInfo: nil, repeats: false)
        timerHandleSantaClausDeath = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(handleSantaClausDeath), userInfo: nil, repeats: true)
    }
    
    var score = 0
    func getScore()
    {
        if bottomAnchorOfSantaClaus.constant >= -45/375*heightOfScreen
        {
            score += 2
        }
        else
        {
            score += 1
        }
        lblScore.text = "\(score)"
        
    }
    
    var isFirstTap = true
    func handleTapGesture(tapGesture: UITapGestureRecognizer)
    {
        if isFirstTap
        {
            print("is First Tap!")
            if !imgMenu.isHidden
            {
                imgMenu.isHidden = true
                view.willRemoveSubview(imgMenu)
            }
            else
            {
                isFirstTap = false
                handleHiddenAllBanners()
                Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(setTimers), userInfo: nil, repeats: false)
            }
        }
        else
        {
            timeOfJumpUp = 0
            timerTimeOfJumpUp = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(countTimeOfJumpUp), userInfo: nil, repeats: true)
            timerPrepareForJumpDown.invalidate()
            timerLetJumpDown.invalidate()
            timerHandleJumpDown.invalidate()
            timerHandleJumpUp.invalidate()
            timerPrepareForJumpDown = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(prepareForJumpDown), userInfo: nil, repeats: false)
            timerHandleJumpUp = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleJumpUp), userInfo: nil, repeats: true)
        }

    }
    func prepareForJumpDown()
    {
        timerHandleJumpUp.invalidate()
        timerTimeOfJumpUp.invalidate()
        timeOfJumpUp = 0
        timerLetJumpDown = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(letJumpDown), userInfo: nil, repeats: false)
    }
    func letJumpDown()
    {
        if !isDead
        {
            timerHandleJumpDown = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleJumpDown), userInfo: nil, repeats: true)
        }
        
    }
    
    func handleJumpDown()
    {
        isJumpUp = false
        isJumpDown = true
        if timerTimeOfJumpUp.isValid
        {
            timerTimeOfJumpUp.invalidate()
        }
        let y = bottomAnchorOfSantaClaus.constant + 1.375/375*heightOfScreen
        if y >= -50/375*heightOfScreen
        {
            bottomAnchorOfSantaClaus.constant = -50/375*heightOfScreen
            timerLetJumpDown.invalidate()
            timerHandleJumpDown.invalidate()
        }
        else
        {
            bottomAnchorOfSantaClaus.constant += 1.375/375*heightOfScreen
        }
        SantaClaus.image = UIImage.init(named: "jumpDown")
        UIView.animate(withDuration: 3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {}, completion: nil)
    }
    func handleJumpUp()
    {
        isJumpUp = true
        isJumpDown = false
        SantaClaus.image = UIImage.init(named: "jumpUp")

        let bot = bottomAnchorOfSantaClaus.constant - 1.15/375*heightOfScreen
        if bot < ( -view.frame.size.height + 35/375*heightOfScreen)
        {
            isDead = true
            handleInvalidateTimers()
            handleUnHiddenAllBanners()
            bottomAnchorOfSantaClaus.constant = -45/375*heightOfScreen
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
            timerHandleSantaClausDeath = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(handleSantaClausDeath), userInfo: nil, repeats: true)
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(handleReplayAndShowVResult), userInfo: nil, repeats: false)
        }
        else
        {
            bottomAnchorOfSantaClaus.constant -= 1.15/375*heightOfScreen
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {}, completion: nil)
    }
    var indexDead = 0
    func handleSantaClausDeath()
    {
        indexDead += 1
        if (indexDead == 17)
        {
            SantaClaus.image = UIImage.init(named: "Dead (17)")
            timerHandleSantaClausDeath.invalidate()
            indexDead = 0
            
        }
        else
        {
            SantaClaus.image = UIImage.init(named: "Dead (\(indexDead))")
        }
    }


    func randYAnchorOfSnowBalls() -> CGFloat
    {
        let result = arc4random() % UInt32(self.view.frame.size.height - (85/375)*self.view.frame.size.height + 1) + UInt32(20/375*view.frame.size.height)
        return CGFloat(result)
    }
    var isMovingUp = true
    
    func handleMoveColAndSnowBall()
    {
        if snowBallLeftAnchor.constant >= -400/667*widthOfScreen && snowBallLeftAnchor.constant <= -200/667*widthOfScreen
        {
            let a = arc4random() % 10
            if a == 1 || a == 5
            {
                snowBallLeftAnchor.constant -= 3/667*view.frame.size.width
            }
        }
        snowBallLeftAnchor.constant -= 1.6/667*widthOfScreen
        snowBallLeftAnchor1.constant -= 2.75/667*widthOfScreen
        snowBallLeftAnchor2.constant -= 3.75/667*widthOfScreen
        if (snowBallLeftAnchor.constant + snowBall.frame.size.width) < (-widthOfScreen)
        {
            snowBallLeftAnchor.constant = 30/667*widthOfScreen
            var y = randYAnchorOfSnowBalls()
            if y >= (heightOfScreen - 85/375*heightOfScreen)
            {
                y -= 35/667*widthOfScreen
            }
            snowBallYAnchor.constant = y
        }
        if (snowBallLeftAnchor1.constant + snowBall.frame.size.width) < (-widthOfScreen)
        {
            snowBallLeftAnchor1.constant = 100/667*widthOfScreen
            snowBallYAnchor1.constant = randYAnchorOfSnowBalls()
        }
        if (snowBallLeftAnchor2.constant + snowBall.frame.size.width) < (-widthOfScreen)
        {
            snowBallLeftAnchor2.constant = 400/667*widthOfScreen
            snowBallYAnchor2.constant = randYAnchorOfSnowBalls()
        }
        leftAnchorOfVColumn.constant -= 2.5/667*widthOfScreen
        if (leftAnchorOfVColumn.constant + vColBottom.frame.size.width + 10/667*widthOfScreen) < (-widthOfScreen)
        {
            leftAnchorOfVColumn.constant = 50
            bottomAnchorOfVColumn.constant = 0
            heightAnchorOfVColumn.constant = randHeightForCol()
        }
        else
        {
            if bottomAnchorOfVColumn.constant > -45/375*heightOfScreen && isMovingUp
            {
                bottomAnchorOfVColumn.constant -= 0.3/375*heightOfScreen
                if bottomAnchorOfVColumn.constant <= -45/375*heightOfScreen || (heightAnchorOfVColumn.constant - bottomAnchorOfVColumn.constant) >= (heightOfScreen - 135/375*heightOfScreen)
                {
                    isMovingUp = false
                }
            }
            else
            {
                bottomAnchorOfVColumn.constant += 0.3/375*heightOfScreen
                if bottomAnchorOfVColumn.constant >= -4/375*heightOfScreen
                {
                    isMovingUp = true
                }
            }
            
        }
        
    }

    func setRotate()
    {
        rotateView(view: snowBall)
        rotateView(view: snowBall1)
        rotateView(view: snowBall2)
    }
    func randHeightForCol() -> CGFloat
    {
        
        let temp = arc4random() % UInt32(heightOfScreen - 150/375*view.frame.size.height - 52/375*view.frame.size.height + 1) + UInt32(52/375*view.frame.size.height)
        return CGFloat(temp)
    }

    
    var index = 0
    func handleRunSantaClaus()
    {
        if isDead
        {
            SantaClaus.image = UIImage.init(named: "Dead (17)")
        }
        else
        {
            index += 1
            if index >= 12 {
                index = 0
            }
            else
            {
                if bottomAnchorOfSantaClaus.constant >= -52/375*heightOfScreen && !isDead
                {
                    SantaClaus.image = UIImage.init(named: "Run (\(index))")
                }
            }

        }
    }
    func handleInvalidateTimers()
    {
        timerHandleCheckForLose.invalidate()
        timerHandleRunSantaClaus.invalidate()
        timerHandleMovingColAndSnowBall.invalidate()
        timerGetScore.invalidate()
        timerPrepareForJumpDown.invalidate()
        timerLetJumpDown.invalidate()
        timerHandleJumpDown.invalidate()
        timerHandleJumpUp.invalidate()
        timerTimeOfJumpUp.invalidate()
        viewRecognizerTapGesture.isUserInteractionEnabled = false
    }
    func setDefault()
    {
        score = 0
        lblScore.isHidden = false
        lblScore.text = "0"
        viewRecognizerTapGesture.isUserInteractionEnabled = true
        vResult.isHidden = true
        bottomAnchorOfSantaClaus.constant = -50/375*heightOfScreen
        SantaClaus.image = UIImage.init(named: "jumpDown")
        isFirstTap = true
        isDead = false
        butShield1.isHidden = false
        butShield2.isHidden = true
        butShield3.isHidden = true
        numberOfShield = 1
        
        isClickedGetShieldButton = false
        isClickedUpgrateShieldButton = false
        //isSilverShield = false
        //isGoldShield = false
        
        butGetShieldForPause.setBackgroundImage(UIImage.init(named: "butGetShieldOn"), for: .normal)
        butGetShieldForPause.isEnabled = true
        
        snowBallLeftAnchor.constant = 0
        snowBallYAnchor.constant = 50/375*heightOfScreen
        
        snowBallLeftAnchor1.constant = 120/667*widthOfScreen
        snowBallYAnchor1.constant = 150/375*heightOfScreen
        
        snowBallLeftAnchor2.constant = 200/667*widthOfScreen
        snowBallYAnchor2.constant = 250/375*heightOfScreen
        
        heightAnchorOfVColumn.constant = 53/375*heightOfScreen
        leftAnchorOfVColumn.constant = 70/667*widthOfScreen

    }
    
    func handlePresentInterstitialAd(sender: UIButton)
    {
        if (adMobInterstitialAd?.isReady)!
        {
            if sender == butUpgradeForResult
            {
                isClickedUpgrateShieldButton = true
                print("check uprateButton")
                
            }
            else if sender == butGetShieldForPause
            {
                print("check getShieldButton")
                isClickedGetShieldButton = true
            }
            
            adMobInterstitialAd?.present(fromRootViewController: self)

        }
        else
        {
            print("can't load")
        }

    }
    func handleClickedInterstitialAdToGetShield()
    {
        print("get shield!")
        if numberOfShield == 2
        {
            butGetShieldForPause.setBackgroundImage(UIImage.init(named: "butGetShieldOff"), for: .normal)
            butGetShieldForPause.isEnabled = false
            butShield3.isHidden = false
        }
        else
        {
            butShield2.isHidden = false
        }
        numberOfShield += 1
   
    }
    var adMobInterstitialAd: GADInterstitial?
    
    func loadAdMobInterstitialAd() -> GADInterstitial
    {
        let temp = GADInterstitial.init(adUnitID: "ca-app-pub-5636400042166583/661857215")
        temp.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        temp.load(request)
        return temp
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        adMobInterstitialAd = loadAdMobInterstitialAd()
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("check click interstitial")
        //adMobInterstitialAd = loadAdMobInterstitialAd()
        if isClickedGetShieldButton
        {
            handleClickedInterstitialAdToGetShield()
            isClickedGetShieldButton = false
        }
        else if isClickedUpgrateShieldButton
        {
            handleClickedUpgradeShieldButton()
            isClickedUpgrateShieldButton = false
        }
    }
    
    func handleClickedUpgradeShieldButton()
    {
        isClickedUpgrateShieldButton = false
        if isSilverShield
        {
            isGoldShield = true
            butUpgradeForResult.setBackgroundImage(UIImage.init(named: "butUpgradeOff"), for: .normal)
            butShield1.setImage(UIImage.init(named: "imgGoldShield"), for: .normal)
            butShield2.setImage(UIImage.init(named: "imgGoldShield"), for: .normal)
            butShield3.setImage(UIImage.init(named: "imgGoldShield"), for: .normal)
            butUpgradeForResult.isEnabled = false
        }
        else
        {
            isSilverShield = true
            butUpgradeForResult.setBackgroundImage(UIImage.init(named: "butUpgradeGoldShield"), for: .normal)
            //print("check ERROR")
            butShield1.setImage(UIImage.init(named: "imgSilverShield"), for: .normal)
            butShield2.setImage(UIImage.init(named: "imgSilverShield"), for: .normal)
            butShield3.setImage(UIImage.init(named: "imgSilverShield"), for: .normal)

        }
    }
    
    
    var isPause = false
    func handlePause()
    {
        print("check handle Pause")
        if !isDead && !isFirstTap && !isPause
        {
            print("check handle pause true")
//            if isClickedGetShield
//            {
//                //butGetSheildForPause.setBackgroundImage(UIImage.init(named: "butGetShieldOff"), for: .normal)
//                //butGetSheildForPause.isEnabled = false
//            }
//            else
//            {
//                butGetSheildForPause.setBackgroundImage(UIImage.init(named: "butGetShieldOn"), for: .normal)
//                butGetSheildForPause.isEnabled = true
//            }
            
            isPause = true
            handleUnHiddenAllBanners()
            handleInvalidateTimers()
            vShowWhenPause.isHidden = false
        }
    
    }
    func handleContinue()
    {
        isPause = false
        setTimers()
        vShowWhenPause.isHidden = true
        isClickedGetShieldButton = false
        handleHiddenAllBanners()
        viewRecognizerTapGesture.isUserInteractionEnabled = true
        if isJumpUp
        {
            timerHandleJumpUp = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleJumpUp), userInfo: nil, repeats: true)
            timerPrepareForJumpDown = Timer.scheduledTimer(timeInterval: (0.7 - timeOfJumpUp), target: self, selector: #selector(prepareForJumpDown), userInfo: nil, repeats: false)
            timeOfJumpUp = 0
            timerTimeOfJumpUp = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(countTimeOfJumpUp), userInfo: nil, repeats: true)
        }
        else if isJumpDown
        {
            timerHandleJumpDown = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleJumpDown), userInfo: nil, repeats: true)
        }
    }
    func countTimeOfJumpUp()
    {
        if timeOfJumpUp <= 0.85
        {
            timeOfJumpUp += 0.01
        }
    }
    func handleCanNotDie(with button: UIButton)
    {
        
        if !isDead && !isFirstTap && !isPause
        {
            timerHandleCheckForLose.invalidate()
            if !isSilverShield
            {
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleValidTimerHandleCheckAfterShieldInvalidate), userInfo: nil, repeats: false)
            }
            else if !isGoldShield
            {
                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(handleValidTimerHandleCheckAfterShieldInvalidate), userInfo: nil, repeats: false)
            }
            else
            {
                Timer.scheduledTimer(timeInterval: 2.75, target: self, selector: #selector(handleValidTimerHandleCheckAfterShieldInvalidate), userInfo: nil, repeats: false)
            }

            print("check handle can not die")
            button.isHidden = true
        }
        else
        {
            print("CHECK handle can not die if false")
        }
    }
    func handleValidTimerHandleCheckAfterShieldInvalidate()
    {
        //if !isDead
        //{
            timerHandleCheckForLose = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(handleCheckForLose), userInfo: nil, repeats: true)
        //}
    }
    func handleShowReadMe()
    {
        print("check show read me")
    }
}

class ReadMeVController: UIViewController
{
    
}
