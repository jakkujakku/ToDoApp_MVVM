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
    
    var navGalleryStackView = CustomStackView(frame: .zero)
    var dividerView = UIView(frame: .zero)
    var gridButton = CustomButton(frame: .zero)
    var sectionIndicationView = UIView(frame: .zero)
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
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
        setupNavigationGallery()
        setupCollectionView()
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
        followButton.configure(title: "Follow", color: UIColor(hexCode: "#3898F3"))
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
    func setupNavigationGallery() {
        view.addSubview(navGalleryStackView)
        view.addSubview(dividerView)
        navGalleryStackView.configure(axis: .horizontal, alignment: .leading, distribution: .fillProportionally, spacing: 0)
        dividerView.backgroundColor = .systemGray6
        gridButton.setImage(UIImage(named: "Grid"), for: .normal)
        sectionIndicationView.backgroundColor = .black
        
        [gridButton, sectionIndicationView].forEach {
            navGalleryStackView.addArrangedSubview($0)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(305)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        navGalleryStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(305)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(376)
        }
        
        gridButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(315)
            make.left.equalToSuperview().inset(52)
            make.width.height.equalTo(22.5)
        }
        
        sectionIndicationView.snp.makeConstraints { make in
            make.top.equalTo(view).inset(348)
            make.leading.equalTo(view)
            make.trailing.equalTo(view).inset(263)
            make.width.equalTo(124)
            make.height.equalTo(1)
        }
    }
}

extension ProfileViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(350)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(view).inset(110)
        }
    }
}

extension ProfileViewController {
    @objc func tappedMenuButton(_ sender: UIBarButtonItem) {
        print("### \(#function)")
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        cell.setupUI()
        cell.configureCell(indexPath: indexPath.row)
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 1
        let padding: CGFloat = 1
        let width = (collectionView.bounds.width - interItemSpacing * 2 - padding * 2) / 3
        print("### Current Width : \(width)")
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
