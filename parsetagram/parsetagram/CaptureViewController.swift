//
//  CaptureViewController.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var photo: UIImage?
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if photo == nil {
            uploadButton.backgroundColor = UIColor.darkGray
            uploadButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            uploadButton.setBackgroundImage(photo, for: .normal)
            uploadButton.setTitleColor(UIColor.clear, for: .normal)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUpload(_ sender: Any) {
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            uploadButton.setBackgroundImage(image, for: .normal)
            uploadButton.setTitle("", for: .normal)
            uploadButton.setTitleColor(UIColor.clear, for: .normal)
            photo = image
            dismiss(animated:true, completion: nil)
        }
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        if photo == nil {
            let alertController = UIAlertController(title: "Upload error", message: "Please upload a photo before submitting.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            print("No photo")
            return
        }
        
        if (captionTextField.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Submission Error", message: "Please enter a caption", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            print("No caption")
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Post.postUserImage(image: resize(image: self.photo!, newSize: CGSize.init(width: 152.5, height: 152.5)), withCaption: self.captionTextField.text!) { (result: Bool, error: Error?) in
            if error == nil {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("success uploading post")
                self.performSegue(withIdentifier: "onUploadSuccessSegue", sender: nil)
            }
        }
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
