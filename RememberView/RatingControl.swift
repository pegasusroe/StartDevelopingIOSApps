//
//  RatingControl.swift
//  RememberView
//
//  Created by 桂鳳 on 2016/11/25.
//  Copyright © 2016年 Kelly. All rights reserved.
//

import UIKit

class RatingControl: UIView {
  
  // MARK: Properties
  
  var rating = 0 {
    didSet { updateButtonSelectionStates() }
  }
  
  var buttons = [UIButton]()
  
  let spacing = 5
  let starCount = 5

  // MARK: - Init
  
  required init?(coder aDecoder: NSCoder) {
    
    //super
    super.init(coder: aDecoder)
    
    // 將背景變為透明
    self.backgroundColor = .clear
      
    // buttons
    let imgStarFilled = UIImage(named: "filledStar")
    let imgStarEmpty = UIImage(named: "emptyStar")
    
    for _ in 0 ..< starCount {
      
      let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
      
      btn.setImage(imgStarEmpty, for: .normal)      //  unselected
      btn.setImage(imgStarFilled, for: .selected)
      btn.setImage(imgStarFilled, for: [.highlighted, .selected]) // user is tapping
      
      // make sure the image doesn’t show an additional highlight during the state change.
      btn.adjustsImageWhenHighlighted = false
      
      btn.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
      buttons += [btn]
      
      addSubview(btn)
    }
    
  }
    
  // MARK: - Methods

  // To tell the stack view how to lay out button, we need to provide an intrinsic content size for it.
  override var intrinsicContentSize: CGSize {
    get {
      let h = Int(self.frame.size.height)
      let w = h + (h + spacing) * (starCount - 1)
      return CGSize(width: w, height: h)
    }
  }
  
  // gets called at the appropriate time by the system and gives UIView subclasses a chance to perform a precise layout of their subviews.
  override func layoutSubviews() {
    
    // 將 button 的尺寸設為 RatingControl 的高度
    let h = Int(self.frame.size.height)
    var frame = CGRect(x: 0, y: 0, width: h, height: h)
    
    for (i, btn) in buttons.enumerated() {
      frame.origin.x = CGFloat(i * (h + spacing))
      btn.frame = frame
    }
    
    updateButtonSelectionStates()
  }
  
  // MARK: Button Actions
  
  func ratingButtonTapped(_ sender: UIButton) {
    rating = buttons.index(of: sender)! + 1
    //updateButtonSelectionStates()
    print("star tapped: \(rating)")
  }
  
  func updateButtonSelectionStates() {
    for (i, btn) in buttons.enumerated() {
      btn.isSelected = i < rating
    }
  }

}
