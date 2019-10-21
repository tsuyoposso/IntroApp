//
//  ViewController.swift
//  IntroApp
//
//  Created by 長坂豪士 on 2019/10/19.
//  Copyright © 2019 NagaKe. All rights reserved.
//

import UIKit
import Lottie

class IntroViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["1", "2", "3", "4", "5"]
    
    var onboardStringArray = ["私たちはみんな繋がっています！", "説明２です！！", "説明3です！！", "説明4です！！", "説明5です！！"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isPagingEnabled = true
        setUpScroll()
        
        for i in 0...4 {
            let animationView = AnimationView()
            let animation = Animation.named(onboardArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    func setUpScroll() {
        
        scrollView.delegate = self
        // ５ページ分スクロールするために横幅を5倍にする
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: scrollView.frame.size.height )
        
        for i in 0...4 {
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height / 3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
            scrollView.addSubview(onboardLabel)
        }
        
    }
    
    
}

