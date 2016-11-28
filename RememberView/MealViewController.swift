//
//  MealViewController.swift
//  RememberView
//
//  Created by 桂鳳 on 2016/11/25.
//  Copyright © 2016年 Kelly. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  /*
   This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
   or constructed as part of adding a new meal.
   */
  
  var meal: Meal?
    
    // MARK: Outlets
    
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    
    // MARK: Actions
    
    @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        // hide the keyboard in case the user is typing in the test field
        textfieldName.resignFirstResponder()
        
        // create an image picker controller
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary   // only photos from library
        picker.delegate = self              // let vc deal with the phots selected
        
        // present the picker
        self.present(picker, animated: true, completion: nil)
    }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if sender as! UIBarButtonItem === buttonSave {
      let name = textfieldName.text ?? ""
      let photo = imgView.image
      let rating = ratingControl.rating
      
      // Set the meal to be passed to MealTableViewController after the unwind segue.
      meal = Meal(name: name, photo: photo, rating: rating)
    }
  }
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    
    // 先判斷進入此 controller 時，是用什麼方式
    let isInAddMealMode = presentingViewController is UINavigationController
    
    // 如果是「新增」模式，則 MealViewController 自己是包在一個 UINavigationController 裡面，並不會放入 navigation stack 中，必須用 dismiss 的方式
    // presentingVC = UINavigationController
    if isInAddMealMode {
      dismiss(animated: true, completion: nil)
    }
    
    // 如果是「編輯」模式，則會被放入 navigation stack 裡面，必須用 pop 的方式
    // presentingVC = nil
    else {
      navigationController!.popViewController(animated: true)
    }
    
    
  }
    
    // MARK: - Image Picker Controller Delegate
    
    // this method gives you a chance to dismiss the Image Picker Controller
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // the "info" dictrionay contains the original image, and an edited one (if exists)
        // this one uses the original
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Text Field Delegate
    
    // You need to specify that the text field should resign its first-responder status when the user taps a button to end editing in the text field. You do this in the textFieldShouldReturn(_:) method, which gets called when the user taps Return (or in this case, Done) on the keyboard.   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        textfieldName.resignFirstResponder()
        return true
    }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the Save button while editing.
    buttonSave.isEnabled = false
  }
  
  func checkValidMealName() {
    // Disable the Save button if the text field is empty.
    let text = textfieldName.text ?? ""
    buttonSave.isEnabled = !text.isEmpty
  }
    
    /* textFieldDidEndEditing(_:) is called after the text field resigns its first-responder status. This method will be called after the textFieldShouldReturn method. The textFieldDidEndEditing(_:) method gives you a chance to read the information entered into the text field and do something with it.
    */
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      checkValidMealName()
      navigationItem.title = textField.text
    }
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
      // super, self
      super.viewDidLoad()
      
      // image view
      imgView.layer.cornerRadius = 20
      
      // text field's delegate
      textfieldName.delegate = self
      
      // update view if meal exists
      if let meal = meal {
        
        textfieldName.text = meal.name
        imgView.image = meal.photo
        ratingControl.rating = meal.rating
        
        navigationItem.title = meal.name
      }
      
      // Enable Save button only if text field is valid.
      checkValidMealName()
    }

}

