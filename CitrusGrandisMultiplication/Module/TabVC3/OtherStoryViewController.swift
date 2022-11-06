//
//  OtherStoryViewController.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/6.
//

import UIKit

class OtherStoryViewController: AQBaseViewController {

    var drinkBarModel: DrinkBarModel = DrinkBarModel()
    
    var addStoryBlock: ((DrinkBarModel)->Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var addPictureBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navBarType = .light
        titleStr = "Other Stories"
        showLeftBtn()
        rightBtnImage = "保存"
        
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
        if dateField.text == "" {
            toast("Enter date")
            return
        }
        if drinkBarModel.img == nil {
            toast("Add picture")
            return
        }
        
        drinkBarModel.title = titleField.text
        drinkBarModel.des = contentField.text
        drinkBarModel.date = dateField.text
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

extension OtherStoryViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let path = (info[.imageURL] as? URL)?.absoluteString
        drinkBarModel.img = path
        picker.dismiss(animated: true)
    }
}
