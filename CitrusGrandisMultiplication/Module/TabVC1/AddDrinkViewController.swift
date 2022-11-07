//
//  AddDrinkViewController.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/5.
//

import Foundation

class AddDrinkViewController: AQBaseViewController, UINavigationControllerDelegate {
    var addDrinkBlock: ((DrinkModel?)->Void)?
    
    var drinkModel: DrinkModel = DrinkModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = [bgImg]
        _ = NavBarHeight
        navBarType = .light
        showLeftBtn()
        titleStr = "Add Drinks"
        
        _ = [namePre, name, peifangPre, peifang, desPre, des, pricePre, price, photoView, saveBtn]
    }
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab1添加背景"))
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return img
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = 0x919e48.color
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.top.equalTo(NavBarHeight + 25)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        return v
    }()
    
    private lazy var namePre: UILabel = {
        let la = UILabel()
        la.text = "Drink name:"
        la.textColor = .white
        la.font = 16.font
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(30)
        }
        
        return la
    }()
    
    private lazy var name: CustomField = {
        let field = CustomField()
        field.font = 17.font
        field.delegate = self
        contentView.addSubview(field)
        field.snp.makeConstraints { make in
            make.bottom.equalTo(namePre)
            make.left.equalTo(namePre.snp.right).offset(25)
            make.right.equalToSuperview().offset(-35)
        }
        
        return field
    }()
    
    private lazy var peifangPre: UILabel = {
        let la = UILabel()
        la.text = "Ingred\nients:"
        la.numberOfLines = 0
        la.textColor = .white
        la.font = 16.font
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(namePre.snp.bottom).offset(20)
            make.width.equalTo(60)
        }
        
        return la
    }()
    
    private lazy var peifang: CustomField = {
        let field = CustomField()
        field.font = 17.font
        contentView.addSubview(field)
        field.snp.makeConstraints { make in
            make.bottom.equalTo(peifangPre)
            make.left.equalTo(peifangPre.snp.right).offset(25)
            make.right.equalToSuperview().offset(-35)
        }
        
        return field
    }()
    
    private lazy var desPre: UILabel = {
        let la = UILabel()
        la.text = "Copy:"
        la.numberOfLines = 0
        la.textColor = .white
        la.font = 16.font
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(peifangPre.snp.bottom).offset(20)
            make.width.equalTo(60)
        }
        
        return la
    }()
    
    private lazy var des: CustomField = {
        let field = CustomField()
        field.font = 17.font
        contentView.addSubview(field)
        field.snp.makeConstraints { make in
            make.bottom.equalTo(desPre)
            make.left.equalTo(desPre.snp.right).offset(25)
            make.right.equalToSuperview().offset(-35)
        }
        
        return field
    }()
    
    private lazy var pricePre: UILabel = {
        let la = UILabel()
        la.text = "Price:"
        la.numberOfLines = 0
        la.textColor = .white
        la.font = 16.font
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(desPre.snp.bottom).offset(20)
            make.width.equalTo(60)
        }
        
        return la
    }()
    
    private lazy var price: CustomField = {
        let field = CustomField()
        field.font = 17.font
        contentView.addSubview(field)
        field.snp.makeConstraints { make in
            make.bottom.equalTo(pricePre)
            make.left.equalTo(pricePre.snp.right).offset(25)
            make.right.equalToSuperview().offset(-35)
        }
        
        return field
    }()
    
    private lazy var photoView: UIImageView = {
        let photo = UIImageView()
        photo.layer.cornerRadius = 8
        photo.layer.masksToBounds = true
        photo.image = UIImage(named: "tab1添加背景图片")
        photo.contentMode = .scaleAspectFill
        photo.backgroundColor = 0xacbc56.color
        photo.addTapGesture { [weak self] in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            self?.present(vc, animated: true)
        }
        contentView.addSubview(photo)
        photo.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 90, height: 78))
            make.top.equalTo(pricePre.snp.bottom).offset(40)
            make.bottom.equalTo(-30)
        }
        
        return photo
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "保存"), for: .normal)
        btn.backgroundColor = 0xacbc56.color
        btn.layer.cornerRadius = 8
        btn.addTapGesture { [weak self] in
            if self?.name.text == "" {
                toast("please entry name")
                return
            }
            if self?.peifang.text == "" {
                toast("please entry Ingredients")
                return
            }
            if self?.des.text == "" {
                toast("please entry copy")
                return
            }
            if self?.price.text == "" {
                toast("please entry price")
                return
            }
            if self?.drinkModel.image == nil {
                toast("please choose photo")
                return
            }
            
            self?.drinkModel.price = self?.price.text
            self?.drinkModel.title = self?.name.text
            self?.drinkModel.subTitle = self?.peifang.text
            self?.drinkModel.content = self?.des.text
            self?.addDrinkBlock?(self?.drinkModel)
            self?.navigationController?.popViewController(animated: true)
        }
        contentView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 160, height: 64))
            make.right.equalTo(-25)
            make.bottom.equalTo(photoView)
        }
        
        return btn
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension AddDrinkViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension AddDrinkViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let path = (info[.imageURL] as? URL)?.absoluteString.replacingOccurrences(of: "file://", with: "")
        let sandboxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let toPath = sandboxPath?.appending("/\((info[.imageURL] as? URL)?.lastPathComponent ?? "")")
        try? AQFileManager.copyItem(atPath: path!, toPath: toPath!)
        drinkModel.image = "file:///\((info[.imageURL] as? URL)?.lastPathComponent ?? "")"
        photoView.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
}

class CustomField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        _ = line
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        self.addSubview(v)
        v.snp.makeConstraints { make in
            make.left.equalTo(-20)
            make.right.equalTo(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
        
        return v
    }()
}
