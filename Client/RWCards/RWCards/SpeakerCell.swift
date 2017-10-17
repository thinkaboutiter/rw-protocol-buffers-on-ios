/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class SpeakerCell: UITableViewCell {
	
    // MARK: - Properties
	@IBOutlet fileprivate var containerView: UIView!
	@IBOutlet fileprivate var nameLabel: UILabel!
	@IBOutlet fileprivate var profileImageView: UIImageView!
	
    // MARK: - Life cycle
	override func awakeFromNib() {
		super.awakeFromNib()
		self.applyBusinessCardVisual()
	}
    
    // MARK: - Configurations
    fileprivate func applyBusinessCardVisual() {
        // Apply rounded corners
        self.containerView.layer.cornerRadius = 5
        self.containerView.layer.masksToBounds = true
        
        // Circular Profile Pic
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2.0
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.borderWidth = 2.0
        self.profileImageView.layer.borderColor = #colorLiteral(red: 0, green: 0.407166779, blue: 0.2167538702, alpha: 1).cgColor
    }
    
    func configure(with contact: Contact) {
        self.profileImageView.image = UIImage(named: contact.imageName)
        self.nameLabel.attributedText = NSAttributedString.attributedString(for: contact.firstName, and: contact.lastName)
    }
}
