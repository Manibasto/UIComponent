//
//  MainController.swift
//  FireApp
//
//  Created by Pavel Bogart on 26/02/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class MainController: UIViewController {
    
    let defaults = UserDefaults.standard
    var ref: DatabaseReference!
    
    var appUser: AppUser? {
        didSet {
            print("value set")
            guard let userName = appUser?.name else { return }
            navigationItem.title = userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        navigationItem.title = "Your Name"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        
        fetchUserInfo()
    }
    
    @objc func logOut() {
        print("logged out")
        do {
            try Auth.auth().signOut()
            defaults.set(false, forKey: "UserIsLoggedIn")
            
            let loginController = UINavigationController(rootViewController: LoginController())
            present(loginController, animated: true, completion: nil)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func fetchUserInfo() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? NSDictionary else { return }
            guard let username = data["name"] as? String else { return }
            self.appUser = AppUser(name: username, uid: userId)
        }
    }
    
}
