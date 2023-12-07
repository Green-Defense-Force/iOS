//
//  ChallengeDetailViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/3/23.
//

import UIKit

class ChallengeDetailViewController: UIViewController {
    var challengedetailVM = ChallengeDetailViewModel()
    
    // 자 challengeVC에서 아이디 넘어오는거 받아오기 위해서 선언
    // 밑에 생성자 코드 확인할 것
    var challengeId: String
    
    lazy var stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // 타이틀 부분
    lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = UIColor(
            red: CGFloat(96) / 255.0,
            green: CGFloat(156) / 255.0,
            blue: CGFloat(36) / 255.0,
            alpha: 1.0
        )
        return titleView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .white
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rewardLabel: UILabel = {
        let label = UILabel()
        label.text = "성공 시, 장"
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 컨텐츠 부분
    lazy var contentView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 82/255, green: 133/255, blue: 31/255, alpha: 1.0)
        return container
    }()
    
    // 컨텐츠 흰 박스
    lazy var contentBox: UIScrollView = {
        let contentBox = UIScrollView()
        contentBox.layer.borderColor =  UIColor(
            red: CGFloat(0x3E) / 255.0,
            green: CGFloat(0x2B) / 255.0,
            blue: CGFloat(0x07) / 255.0,
            alpha: 1.0
        ).cgColor
        contentBox.layer.borderWidth = 5
        contentBox.backgroundColor = .white
        contentBox.translatesAutoresizingMaskIntoConstraints = false
        return contentBox
    }()
    
    // 컨텐츠 박스 안 내용
    var contentText: UILabel = {
        let label = UILabel()
        label.text = "여기는 컨텐츠 내용"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 컨텐츠 박스 안 목표
    var contentGoal: UILabel = {
        let label = UILabel()
        label.text = "여기는 목표"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 컨텐츠 박스 안 이미지
    lazy var imgContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var rightImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "rightImg"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    } ()
    
    lazy var wrongImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "wrongImg"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "올바른 예시"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var wrongLabel: UILabel = {
        let label = UILabel()
        label.text = "틀린 예시"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 컨텐츠 박스 안 체크리스트
    var contentCheckList: UILabel = {
        let label = UILabel()
        label.text = "여기는 체크리스트"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 버튼 컨테이너
    lazy var btnContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "challengeDetailBtn"), for: .normal)
        btn.setTitle("뒤로가기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(backToChallenge), for: .touchUpInside)
        return btn
    }()
    
    lazy var cameraBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "challengeDetailBtn"), for: .normal)
        btn.setTitle("촬영하기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(goToCamera), for: .touchUpInside)
        return btn
    }()
    
    // 생성자로 받기 위해 생성자 만들어 놓기
    init(challengeId: String) {
        self.challengeId = challengeId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengedetailVM.fetch()
        setUI()
        CustomTabBarViewController.shared.customTabBar.isHidden = true
        print("여기가 말이죠 challengeVC에서 넘어온 ID거든요: \(challengeId)")
    }
    
    func setUI() {
        
        // 데이터 삽입
        titleLabel.text = challengedetailVM.challengeDetailModel?.challengeTitle ?? "빈 값"
        rewardLabel.text = "성공 시, \(challengedetailVM.challengeDetailModel?.rewardType ?? "티켓") \(challengedetailVM.challengeDetailModel?.rewardCount ?? 0)장"
        
        contentText.text = challengedetailVM.challengeDetailModel?.challengeContent ?? "빈 값"
        contentGoal.text = challengedetailVM.challengeDetailModel?.challengeGoal ?? "빈 값"
        contentCheckList.text = challengedetailVM.challengeDetailModel?.challengeChecklist ?? "빈 값"
        // 스텍 뷰
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(contentView)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/4),
            contentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 3/4),
        ])
        
        // 이 밑으로 타이틀 컨테이너
        titleView.addSubview(titleLabel)
        titleView.addSubview(rewardLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            
            rewardLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            rewardLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            rewardLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
        ])
        
        // 이 밑으로 컨텐츠 컨테이너
        contentView.addSubview(contentBox)
        contentView.addSubview(btnContainer)
        
        contentBox.addSubview(contentText)
        contentBox.addSubview(contentGoal)
        contentBox.addSubview(imgContainer)
        contentBox.addSubview(contentCheckList)
        imgContainer.addSubview(rightImg)
        imgContainer.addSubview(wrongImg)
        imgContainer.addSubview(rightLabel)
        imgContainer.addSubview(wrongLabel)
        NSLayoutConstraint.activate([
            contentBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            contentBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150),
            
            contentText.topAnchor.constraint(equalTo: contentBox.topAnchor, constant: 30),
            contentText.leadingAnchor.constraint(equalTo: contentBox.leadingAnchor, constant: 10),
            contentGoal.topAnchor.constraint(equalTo: contentText.bottomAnchor, constant: 20),
            contentGoal.leadingAnchor.constraint(equalTo: contentBox.leadingAnchor, constant: 10),
            contentGoal.trailingAnchor.constraint(equalTo: contentBox.trailingAnchor, constant: -10),
            
            imgContainer.topAnchor.constraint(equalTo: contentGoal.bottomAnchor, constant: 50),
            imgContainer.centerXAnchor.constraint(equalTo: contentBox.centerXAnchor),
            rightImg.leadingAnchor.constraint(equalTo: imgContainer.leadingAnchor),
            rightImg.trailingAnchor.constraint(equalTo: imgContainer.centerXAnchor, constant: -10),
            wrongImg.trailingAnchor.constraint(equalTo: imgContainer.trailingAnchor),
            wrongImg.leadingAnchor.constraint(equalTo: imgContainer.centerXAnchor, constant: 10),
            rightLabel.bottomAnchor.constraint(equalTo: rightImg.topAnchor, constant: -10),
            rightLabel.centerXAnchor.constraint(equalTo: rightImg.centerXAnchor),
            wrongLabel.bottomAnchor.constraint(equalTo: wrongImg.topAnchor, constant: -10),
            wrongLabel.centerXAnchor.constraint(equalTo: wrongImg.centerXAnchor),
            
            contentCheckList.topAnchor.constraint(equalTo: imgContainer.bottomAnchor, constant: 150),
            contentCheckList.leadingAnchor.constraint(equalTo: contentBox.leadingAnchor, constant: 10),
            contentCheckList.bottomAnchor.constraint(equalTo: contentBox.bottomAnchor, constant: -50)
        ])
        
        // 버튼
        btnContainer.addSubview(backBtn)
        btnContainer.addSubview(cameraBtn)
        NSLayoutConstraint.activate([
            btnContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnContainer.topAnchor.constraint(equalTo: contentBox.bottomAnchor, constant: 30),
            btnContainer.heightAnchor.constraint(equalToConstant: 50),
            
            backBtn.centerYAnchor.constraint(equalTo: btnContainer.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: btnContainer.leadingAnchor, constant: 50),
            backBtn.trailingAnchor.constraint(equalTo: cameraBtn.leadingAnchor, constant: -30),
            
            cameraBtn.centerYAnchor.constraint(equalTo: btnContainer.centerYAnchor),
            cameraBtn.trailingAnchor.constraint(equalTo: btnContainer.trailingAnchor, constant: -50),
        ])
    }
    
    @objc func backToChallenge() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func goToCamera() {
        let challengeCameraVC = ChallengeCameraViewController(challengedTitle: challengedetailVM.challengeDetailModel?.challengeTitle ?? "빈 값", rewardType: challengedetailVM.challengeDetailModel?.rewardType ?? "빈 값", rewardCount: challengedetailVM.challengeDetailModel?.rewardCount ?? 0)
        navigationController?.pushViewController(challengeCameraVC, animated: false)
    }
}
