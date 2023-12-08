//
//  ChallengeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/10/23.
//

import UIKit

class ChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let challengeVM = ChallengeViewModel()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = UIColor(
            red: CGFloat(96) / 255.0,
            green: CGFloat(156) / 255.0,
            blue: CGFloat(36) / 255.0,
            alpha: 1.0
        )
        let label1 = UILabel()
        label1.text = "챌린지"
        label1.textColor = .white
        label1.font = label1.font.withSize(30)
        label1.textAlignment = .center
        
        let label2 = UILabel()
        label2.text = "Challenge"
        label2.textColor = .white
        label2.font = label2.font.withSize(20)
        label2.textAlignment = .center
        
        titleView.addSubview(label1)
        titleView.addSubview(label2)
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label1.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            label1.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            label1.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            label1.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            label2.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            label2.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
        ])
        
        return titleView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 82/255, green: 133/255, blue: 31/255, alpha: 1.0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ChallengeTableViewCell.self, forCellReuseIdentifier: ChallengeTableViewCell.reuseIdentifier)
        setUI()
        challengeVM.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        CustomTabBarViewController.shared.customTabBar.isHidden = false
    }
    
    func setUI() {
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/4),
            tableView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 3/4),
        ])
    }
    
    // 섹션에 표시할 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return challengeVM.numberOfChallenges
    }
    
    // 행에 대한 셀을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeCell", for: indexPath) as? ChallengeTableViewCell else {
            fatalError("Failed to dequeue ChallengeTableViewCell")}
        // 섹션으로 데이터 넣고 있기때문에 indexPath.row에서 indexPath.section으로 변경
        if let challengePreview = challengeVM.challengePreview(index: indexPath.section) {
            cell.configure(challengePreview: challengePreview)
        }
        return cell
    }
    
    // 행 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    // 테이블 간 여백
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    // 테이블 간 여백
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 아이디를 뽑았구요~
        let challengeId = challengeVM.challengePreview(index: indexPath.section)?.challengeId ?? "실패"
        
        // 아이디를 DetailVC로 넘기기 위해서 Detail에 생성자를 만들고요~ 넘깁니다!
        let challengeDetailVC = ChallengeDetailViewController(challengeId: challengeId)
            navigationController?.pushViewController(challengeDetailVC, animated: false)
    }
}
