//
//  LoadingView.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import Foundation
import UIKit
import Lottie

class LoadingView: UIView {
    
    private static var _shared: LoadingView?
    
    var animationView : AnimationView!
    private var isLoadingViewShowing:Bool = false
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = .black
        blurEffectView.alpha = 0.2
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
         
        let bkView = UIView()
        bkView.backgroundColor = .clear
        
        let width = self.frame.width * 0.3
        
        bkView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        bkView.center = self.center
        
        self.addSubview(bkView)

        animationView = AnimationView(name: "newsLoading")
        animationView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        animationView.loopMode = .loop
        
        bkView.addSubview(self.animationView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var shared: LoadingView {
        if _shared == nil { _shared = LoadingView()}
        return _shared!
    }
    
    static func resetLoadingView() {
        _shared = nil
    }
    
    public func startLoadingView(vc:UIViewController){
        if !isLoadingViewShowing {
            animationView.play()
            vc.view.addSubview(self)
            isLoadingViewShowing = true
        }
    }
    
    public func startLoadingView(){
        if !isLoadingViewShowing {
            
            let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            
            if let window = keyWindow {
                if let rootViewController = window.rootViewController {
                    animationView.play()
                    rootViewController.view.addSubview(self)
                }
            }
            isLoadingViewShowing = true
        }
    }
    
    public func stopLoadingView(){
        animationView.stop()
        isLoadingViewShowing=false
        self.removeFromSuperview()
        LoadingView.resetLoadingView()
    }
    
    public func stopLoadingView(vc: UIViewController) {
        if isLoadingViewShowing {
            animationView.stop()
            vc.view.removeFromSuperview()
            isLoadingViewShowing = false
        }
        LoadingView.resetLoadingView()
    }
    
}
