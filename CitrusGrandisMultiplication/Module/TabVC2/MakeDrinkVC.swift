//
//  MakeDrinkVC.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/5.
//

import UIKit

class MakeDrinkVC: AQBaseViewController {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var tipsTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var starSuper: UIView!
    
    var star: Int = 0
    
    var saveBlock: ((MakeModel)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarType = .light
        showLeftBtn()
        titleStr = "Make"
        
        titleTextField.delegate = self
        textView.delegate = self
        tipsTextField.delegate = self
        
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Enter title",attributes: [.foregroundColor:mainColor])
        tipsTextField.attributedPlaceholder = NSAttributedString(string: "Enter tips",attributes: [.foregroundColor:mainColor])
        
        
        // Do any additional setup after loading the view.
        
        let starView = StarView(frame: CGRect(x: 125, y: 10, width: 150, height: 40), index: 0, isCanEdit: true)
        starView.starEvaluationTapBlock = { [weak self] view,index in
            self?.star = index
        }
        starSuper.addSubview(starView)
        
        saveBtn.setTitle("", for: .normal)
        saveBtn.addTapGesture { [weak self] in
            guard let self = self else { return }
            if self.titleTextField.text == "" {
                toast("Enter title")
                return
            }
            if self.textView.text == "" {
                toast("Enter step")
                return
            }
            if self.tipsTextField.text == "" {
                toast("Enter tips")
                return
            }
            
            self.saveBlock?(MakeModel(title: self.titleTextField.text, step: self.textView.text,tips: self.tipsTextField.text,stars: self.star))
            
            self.navigationController?.popViewController(animated: true)
        }
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

extension MakeDrinkVC: UITextFieldDelegate,UITextViewDelegate {
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
