import AVFoundation
import UIKit
import SnapKit
import AudioToolbox

class CallingViewController: UIViewController {
    let TAG = "CallingViewController"
    
    var screenWidth:CGFloat = 0
    var screenHeight: CGFloat = 0
    var timeEnlapsed:Int = 0;
    var timer:Timer?
    var minute:Int = 0
    var seconds:Int = 0
    var ratio:CGFloat = 0
    
    var ringTonePlayer: AVAudioPlayer?
    var enviromentPlayer: AVAudioPlayer?
    var callerVoicePlayer: AVAudioPlayer?
    
    var settingObject: SettingObject?
//    var homeViewModel: HomeViewModel?
    
    lazy var btnAccept: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(asset: Asset.icAccept), for: .normal)
        return btn
    }()
    
    lazy var btnDecline: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(asset: Asset.icDecline), for: .normal)
        return btn
    }()
    
    lazy var btnAlarm: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(asset: Asset.icAlarmClockWhite), for: .normal)
        return btn
    }()

    lazy var btnMessage: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(asset: Asset.icMessageWhite), for: .normal)
        return btn
    }()
    
    lazy var contactCalling: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 32)
        text.textAlignment = .center
        return text
    }()
    
    lazy var statusCalling: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle.apply(to: text)
        text.text = "Mobile"
        return text
    }()
    
    lazy var textImageAccept: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle.apply(to: text)
        text.text = L10n.Calling.accept
        return text
    }()
    
    lazy var textImageDecline: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle.apply(to: text)
        text.text = L10n.Calling.decline
        return text
    }()
    
    lazy var textImageAlarm: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle2.apply(to: text)
        text.text = L10n.Calling.remindMe
        return text
    }()
    
    lazy var textImageMessage: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle2.apply(to: text)
        text.text = L10n.Calling.message
        return text
    }()
    
    var buttonsControl:UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        UIApplication.shared.isIdleTimerDisabled = false
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        UIApplication.shared.isIdleTimerDisabled = true
        
        initViews()
        playRingtone()
        startVibration()
    }
    
    func startVibration() {
        if DataCallSetting.sharedData.settingObject.ringtoneIndex != 0 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onVibrate), userInfo: nil, repeats: true)
        }
    }
    
    @objc func onVibrate() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
    
    func initViews() {
        let screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            ratio = 1
        case .pad:
            ratio = 0.5
        default:
            ratio = 1
        }
        
        view.backgroundColor = UIColor.darkGray
        
        if let data = settingObject?.avatarData {
            print("set background nil")
            let avatarImageView = UIImageView(image: UIImage(data: data))
            self.view.addSubview(avatarImageView)
            avatarImageView.snp.makeConstraints{
                $0.width.height.equalToSuperview()
                $0.top.left.equalToSuperview()
            }
            avatarImageView.contentMode = .scaleAspectFill
            
            let darkView = UIView()
            self.view.addSubview(darkView)
            darkView.snp.makeConstraints{
                $0.width.height.equalToSuperview()
                $0.top.left.equalToSuperview()
            }
            darkView.backgroundColor = UIColor.black
            darkView.alpha = 0.7
        } else {
            print("set background default")
            let defaultBackground = UIImageView(image: UIImage(asset: Asset.wallpaper1))
            self.view.addSubview(defaultBackground)
            defaultBackground.snp.makeConstraints{
                $0.width.height.equalToSuperview()
                $0.top.left.equalToSuperview()
            }
            defaultBackground.contentMode = .scaleAspectFill
            defaultBackground.addBlurEffect()
        }
        
        self.view.addSubview(contactCalling)
        contactCalling.snp.makeConstraints{
            $0.top.equalToSuperview().offset(screenHeight*0.14*ratio)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(40)
            $0.width.equalTo(screenWidth)
        }
        
        contactCalling.text = settingObject?.contactName
        
        self.view.addSubview(statusCalling)
        statusCalling.snp.makeConstraints{
            $0.top.equalTo(contactCalling.snp.bottom).offset(5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(200)
        }
        
        self.view.addSubview(btnDecline)
        btnDecline.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-screenHeight*0.16)
            $0.height.width.equalTo(screenWidth*ratio/5)
            $0.leading.equalToSuperview().inset(screenWidth/6)
        }
        btnDecline.addTarget(self, action: #selector(onDeclineCall), for: .touchUpInside)
        
        self.view.addSubview(textImageDecline)
        textImageDecline.snp.makeConstraints{
            $0.top.equalTo(btnDecline.snp.bottom).offset(6)
            $0.width.equalTo(100)
            $0.centerX.equalTo(btnDecline)
        }
        
        self.view.addSubview(btnAccept)
        btnAccept.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-screenHeight*0.16)
            $0.height.width.equalTo(screenWidth*ratio/5)
            $0.trailing.equalToSuperview().inset(screenWidth/6)
        }
        btnAccept.addTarget(self, action: #selector(onAcceptCall), for: .touchUpInside)
        
        self.view.addSubview(textImageAccept)
        textImageAccept.snp.makeConstraints{
            $0.top.equalTo(btnAccept.snp.bottom).offset(6)
            $0.width.equalTo(100)
            $0.centerX.equalTo(btnAccept)
        }
        
        self.view.addSubview(btnAlarm)
        btnAlarm.snp.makeConstraints{
            $0.bottom.equalTo(btnDecline.snp.top).offset(-90)
            $0.height.width.equalTo(24)
            $0.centerX.equalTo(btnDecline.snp.centerX)
        }
        
        self.view.addSubview(textImageAlarm)
        textImageAlarm.snp.makeConstraints{
            $0.top.equalTo(btnAlarm.snp.bottom).offset(6)
            $0.width.equalTo(100)
            $0.centerX.equalTo(btnAlarm)
        }
        
        self.view.addSubview(btnMessage)
        btnMessage.snp.makeConstraints{
            $0.bottom.equalTo(btnAccept.snp.top).offset(-90)
            $0.height.width.equalTo(24)
            $0.centerX.equalTo(btnAccept.snp.centerX)
        }
        
        self.view.addSubview(textImageMessage)
        textImageMessage.snp.makeConstraints{
            $0.top.equalTo(btnMessage.snp.bottom).offset(6)
            $0.width.equalTo(100)
            $0.centerX.equalTo(btnMessage)
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let controlButtonSize = screenWidth*ratio*0.8/4
        layout.itemSize = CGSize(width: controlButtonSize, height: controlButtonSize+20)
        buttonsControl = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        buttonsControl?.register(CallingControlCell.self, forCellWithReuseIdentifier: CallingControlCell.TAG)
        buttonsControl.isHidden = true
        buttonsControl.backgroundColor = UIColor.clear
        self.view.addSubview(buttonsControl)
        buttonsControl.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(screenWidth*0.8*ratio)
            $0.height.equalTo(screenWidth*0.65*ratio)
        }
        buttonsControl.dataSource = self
        buttonsControl.delegate = self
        buttonsControl.bounces = false
    }

    @objc func onAcceptCall() {
        btnDecline.snp.removeConstraints()
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.btnDecline.snp.remakeConstraints{
                $0.bottom.equalToSuperview().offset(-self!.screenHeight*0.16)
                $0.width.height.equalTo(self!.screenWidth*self!.ratio/5)
                $0.centerX.equalToSuperview()
            }
            self?.view.layoutIfNeeded()
        }
        
        btnAccept.isHidden = true
        textImageAccept.isHidden = true
        btnMessage.isHidden = true
        textImageMessage.isHidden = true
        btnAlarm.isHidden = true
        textImageAlarm.isHidden = true
        buttonsControl.isHidden = false
        textImageDecline.isHidden = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        SoundUtils.stopAudio(audioPlayer: ringTonePlayer)
        playSoundEnviroment()
        playCallerVoice()
    }
    
    @objc func onTimerFires() {
        timeEnlapsed += 1
        minute = timeEnlapsed/60
        seconds = timeEnlapsed%60
        if seconds < 10 {
            statusCalling.text = "0\(minute):0\(seconds)"
        } else {
            statusCalling.text = "0\(minute):\(seconds)"
        }
        
        if timeEnlapsed >= 360 {
            exit(-1)
        }
    }
    
    @objc func onDeclineCall() {
        SoundUtils.stopAudio(audioPlayer: ringTonePlayer)
        SoundUtils.stopAudio(audioPlayer: enviromentPlayer)
        SoundUtils.stopAudio(audioPlayer: callerVoicePlayer)
        exit(-1)
    }
    
    func playSoundEnviroment() {
        let selectedSoundIndex:Int = settingObject?.enviromentIndex ?? 0
        
        if selectedSoundIndex > 0 {
            if let soundName = DataRepository.sharedData.enviromentUrls[selectedSoundIndex] {
                enviromentPlayer = SoundUtils.playAudio(url: soundName, volume: 0.1)
            }
        }
    }
    
    func playCallerVoice() {
        let selectedSoundIndex:Int = settingObject?.callerVoiceIndex ?? 0
        
        if selectedSoundIndex > 0 {
            if let soundName = DataRepository.sharedData.callerVoiceUrls[selectedSoundIndex] {
                callerVoicePlayer = SoundUtils.playAudio(url: soundName, volume: 0.4)
            }
        }
    }
    
    func playRingtone() {
        let selectedRingtoneIndex:Int = settingObject?.ringtoneIndex ?? 0
        
        if selectedRingtoneIndex > 1 {
            if let soundName = DataRepository.sharedData.ringtonesUrls[selectedRingtoneIndex] {
                ringTonePlayer = SoundUtils.playAudio(url: soundName, volume: 1)
            }
        }
    }
}

extension CallingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CallingControlCell.TAG, for: indexPath) as! CallingControlCell
        cell.cellIndex = indexPath.item
        return cell
    }
    
    
}

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
