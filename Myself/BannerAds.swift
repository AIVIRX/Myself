//
//  BannerAds.swift
//  Myself
//
//  Created by Maicol Cabreja on 10/9/22.
//
//

import SwiftUI
import GoogleMobileAds

//implementing banner ad

struct AdView: UIViewRepresentable{
    
    var adUnitID: String
    
    func makeCoordinator() -> Coordinator {
        //for implementing delegates
        return Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<AdView>) -> GADBannerView{
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        
        banner.adUnitID = adUnitID
        banner.rootViewController = UIApplication.shared.getRootViewController()
        banner.delegate = context.coordinator
        banner.load(GADRequest())
        
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<AdView>) {
        
    }
    
    class Coordinator: NSObject, GADBannerViewDelegate{
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("bannerViewDidReceiveAd")
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("bannerViewDidRecordImpression")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillDIsmissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}

//extending application to get root view
extension UIApplication{
    func getRootViewController()->UIViewController{
        guard let screen = self.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
