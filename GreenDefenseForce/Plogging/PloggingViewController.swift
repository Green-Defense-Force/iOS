//
//  PloggingViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/10/23.
//

import UIKit
import MapKit
import CoreLocation

class PloggingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    var ploggingStartTime: Date?
    
    // delegate -> 위치정보 파악에 필요
    let locationManager = CLLocationManager()
    // 사용자의 이동 경로를 저장할 배열
    var userPath: [CLLocationCoordinate2D] = []
    // CLLocation 객체를 저장하는 배열
    var userLocations: [CLLocation] = []
    
    // 컨텐츠 부분
    lazy var mapView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    // 지도 뷰
    let map: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.translatesAutoresizingMaskIntoConstraints = false
        // 사용자의 현재 위치 표시
        map.showsUserLocation = true
        // 유저의 위치를 추적
        map.setUserTrackingMode(.followWithHeading, animated: true)
        return map
    }()
    
    // 타이틀
    lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = UIColor(
            red: 77/255.0,
            green: 133/255.0,
            blue: 218/255.0,
            alpha: 1.0
        )
        titleLabel.text = "플로깅"
        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(30)
        titleLabel.textAlignment = .center
        
        subTitleLabel.text = "Plogging : 쓰레기를 주우며 조깅"
        subTitleLabel.textColor = .white
        subTitleLabel.font = subTitleLabel.font.withSize(20)
        subTitleLabel.textAlignment = .center
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(subTitleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
        ])
        
        return titleView
    }()
    
    lazy var buttonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // 버튼 컨테이너 설정
        return view
    }()
    
    lazy var startBtn: UIButton = {
        // 플로깅 시작
        // 타이머 돌아가고
        // 이동 경로 표시
        // 거리, 속도 계산 시작
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "ploggingStart"), for: .normal)
        btn.addTarget(self, action: #selector(startPlogging), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var endBtn: UIButton = {
        // 서버에 유저 아이디, 거리, 속도 전달해야 되는 부분이긴 함.
        // 지금은 다시 초기화면으로 돌아가게 (모달 나오는 화면)
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "ploggingControlBtn"), for: .normal)
        btn.setTitle("종료하기", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return btn
    }()
    
    lazy var goCameraBtn: UIButton = {
        // 촬영하는 화면으로 이동
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "ploggingControlBtn"), for: .normal)
        btn.setTitle("촬영하기", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.addTarget(self, action: #selector(goToCamera), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        checkUserLocation()
        map.delegate = self // MKMapView delegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        presentModal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        CustomTabBarViewController.shared.customTabBar.isHidden = false
    }
    
    func setUI() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        mapView.addSubview(map)
        mapView.addSubview(titleView)
        mapView.addSubview(buttonContainer)
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: mapView.topAnchor),
            map.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            map.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            map.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            
            titleView.topAnchor.constraint(equalTo: mapView.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.2),
            
            buttonContainer.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -100),
            buttonContainer.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            buttonContainer.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            buttonContainer.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.2)
        ])
        
        buttonContainer.addSubview(startBtn)
        buttonContainer.addSubview(endBtn)
        buttonContainer.addSubview(goCameraBtn)
        NSLayoutConstraint.activate([
            // endBtn 제약조건
            endBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            endBtn.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 20), // 왼쪽 정렬
            endBtn.widthAnchor.constraint(equalToConstant: 100),
            endBtn.heightAnchor.constraint(equalToConstant: 50),
            
            // startBtn 제약조건
            startBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            startBtn.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor), // 중앙 정렬
            startBtn.widthAnchor.constraint(equalToConstant: 100),
            startBtn.heightAnchor.constraint(equalToConstant: 100),
            
            // goCameraBtn 제약조건
            goCameraBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            goCameraBtn.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -20), // 오른쪽 정렬
            goCameraBtn.widthAnchor.constraint(equalToConstant: 100),
            goCameraBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func checkUserLocation() {
        locationManager.delegate = self
        
        // 위치 서비스 사용 권한 확인
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            // 권한 요청을 비동기적으로 메인 스레드에서 실행
            DispatchQueue.main.async {
                self.locationManager.requestWhenInUseAuthorization()
            }
        } else {
            // 위치 서비스가 비활성화 되어 있을 경우 처리
            print("위치 서비스를 활성화 해주세요.")
        }
    }
    
    // CLLocationManagerDelegate 메서드: 위치 업데이트 시 호출됨
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        // 사용자의 이동 경로에 현재 위치를 추가
        userPath.append(userLocation.coordinate)
        
        // CLLocation 객체 추가
        userLocations.append(userLocation)
        
        // 이동 경로가 변경되면 폴리라인 업데이트
        updatePolyline()
        
        // 맵의 중심을 사용자의 최신 위치로 설정
        map.setCenter(userPath.last!, animated: true)
        
        if let startTime = ploggingStartTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            updateElapsedTimeLabel(elapsedTime) // 경과 시간 업데이트
        }
    }
    
    func updateElapsedTimeLabel(_ elapsedTime: TimeInterval) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        titleLabel.text = formatter.string(from: elapsedTime)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 45)
    }
    
    func updatePolyline() {
        // 기존의 폴리라인이 있다면 업데이트하고, 없다면 새로 생성
        if map.overlays.first(where: { $0 is MKPolyline }) == nil {
            let polyline = MKPolyline(coordinates: userPath, count: userPath.count)
            map.addOverlay(polyline)
        } else {
            map.removeOverlays(map.overlays)
            let polyline = MKPolyline(coordinates: userPath, count: userPath.count)
            map.addOverlay(polyline)
        }
    }
    
    // CLLocationManagerDelegate 메서드: 권한 변경 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            // 필요한 경우 권한이 없을 때의 처리 로직 추가
            break
        }
    }
    
    // MKMapViewDelegate 메서드: 폴리라인 렌더링을 위해 호출됨
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    // 총 이동 거리를 계산하는 메서드
    func calculateTotalDistance() -> Double {
        guard userLocations.count > 1 else { return 0 }
        var totalDistance = 0.0
        for i in 1..<userLocations.count {
            totalDistance += userLocations[i - 1].distance(from: userLocations[i])
        }
        return totalDistance
    }
    
    // 평균 속도를 계산하는 메서드
    func calculateAverageSpeed() -> Double {
        let totalTime = userLocations.count > 1 ? userLocations.last!.timestamp.timeIntervalSince(userLocations.first!.timestamp) : 0
        let totalDistance = calculateTotalDistance() // 미터 단위
        return totalTime > 0 ? totalDistance / totalTime : 0 // 초당 미터
    }
    
    func presentModal() {
        let modalVC = PloggingModalViewController()
        modalVC.modalPresentationStyle = .formSheet
        // delegate말고 이렇게도 가능한데, 이부분에 대해서 더 공부해보자,
        // 더 간결해서 쉬운거 같다.
        modalVC.onConfirm = { [weak self] in
            self?.titleLabel.text = "플로깅"
            self?.subTitleLabel.text = "Plogging : 쓰레기를 주우며 조깅"
            self?.endBtn.isHidden = true
            self?.goCameraBtn.isHidden = true
        }
        present(modalVC, animated: false, completion: nil)
    }
    
    // 종료하기 버튼에 모달 띄우고, 속도, 거리 지우고 기본 타이틀로 바꾸고, 좌우 버튼 가리기
    @objc func reset() {
        presentModal()
        endBtn.isHidden = true
        goCameraBtn.isHidden = true
    }
    
    @objc func startPlogging() {
        if ploggingStartTime == nil {
            // 플로깅이 시작되지 않았을 때
            endBtn.isHidden = true
            goCameraBtn.isHidden = true
            startBtn.setBackgroundImage(UIImage(named: "ploggingPause"), for: .normal) // 일시정지 이미지로 변경
            ploggingStartTime = Date() // 플로깅 시작 시간 기록
            locationManager.startUpdatingLocation() // 위치 업데이트 시작
            subTitleLabel.text = ""
            
            startBtn.isUserInteractionEnabled = true
            CustomTabBarViewController.shared.customTabBar.isUserInteractionEnabled = false

        } else {
            // 플로깅이 이미 시작된 경우
            endBtn.isHidden = false
            goCameraBtn.isHidden = false
            startBtn.setBackgroundImage(UIImage(named: "ploggingStart"), for: .normal) // 시작 이미지로 변경
            
            // 총 이동 거리와 평균 속도 계산
            let totalDistance = calculateTotalDistance()
            let averageSpeed = calculateAverageSpeed()
            
            // 거리와 속도를 소수점 둘째자리까지 포맷팅
            let formattedDistance = String(format: "%.2f m", totalDistance)
            let formattedSpeed = String(format: "%.2f m/s", averageSpeed)
            
            // 타이틀 레이블 업데이트
            titleLabel.text = "거리: \(formattedDistance)"
            subTitleLabel.text = "속도: \(formattedSpeed)"
            
            // 플로깅 중지
            ploggingStartTime = nil
            locationManager.stopUpdatingLocation()
            
            CustomTabBarViewController.shared.customTabBar.isUserInteractionEnabled = true
        }
    }
    
    @objc func goToCamera() {
        let ploggingCameraVC = PloggingCameraViewController()
        navigationController?.pushViewController(ploggingCameraVC, animated: false)
    }
}
