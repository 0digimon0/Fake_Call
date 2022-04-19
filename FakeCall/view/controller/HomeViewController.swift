import UIKit
import SnapKit
import ContactsUI

class HomeViewController: UIViewController {
    static let TAG = "HomeViewController"
    
    let TIME_INDEX:Int = 1
    let CALLER_INDEX = 3
    let RINGTONE_INDEX:Int = 4
    let CALLER_VOICE_INDEX:Int = 5
    let ENVIROMENT_INDEX:Int = 6
    let WALLPAPER_INDEX:Int = 7
    
    var homeViewModel: HomeViewModel?
    var router: HomeRouter!
    var settingObject:SettingObject!
    
    var settingList: UITableView!
    
    var timeSelectedIndex = 0
    var ringtoneSelectedIndex = 0
    var enviromentSelectedIndex = 0
    var wallpaperSelectedIndex = 0
    var callerVoiveSelectedIndex = 0
    var callerInformation = ""
    var callerImageData: Data?
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router = HomeRouter()
        
        self.navigationItem.hidesBackButton = true
        let buttonDiscard = UIBarButtonItem(title: L10n.discard, style: .plain, target: self, action: #selector(onDiscardSetting))
        self.navigationItem.leftBarButtonItem = buttonDiscard
        
        let buttonStart = UIBarButtonItem(title: L10n.start, style: .plain, target: self, action: #selector(onStartFakeCall))
        self.navigationItem.rightBarButtonItem  = buttonStart
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        initSettingViews()
        
        if homeViewModel?.settingObject != nil {
            settingObject = homeViewModel?.settingObject
        } else {
            settingObject = SettingObject()
        }
        DataCallSetting.sharedData.settingObject = settingObject
    }
    
    func updateData() {
        
    }
    
    // MARK: call when select discard action bar button
    @objc func onDiscardSetting() {
        let alertController = UIAlertController(title: L10n.discard, message:
            L10n.Discard.caution, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: L10n.discard, style: .default, handler: { [unowned self] action in
            self.navigationController?.popViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: L10n.cancel, style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: call when select start action bar button
    @objc func onStartFakeCall() {
        let alertController = UIAlertController(title: L10n.caution, message:
            L10n.Setting.pleaseDoNotTurnOffScreen, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: L10n.startNow, style: .default, handler: { [unowned self] action in
            let router = HomeRouter()
            let vm = WaitingViewModel()
            vm.settingObject?.timerIndex = self.timeSelectedIndex
            vm.settingObject?.enviromentIndex = self.enviromentSelectedIndex
            vm.settingObject?.ringtoneIndex = self.ringtoneSelectedIndex
            vm.settingObject?.contactName = self.callerInformation
            vm.settingObject?.wallpaperIndex = self.wallpaperSelectedIndex
            vm.settingObject?.avatarData = self.callerImageData
            vm.settingObject?.contactName = self.callerInformation
            vm.settingObject?.callerVoiceIndex = self.callerVoiveSelectedIndex
            router.routeToWaitingScreen(viewModel: vm, from: self)
        }))
        alertController.addAction(UIAlertAction(title: L10n.cancel, style: .cancel))

        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: set enable/disable action bar button start
    func enableStartButton(isEnable: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = isEnable
    }
    
    func initSettingViews() {
        settingList = UITableView()
        settingList.showsVerticalScrollIndicator = false
        settingList.rowHeight = UITableView.automaticDimension
        settingList.estimatedRowHeight = 300
        settingList.separatorStyle = .singleLine
        
        settingList.register(TimerViewCell.self, forCellReuseIdentifier: TimerViewCell.identifier)
        settingList.register(SettingHeaderCell.self, forCellReuseIdentifier: SettingHeaderCell.identifier)
        settingList.register(CallerInformationCell.self, forCellReuseIdentifier: CallerInformationCell.identifier)
        settingList.register(RingtoneSelectionCell.self, forCellReuseIdentifier: RingtoneSelectionCell.identifier)
        settingList.register(VoiceSelectionCell.self, forCellReuseIdentifier: VoiceSelectionCell.identifier)
        settingList.register(EnviromentSelectionCell.self, forCellReuseIdentifier: EnviromentSelectionCell.identifier)
        settingList.register(MoreSettingCell.self, forCellReuseIdentifier: MoreSettingCell.identifier)
        settingList.register(WallpaperSelectionCell.self, forCellReuseIdentifier: WallpaperSelectionCell.identifier)
        
        settingList.delegate = self
        settingList.dataSource = self
        settingList.backgroundColor = MyColors.BackgroundColor
        settingList.keyboardDismissMode = .interactive
        settingList.tableFooterView = UIView()
        
        self.view.addSubview(settingList)
        settingList.snp.makeConstraints{(make) -> Void in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview().offset(0)
        }
    }
    
    // MARK: dismiss keyboard when touch out side
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("HomeController touchesBegan")
        view.endEditing(true)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: SettingHeaderCell.identifier, for: indexPath) as! SettingHeaderCell
            (cell as! SettingHeaderCell).setHeaderHeight(height: 35)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: TimerViewCell.identifier, for: indexPath) as! TimerViewCell
            let timeSelected = DataRepository.sharedData.getListTime()[timeSelectedIndex]
            (cell as! TimerViewCell).setSelectedValue(value: timeSelected)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: SettingHeaderCell.identifier, for: indexPath) as! SettingHeaderCell
            (cell as! SettingHeaderCell).setHeaderTitle(title: L10n.Header.basicSettings)
            (cell as! SettingHeaderCell).setHeaderHeight(height: 45)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: CallerInformationCell.identifier, for: indexPath) as! CallerInformationCell
            (cell as! CallerInformationCell).setSelectedValue(value: callerInformation)
            cell.selectionStyle = .none
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: RingtoneSelectionCell.identifier, for: indexPath) as! RingtoneSelectionCell
            let selectedValue = DataRepository.sharedData.getListRingtone()[ringtoneSelectedIndex]
            (cell as! RingtoneSelectionCell).setSelectedValue(value: selectedValue)
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: VoiceSelectionCell.identifier, for: indexPath) as! VoiceSelectionCell
            let selectedValue = DataRepository.sharedData.getListCallerVoice()[callerVoiveSelectedIndex]
            (cell as! VoiceSelectionCell).setSelectedValue(value: selectedValue)
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: EnviromentSelectionCell.identifier, for: indexPath) as! EnviromentSelectionCell
            let selectedValue = DataRepository.sharedData.getListEnviroment()[enviromentSelectedIndex]
            (cell as! EnviromentSelectionCell).setSelectedValue(value: selectedValue)
