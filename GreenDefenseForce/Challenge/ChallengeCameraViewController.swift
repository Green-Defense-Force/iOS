//
//  ChallengeCameraViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/7/23.
//

import UIKit
import AVFoundation

class ChallengeCameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    // AVCaptureSession 및 AVCaptureVideoPreviewLayer 인스턴스를 선언합니다.
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var challengedTitle: String
    var rewardType: String
    var rewardCount: Int
    
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
        titleView.translatesAutoresizingMaskIntoConstraints = false
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
    
    // 카메라 부분
    lazy var cameraView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    // 제어 부분
    lazy var controlView: UIStackView = {
        let container = UIStackView()
        container.backgroundColor = UIColor(
            red: CGFloat(96) / 255.0,
            green: CGFloat(156) / 255.0,
            blue: CGFloat(36) / 255.0,
            alpha: 1.0
        )
        container.axis = .horizontal
        container.distribution = .equalSpacing
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "challengeCameraControlBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(backToChallenge), for: .touchUpInside)
        return btn
    }()
    
    lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "뒤로가기"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lightLabel: UILabel = {
        let label = UILabel()
        label.text = "조명켜기"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cameraBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "challengeCameraBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        return btn
    }()
    
    lazy var lightBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "challengeCameraControlBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(toggleFlashlight), for: .touchUpInside)
        return btn
    }()
    
    init(challengedTitle: String, rewardType: String, rewardCount: Int) {
        self.challengedTitle = challengedTitle
        self.rewardType = rewardType
        self.rewardCount = rewardCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCamera()
    }
    
    // 뷰의 크기가 변경된 후 호출되는 메서드입니다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 프리뷰 레이어의 프레임을 카메라 뷰의 경계로 설정합니다.
        previewLayer?.frame = cameraView.layer.bounds
    }
    
    func setUI() {
        // 전달 받은 데이터 삽입
        titleLabel.text = challengedTitle
        rewardLabel.text = "성공 시, \(rewardType) \(rewardCount)장"
        
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(cameraView)
        stackView.addArrangedSubview(controlView)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/4),
            cameraView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 2/4),
            controlView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/4)
        ])
        
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
        
        controlView.addSubview(backBtn)
        controlView.addSubview(cameraBtn)
        controlView.addSubview(lightBtn)
        backBtn.addSubview(backLabel)
        lightBtn.addSubview(lightLabel)
        NSLayoutConstraint.activate([
            controlView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            controlView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            controlView.topAnchor.constraint(equalTo: cameraView.bottomAnchor),
            controlView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            cameraBtn.centerXAnchor.constraint(equalTo: controlView.centerXAnchor),
            cameraBtn.centerYAnchor.constraint(equalTo: controlView.centerYAnchor),
            backBtn.centerYAnchor.constraint(equalTo: cameraBtn.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 30),
            backLabel.centerXAnchor.constraint(equalTo: backBtn.centerXAnchor),
            backLabel.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            lightBtn.centerYAnchor.constraint(equalTo: cameraBtn.centerYAnchor),
            lightBtn.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -30),
            lightLabel.centerXAnchor.constraint(equalTo: lightBtn.centerXAnchor),
            lightLabel.centerYAnchor.constraint(equalTo: lightBtn.centerYAnchor),
        ])
        
        
    }
    
    // 카메라를 설정하는 메서드입니다.
    func setCamera() {
        // 백그라운드 스레드에서 비동기로 작업을 수행합니다.
        DispatchQueue.global(qos: .background).async {
            // AVCaptureSession을 초기화합니다.
            self.captureSession = AVCaptureSession()
            // captureSession이 nil이 아닌 경우에만 진행합니다.
            guard let captureSession = self.captureSession else { return }

            // 입력 디바이스 (카메라)를 설정합니다.
            if let captureDevice = AVCaptureDevice.default(for: .video) {
                do {
                    let input = try AVCaptureDeviceInput(device: captureDevice)
                    captureSession.addInput(input)
                } catch {
                    print(error.localizedDescription)
                }
                
                // 프리뷰 레이어를 설정합니다.
                self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                if let previewLayer = self.previewLayer {
                    previewLayer.videoGravity = .resizeAspectFill
                    
                    // UI 업데이트는 메인 스레드에서 수행되어야 합니다.
                    DispatchQueue.main.async {
                        previewLayer.frame = self.cameraView.layer.bounds
                        self.cameraView.layer.addSublayer(previewLayer)
                    }
                    
                    // 카메라를 시작합니다.
                    DispatchQueue.global(qos: .background).async {
                        captureSession.startRunning()
                    }
                }
            }
        }
    }

    // AVCapturePhotoCaptureDelegate 프로토콜 일부, 카메라가 사진 찍고 자동 호출 -> 찍힌 사진 처리하는 로직임
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            print("Error capturing photo: \(String(describing: error))")
            return
        }
        
        // 사진 앨범에 이미지를 저장합니다.
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 모달창 올리기 위한 컨테이너
        let imagePreviewViewController = UIViewController()
        imagePreviewViewController.view.backgroundColor = .black.withAlphaComponent(0.0)
        imagePreviewViewController.modalPresentationStyle = .formSheet // 팝업 스타일로 표시합니다.
        imagePreviewViewController.modalTransitionStyle = .crossDissolve
        imagePreviewViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // 모달창 부분
        let modalBg = UIImageView(image: UIImage(named: "cameraModal"))
        modalBg.translatesAutoresizingMaskIntoConstraints = false
        modalBg.isUserInteractionEnabled = true
        imagePreviewViewController.view.addSubview(modalBg)
        
        NSLayoutConstraint.activate([
            modalBg.topAnchor.constraint(equalTo: imagePreviewViewController.view.topAnchor, constant: 80),
            modalBg.leadingAnchor.constraint(equalTo: imagePreviewViewController.view.leadingAnchor, constant: 30),
            modalBg.trailingAnchor.constraint(equalTo: imagePreviewViewController.view.trailingAnchor, constant: -30),
            modalBg.bottomAnchor.constraint(equalTo: imagePreviewViewController.view.bottomAnchor, constant: -80),
        ])
        
        // 모달창 안, 찍힌 사진 올라오는 영역
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.center = imagePreviewViewController.view.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        modalBg.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: modalBg.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: modalBg.centerYAnchor, constant: -25),
            imageView.widthAnchor.constraint(equalTo: modalBg.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: modalBg.heightAnchor, multiplier: 0.8)
        ])
        
        let retryBtn = UIButton()
        retryBtn.setBackgroundImage(UIImage(named: "challengeDetailBtn"), for: .normal)
        retryBtn.setTitle("재촬영", for: .normal)
        retryBtn.setTitleColor(.black, for: .normal)
        retryBtn.translatesAutoresizingMaskIntoConstraints = false
        retryBtn.addTarget(self, action: #selector(backToCamera), for: .touchUpInside)
        modalBg.addSubview(retryBtn)
        NSLayoutConstraint.activate([
            retryBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            retryBtn.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            retryBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        let okBtn = UIButton()
        okBtn.setBackgroundImage(UIImage(named: "challengeDetailBtn"), for: .normal)
        okBtn.setTitle("확인", for: .normal)
        okBtn.setTitleColor(.black, for: .normal)
        okBtn.translatesAutoresizingMaskIntoConstraints = false
        okBtn.addTarget(self, action: #selector(goToChallengeHome), for: .touchUpInside)
        modalBg.addSubview(okBtn)
        NSLayoutConstraint.activate([
            okBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            okBtn.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            okBtn.bottomAnchor.constraint(equalTo: retryBtn.bottomAnchor),
            okBtn.heightAnchor.constraint(equalTo: retryBtn.heightAnchor)
            
        ])
        
        // 메인 스레드에서 뷰 컨트롤러를 표시합니다.
        DispatchQueue.main.async {
            self.present(imagePreviewViewController, animated: true, completion: nil)
        }
    }

    
    // 사진 찍기
    @objc func capturePhoto() {
        let photoOutput = AVCapturePhotoOutput()
        
        if let currentPhotoOutput = captureSession?.outputs.first(where: { $0 is AVCapturePhotoOutput }) {
            captureSession?.removeOutput(currentPhotoOutput)
        }
        
        captureSession?.addOutput(photoOutput)
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // 라이트 키기
    @objc func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
            print("Device does not support flashlight functionality.")
            return
        }
        
        do {
            try device.lockForConfiguration()
            
            if device.torchMode == .on {
                device.torchMode = .off
            } else {
                device.torchMode = .on
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error toggling flashlight: \(error.localizedDescription)")
        }
    }
    
    @objc func backToChallenge() {
        navigationController?.popViewController(animated: false)
    }
    
    // 챌린지 팝업 없애기, 카메라 찍는 화면에 유지
    @objc func backToCamera() {
        dismiss(animated: true, completion: nil)
    }
    
    // 챌린지 홈으로 돌아가기
    @objc func goToChallengeHome() {
        let challengeVC = ChallengeViewController()
        navigationController?.pushViewController(challengeVC, animated: false)
        self.dismiss(animated: true, completion: nil)
        // 확인 버튼 클릭시 챌린지 여부 false에서 true로 변경
    }
}
