//
//  GGEditViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGEditViewController: GGBaseViewController {

    var image: UIImage?
    let bgImageView = UIImageView()
    let contentImageView = UIImageView()
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var btn1: QMUIButton!
    @IBOutlet weak var btn2: QMUIButton!
    @IBOutlet weak var btn3: QMUIButton!
    @IBOutlet weak var btn4: QMUIButton!
    @IBOutlet weak var btn5: QMUIButton!
    // v1
    var modeView: GGModeBGView?
    // v2
    var backgroundView: GGBackgroundBGView?
    // v3
    var stickerView: GGStickerBGView?
    // v4
    var filterView: GGFilterBGView?
    
    var selectSticker: StickerView?
    var simage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Edit"
        view.backgroundColor = UIColor.qmui_color(withHexString: "#F9F9F9")
        toolsView.isHidden = true
        btn1ModeChanged()
        btn2ModeChanged()
        btn3ModeChanged()
        btn4ModeChanged()
    }
    override func initSubviews() {
        super.initSubviews()
        btn1.imagePosition = .top
        btn2.imagePosition = .top
        btn3.imagePosition = .top
        btn4.imagePosition = .top
        btn5.imagePosition = .top
        btn1.spacingBetweenImageAndTitle = 10
        btn2.spacingBetweenImageAndTitle = 10
        btn3.spacingBetweenImageAndTitle = 10
        btn4.spacingBetweenImageAndTitle = 10
        btn5.spacingBetweenImageAndTitle = 10
        imageContainerView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        imageContainerView.contentMode = .scaleAspectFill
        imageContainerView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        contentImageView.contentMode = .scaleToFill
        contentImageView.layer.masksToBounds = true
        contentImageView.image = image

        // 1 Mode
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 154)
        let v1 = GGModeBGView(frame: frame)
        modeView = v1
        v1.isHidden = true
        toolsView.addSubview(v1)
        // 2 Background
        let v2 = GGBackgroundBGView(frame: frame)
        backgroundView = v2
        v2.isHidden = true
        toolsView.addSubview(v2)
        // 3 Sticker
        let v3 = GGStickerBGView(frame: frame)
        stickerView = v3
        v3.isHidden = true
        toolsView.addSubview(v3)
        // 4 Filter
        let v4 = GGFilterBGView(frame: frame)
        filterView = v4
        v4.isHidden = true
        toolsView.addSubview(v4)
        
        v1.backgroundColor = toolsView.backgroundColor
        v2.backgroundColor = toolsView.backgroundColor
        v3.backgroundColor = toolsView.backgroundColor
        v4.backgroundColor = toolsView.backgroundColor
        
        // right item
        
        // right
        let rightBtn = QMUIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "icon_edit_see"), for: .normal)
        rightBtn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        rightBtn.addTarget(self, action: #selector(showOriginImage), for: .touchDown)
        rightBtn.addTarget(self, action: #selector(hiddenOriginimage), for: .touchUpInside)
    }
    @IBAction func clickBtn1(_ sender: Any) {
        modeView?.isHidden = false
        if let tv = modeView {
            toolsView.bringSubviewToFront(tv)
        }
        toolsView.isHidden = false
    }
    @objc func showOriginImage() {
        simage = saveImage()
        contentImageView.image = image
    }
    @objc func hiddenOriginimage() {
        contentImageView.image = simage
    }
    func hiddenModeView () {
        modeView?.isHidden = true
        if let tv = modeView {
            toolsView.sendSubviewToBack(tv)
        }
        toolsView.isHidden = true
    }
    @IBAction func clickBtn2(_ sender: Any) {
        backgroundView?.isHidden = false
        if let tv = backgroundView {
            toolsView.bringSubviewToFront(tv)
        }
        toolsView.isHidden = false
    }
    func hiddenBGView() {
        backgroundView?.isHidden = true
        if let tv = backgroundView {
            toolsView.sendSubviewToBack(tv)
        }
        toolsView.isHidden = true
    }
    @IBAction func clickBtn3(_ sender: Any) {
        stickerView?.isHidden = false
        if let tv = stickerView {
            toolsView.bringSubviewToFront(tv)
        }
        toolsView.isHidden = false
    }
    
    func hiddenStickerView() {
        stickerView?.isHidden = true
        if let tv = stickerView {
            toolsView.sendSubviewToBack(tv)
        }
        toolsView.isHidden = true
    }
    @IBAction func clickBtn4(_ sender: Any) {
        filterView?.isHidden = false
        if let tv = filterView, let simage = contentImageView.image {
            toolsView.bringSubviewToFront(tv)
            filterView?.fillImage(simage)
        }
        toolsView.isHidden = false
    }
    func hiddenFilterView() {
        filterView?.isHidden = true
        if let tv = filterView {
            toolsView.sendSubviewToBack(tv)
        }
        toolsView.isHidden = true
    }
    @IBAction func clickBtn5(_ sender: Any) {
        // use coin to save
        let alert = QMUIAlertController(title: "Save Image", message: "Speed 3000 gold coins to save image", preferredStyle: .alert)
        alert.addAction(QMUIAlertAction(title: "determine", style: .default, handler: { (_, _) in
            print("determine")
            self.payAndSave()
        }))
        alert.addCancelAction()
        alert.showWith(animated: true)
    }
    func btn1ModeChanged() {
        modeView?.clickDownHandler = {[weak self] in
            guard let sself = self else {
                return
            }
            sself.hiddenModeView()
        }
        modeView?.clickBlock = { [weak self] (data) in
            guard let sself = self, let simage = data, let originImage = sself.image else {
                return
            }
            // 生成遮罩层图片
            let nImage = UIImage.creatImage(withMaskImage: simage, andBackimage: originImage)
            sself.contentImageView.image = nImage
        }
        // 默认生成一个
        guard let mImage = modeView?.dataModel.modeBGs[0], let originImage = image else {
            return
        }
        let nImage = UIImage.creatImage(withMaskImage: mImage, andBackimage: originImage)
        contentImageView.image = nImage
    }
    func btn2ModeChanged() {
        backgroundView?.clickDownHandler = {[weak self] in
            guard let sself = self else {
                return
            }
            sself.hiddenBGView()
        }
        backgroundView?.clickBlock = { [weak self] (data) in
            guard let sself = self, let sColor = data else {
                return
            }
            sself.contentImageView.backgroundColor = sColor
        }
    }
    func btn3ModeChanged() {
        stickerView?.clickDownHandler = {[weak self] in
            guard let sself = self else {
                return
            }
            sself.hiddenStickerView()
        }
        stickerView?.clickBlock = { [weak self] (data) in
            guard let sself = self, let sImage = data else {
                return
            }
            
            sself.addStickerView(sImage)
        }
    }
    func btn4ModeChanged() {
        filterView?.clickDownHandler = {[weak self] in
            guard let sself = self else {
                return
            }
            sself.hiddenFilterView()
        }
        filterView?.clickBlock = { [weak self] (data) in
            guard let sself = self, let sImage = data else {
                return
            }
            sself.contentImageView.image = sImage
        }
    }
    func addStickerView(_ image: UIImage) {
        let stickerView = StickerView(contentFrame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), contentImage: image)
        stickerView?.enabledControl = false
        stickerView?.enabledBorder = false
        stickerView?.delegate = self as StickerViewDelegate
        stickerView?.performTapOperation()
        imageContainerView.addSubview(stickerView!)
        stickerView?.center = imageContainerView.center
        selectSticker = stickerView
    }
    
    func payAndSave() {
        if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
            if Int(goldNumber) ?? 0 < 3000 {
                let vc = GGGoldViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                JPToast.showLoading("Saving")
                UserDefaults.standard.setValue("\(Int(goldNumber)! - 3000)", forKey: kIAPDefaultGoldNumber)
                simage = saveImage()
                if let saveImage = simage {
                    UIImageWriteToSavedPhotosAlbum(saveImage, self, #selector(imageSaveFinished(image:error:context:)), nil)
                }
            }
        }
    }
    @objc func imageSaveFinished(image: UIImage, error: Error, context: UnsafeRawPointer) {
        JPToast.hidLoading()
        let vc = GGSaveViewController()
        vc.image = simage
        navigationController?.pushViewController(vc, animated: true)
    }
    func saveImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentImageView.frame.size,false, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        contentImageView.layer.render(in: context)
        let snapShotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapShotImage
    }
}
extension GGEditViewController: StickerViewDelegate {

    func stickerViewDidTapContentView(_ stickerView: StickerView!) {
        if let sticker = selectSticker {
            sticker.enabledControl = false
            sticker.enabledBorder = false
        } else {
            selectSticker = stickerView
            selectSticker?.enabledBorder = true
            selectSticker?.enabledControl = true
        }
    }
    func stickerViewDidTapDeleteControl(_ stickerView: StickerView!) {
        for subView in imageContainerView.subviews {
            if let sv = subView as? StickerView {
                sv.performTapOperation()
                break
            }
        }
    }
}
