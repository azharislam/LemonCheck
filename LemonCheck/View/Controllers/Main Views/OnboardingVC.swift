//
//  OnboardingVC.swift
//  LemonCheck
//
//  Created by Kazi Abdullah Al Mamun on 5/13/21.
//  Copyright © 2021 Varley Parker. All rights reserved.
//

import UIKit
import AuthenticationServices
import CloudKit

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
            scrollPage(sender)
        } else {
            requestAppleSignIn()
        }
    }
    
    private func scrollPage(_ sender: UIButton) {
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
    
    private func requestAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
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

extension OnboardingVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        let privateDatabase = CKContainer(identifier: "iCloud.LemonCheck").privateCloudDatabase
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let userId = credentials.user
            
            // Record first name, last name and email
            
            if let name = credentials.fullName?.givenName,
               let email = credentials.email {
                
                // New user (signing up)
                // Save info to CloudKit
                
                let record = CKRecord(recordType: "userInfo", recordID: CKRecord.ID(recordName: userId))
                record["name"] = name
                record["email"] = email
                privateDatabase.save(record) { (_,_) in
                    UserDefaults.standard.set(record.recordID.recordName, forKey: "userProfileID")
                    print("User has been SAVED INTO DATABASE")
                }
                
                
            } else {
                
                // Returning user (signing in)
                // Fetch user name and email
                // From private CloudKit
                privateDatabase.fetch(withRecordID: CKRecord.ID(recordName: userId)) { (record, error) in
                    if let fetchedInfo = record {
                        let name = fetchedInfo["name"] as? String
                        let userEmail = fetchedInfo["email"] as? String
                        print("User already has account")
                        // Set this info in Settings view controller
                        
                        UserDefaults.standard.set(userId, forKey: "userProfileID")
                    }
                }
                
            }
            
            UserDefaults.standard.set(true, forKey: "status")
            Switcher.updateRootVC()
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error logging in", error)
    }
}

extension OnboardingVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
