//
//  CaptureViewController.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit

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
        
        Post.postUserImage(image: self.photo!, withCaption: self.captionTextField.text!) { (result: Bool, error: Error?) in
            if error == nil {
                print("success uploading post")
                self.performSegue(withIdentifier: "onUploadSuccessSegue", sender: nil)
            }
        }
        
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
