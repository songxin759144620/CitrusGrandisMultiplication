//
//  OtherStoryViewController.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/6.
//

import UIKit

class OtherStoryViewController: AQBaseViewController {

    var drinkBarModel: DrinkBarModel = DrinkBarModel()
    
    
    @IBOutlet weak var dateBtn: UIButton!
    var addStoryBlock: ((DrinkBarModel)->Void)?
    
    @IBOutlet weak var imagev: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var addPictureBtn: UIButton!
    
    var timeStr: String? {
        didSet {
            drinkBarModel.date = timeStr
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBarType = .light
        titleStr = "Other Stories"
        showLeftBtn()
        rightBtnImage = "保存"
        
        titleField.delegate = self
        contentField.delegate = self
        dateBtn.addTapGesture {
            let dateView = MyDateView()
            dateView.delegate = self
            dateView.showView()
        }
        
        
        titleField.attributedPlaceholder = NSAttributedString(string: "Enter title",attributes: [.foregroundColor:UIColor.white])
        
        addPictureBtn.addTapGesture { [weak self] in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            self?.present(vc, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    override func rightBtnAction() {
        super.rightBtnAction()
        if titleField.text == "" {
            toast("Enter title")
            return
        }
        if contentField.text == "" {
            toast("Enter content")
            return
        }
        if drinkBarModel.img == nil {
            toast("Add picture")
            return
        }
        
        drinkBarModel.title = titleField.text
        drinkBarModel.des = contentField.text
        addStoryBlock?(drinkBarModel)
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OtherStoryViewController: MyDateViewDelegate {
    func pickDateView(year: Int, month: Int, day: Int) {
        timeStr = String(format: "%d-%02d-%02d", year,month,day)
        dateBtn.setTitle(timeStr, for: .normal)
    }
}

extension OtherStoryViewController: UITextFieldDelegate,UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing( true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

extension OtherStoryViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let path = (info[.imageURL] as? URL)?.absoluteString.replacingOccurrences(of: "file://", with: "")
        let sandboxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let toPath = sandboxPath?.appending("/\((info[.imageURL] as? URL)?.lastPathComponent ?? "")")
        try? AQFileManager.copyItem(atPath: path!, toPath: toPath!)
        drinkBarModel.img = toPath
        imagev.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
}
