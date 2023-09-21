//
//  ProfileViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    var userNameLabel = CustomLabel(frame: .zero)
    var menuButton = CustomButton(frame: .zero)
    
    var profileIconimageView = CustomImageView(frame: .zero)
    
    var superStackView = CustomStackView(frame: .zero)
    var postStackView = CustomStackView(frame: .zero)
    var followerStackView = CustomStackView(frame: .zero)
    var followingStackView = CustomStackView(frame: .zero)
    
    var postLabel = CustomLabel(frame: .zero)
    var postDescription = CustomLabel(frame: .zero)
    
    var followerLabel = CustomLabel(frame: .zero)
    var followerDescription = CustomLabel(frame: .zero)
    
    var followingLabel = CustomLabel(frame: .zero)
    var followingDsecription = CustomLabel(frame: .zero)
    
    var userInfoStackView = CustomStackView(frame: .zero)
    var nameLabel = CustomLabel(frame: .zero)
    var bioLabel = CustomLabel(frame: .zero)
    var linkInBio = CustomLabel(frame: .zero)
    
    var middleBarStackView = CustomStackView(frame: .zero)
    var followButton = CustomButton(frame: .zero)
    var messageButton = CustomButton(frame: .zero)
    var moreButton = CustomButton(frame: .zero)
    
    deinit {
        print("### ProfileViewController deinitialized")
    }
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ProfileViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        setupMenuButton()
        setupUserName()
        setupImageView()
        setupSuperStackView()
        setupPostStackView()
        setupFollowerStackView()
        setupFollowingStackVew()
        setupUserInfoStackView()
        setupMiddleBar()
    }
    
    func setupMenuButton() {
        view.addSubview(menuButton)
        menuButton.setImage(UIImage(named: "Menu"), for: .normal)
        menuButton.addTarget(self, action: #selector(tappedMenuButton(_:)), for: .touchUpInside)
 
        menuButton.snp.makeConstraints { make in
            make.height.equalTo(17.5)
            make.width.equalTo(21)
            make.top.equalToSuperview().inset(58)
            make.leading.equalToSuperview().inset(338)
        }
    }
    
    func setupUserName() {
        view.addSubview(userNameLabel)
        userNameLabel.configure(ofSize: 18, weight: .bold, text: "nabaecamp", textAlignment: .center)
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(54)
            make.centerX.equalToSuperview()
            make.width.equalTo(97)
            make.height.equalTo(25)
        }
    }
    
    func setupImageView() {
        profileIconimageView.image = UIImage(named: "Icon")
        profileIconimageView.configurelayer(corner: 44)
        
        view.addSubview(profileIconimageView)
        profileIconimageView.snp.makeConstraints { make in
            make.top.equalTo(view).inset(93)
            make.leading.equalTo(view).inset(16)
            make.width.equalTo(89)
            make.height.equalTo(88)
        }
    }
}

extension ProfileViewController {
    func setupSuperStackView() {
        view.addSubview(superStackView)
        superStackView.configure(axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 23)
        [postStackView, followerStackView, followingStackView].forEach {
            superStackView.addArrangedSubview($0)
        }
        
        superStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(116)
            make.leading.equalToSuperview().inset(143)
            make.trailing.equalToSuperview().inset(28)
            make.height.equalTo(41)
            make.width.equalTo(204)
        }
    }
    
    func setupPostStackView() {
        postStackView.configure(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
        postLabel.configure(ofSize: 16.5, weight: .bold, text: "7", textAlignment: .center)
        postDescription.configure(ofSize: 14, weight: .regular, text: "post", textAlignment: .center)
        
        [postLabel, postDescription].forEach {
            postStackView.addArrangedSubview($0)
        }
        
        postStackView.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.width.equalTo(28)
        }
    }
    
    func setupFollowerStackView() {
        followerStackView.configure(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
        followerLabel.configure(ofSize: 16.5, weight: .bold, text: "0", textAlignment: .center)
        followerDescription.configure(ofSize: 14, weight: .regular, text: "follower", textAlignment: .center)

        [followerLabel, followerDescription].forEach {
            followerStackView.addArrangedSubview($0)
        }
        
        followerStackView.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.width.equalTo(51)
        }
    }
    
    func setupFollowingStackVew() {
        followingStackView.configure(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
        followingLabel.configure(ofSize: 16.5, weight: .bold, text: "0", textAlignment: .center)
        followingDsecription.configure(ofSize: 14, weight: .regular, text: "following", textAlignment: .center)
        
        [followingLabel, followingDsecription].forEach {
            followingStackView.addArrangedSubview($0)
        }
        
        followingStackView.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.width.equalTo(57)
        }
    }
}

extension ProfileViewController {
    func setupUserInfoStackView() {
        userInfoStackView.configure(axis: .vertical, alignment: .leading, distribution: .fillProportionally, spacing: 0)
        
        nameLabel.configure(ofSize: 14, weight: .bold, text: "고길동", textAlignment: .left)
        bioLabel.configure(ofSize: 14, weight: .regular, text: "iOS Developer 🍎", textAlignment: .left)
        linkInBio.configure(ofSize: 14, weight: .regular, text: "spartacodingclub.kr", textAlignment: .left)
        linkInBio.textColor = .systemBlue
        
        view.addSubview(userInfoStackView)
        
        [nameLabel, bioLabel, linkInBio].forEach {
            userInfoStackView.addArrangedSubview($0)
        }
        
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(195)
            make.centerX.equalToSuperview()
            make.width.equalTo(345)
            make.height.equalTo(59)
        }
    }
}

extension ProfileViewController {
    func setupMiddleBar() {
        view.addSubview(middleBarStackView)
        middleBarStackView.configure(axis: .horizontal, alignment: .fill, distribution: .fillProportionally, spacing: 10)
        followButton.configure(title: "Follow", color: .systemBlue)
        followButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        followButton.tintColor = .white
        followButton.layer.cornerRadius = 4
        
        messageButton.configure(title: "Message", color: .white)
        messageButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        messageButton.setTitleColor(.black, for: .normal)
        messageButton.layer.cornerRadius = 4
        messageButton.layer.borderWidth = 1.5
        messageButton.layer.borderColor = UIColor.systemGray6.cgColor

        moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreButton.tintColor = .black
        moreButton.layer.cornerRadius = 4
        moreButton.layer.borderWidth = 1.5
        moreButton.layer.borderColor = UIColor.systemGray6.cgColor
        
        [followButton, messageButton, moreButton].forEach {
            middleBarStackView.addArrangedSubview($0)
        }
        
        middleBarStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(265)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(345)
        }
        
        followButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        messageButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        moreButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
    }
}

extension ProfileViewController {
    @objc func tappedMenuButton(_ sender: UIBarButtonItem) {
        print("### \(#function)")
    }
}
