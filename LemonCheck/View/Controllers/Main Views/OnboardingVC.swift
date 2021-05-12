//
//  OnboardingVC.swift
//  LemonCheck
//
//  Created by Kazi Abdullah Al Mamun on 5/13/21.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet
    private var cv: UICollectionView!
    @IBOutlet
    private var pageControll: UIPageControl!

    private let cellImages = [UIImage(named: "page1BG"),
                              UIImage(named: "page2BG"),
                              UIImage(named: "page3BG")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction
    private func nextBtnAction(_ sender: UIButton) {
        if pageControll.currentPage < 2 {
            cv.scrollToItem(at: IndexPath(item: pageControll.currentPage + 1, section: 0), at: .right, animated: true)
            pageControll.currentPage += 1
            
            if pageControll.currentPage == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.07
                    animation.repeatCount = 4
                    animation.autoreverses = true
                    animation.fromValue = NSValue(cgPoint: CGPoint(x: sender.center.x - 10, y: sender.center.y))
                    animation.toValue = NSValue(cgPoint: CGPoint(x: sender.center.x + 10, y: sender.center.y))

                    sender.layer.add(animation, forKey: "position")
                    sender.setImage(UIImage(systemName: "applelogo"), for: .normal)
                    sender.setTitle("Sign Up with Apple", for: .normal)
                }
            }
        }
    }
}

extension OnboardingVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCVCell.RE_USE_IDENTIFIER, for: indexPath) as! OnBoardingCVCell
        cell.bgImage.image = cellImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        view.frame.size
    }
}