//            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 7:
            cell = tableView.dequeueReusableCell(withIdentifier: WallpaperSelectionCell.identifier, for: indexPath) as! WallpaperSelectionCell
            let selectedValue = DataRepository.sharedData.getListWallpaper()[wallpaperSelectedIndex]
            (cell as! WallpaperSelectionCell).setSelectedValue(value:  selectedValue)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 8:
            cell = tableView.dequeueReusableCell(withIdentifier: SettingHeaderCell.identifier, for: indexPath) as! SettingHeaderCell
            (cell as! SettingHeaderCell).setHeaderTitle(title: L10n.Header.advanceSettings)
            (cell as! SettingHeaderCell).setHeaderHeight(height: 35)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 9:
            cell = tableView.dequeueReusableCell(withIdentifier: MoreSettingCell.identifier, for: indexPath) as! MoreSettingCell
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case TIME_INDEX:
            let viewModel = SelectionNonPlayableViewModel()
            viewModel.selectedPosition = timeSelectedIndex
            viewModel.data = DataRepository.sharedData.getListTime()
            viewModel.settingType = Settings.Time
            router.routeToSelection(viewModel: viewModel, from: self, callback: self)
        case CALLER_INDEX:
            let viewModel = ContactInforViewModel()
            viewModel.contactName = callerInformation
            viewModel.contactImage = callerImageData
            router.routeToCallerScreen(viewModel: viewModel,from: self, callback: self)
        case CALLER_VOICE_INDEX:
            let viewModel = SelectionPlayableViewModel()
            viewModel.selectedPosition = callerVoiveSelectedIndex
            viewModel.data = DataRepository.sharedData.getListCallerVoice()
            viewModel.soundUrls = DataRepository.sharedData.callerVoiceUrls
            viewModel.settingType = Settings.CallerVoice
            router.routeToSelection(viewModel: viewModel, from: self, callback: self)
        case RINGTONE_INDEX:
            let viewModel = SelectionPlayableViewModel()
            viewModel.selectedPosition = ringtoneSelectedIndex
            viewModel.data = DataRepository.sharedData.getListRingtone()
            viewModel.soundUrls = DataRepository.sharedData.ringtonesUrls
            viewModel.settingType = Settings.Ringtone
            router.routeToRingtoneSelection(viewModel: viewModel, from: self, callback: self)
        case ENVIROMENT_INDEX:
            let viewModel = SelectionPlayableViewModel()
            viewModel.selectedPosition = enviromentSelectedIndex
            viewModel.data = DataRepository.sharedData.getListEnviroment()
            viewModel.soundUrls = DataRepository.sharedData.enviromentUrls
            viewModel.settingType = Settings.Enviroment
            router.routeToSelection(viewModel: viewModel, from: self, callback: self)
        case WALLPAPER_INDEX:
            let viewModel = WallpaperViewModel()
            viewModel.selectedPosition = wallpaperSelectedIndex
            router.routeToWallpaperScreen(viewModel: viewModel, from: self, callback: self)
            
        default:
//            data = []
            return
        }
        
        settingList.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewController: OptionSelected {
    func onOptionSelected(settingType: Settings, index selected: Int) {
        switch settingType {
        case .Time:
            timeSelectedIndex = selected
        case .Ringtone:
            ringtoneSelectedIndex = selected
        case .Enviroment:
            enviromentSelectedIndex = selected
        case .CallerVoice:
            callerVoiveSelectedIndex = selected
        case .Wallpaper:
            wallpaperSelectedIndex = selected
        default:
            print("")
        }
        
        settingList.reloadData()
    }
}

extension HomeViewController: CallerInformationSetting {
    func onInformationChanged(name: String, data: Data?) {
        if !callerInformation.elementsEqual(name) {
            callerInformation = name
            enableStartButton(isEnable: true)
            settingList.reloadData()
        }
        
        if data == nil {
            print("reset data")
        }
        callerImageData = data
    }
}

