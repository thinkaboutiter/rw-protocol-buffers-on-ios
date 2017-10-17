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
import SimpleLogger

class CardViewController: UIViewController {
	
	@IBOutlet var cardView: UIView!
	@IBOutlet var profileImageView: UIImageView!
	@IBOutlet var attendeeNameLabel: UILabel!
	@IBOutlet var twitterLabel: UILabel!
	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var githubLabel: UILabel!
	@IBOutlet var jobLabel: UILabel!
	@IBOutlet var attendeeTypeLabel: UILabel!
	
	@IBOutlet var backButton: UIButton!
	var isCurrentUser = true
    var speaker: Contact?
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		applyBusinessCardAppearance()
        backButton.isHidden = isCurrentUser
        
        if self.isCurrentUser {
            self.fetchCurrentUser()
        }
        else {
            if let valid_speaker: Contact = self.speaker {
                self.configure(with: valid_speaker)
            }
        }
	}
	
	// MARK: Appearance
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	func applyBusinessCardAppearance() {
		// Apply rounded corners
		cardView.layer.cornerRadius = 5
		cardView.layer.masksToBounds = true
		
		// Circular Profile Pic
		profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2.0
		profileImageView.clipsToBounds = true
		profileImageView.layer.borderWidth = 2.0
		profileImageView.layer.borderColor = #colorLiteral(red: 0, green: 0.407166779, blue: 0.2167538702, alpha: 1).cgColor
	}
	
	@IBAction func tapBack(_ sender: Any) {
		_ = navigationController?.popViewController(animated: true)
	}
}

// MARK: - Networking
fileprivate extension CardViewController {
    
    func fetchCurrentUser() {
        RWService.shared.getCurrentUser(success: { (contact: Contact) in
            self.configure(with: contact)
        }) { (error: NSError) in
            Logger.error.message("Error getting current user!").object(error)
        }
    }
}

// MARK: - UI configurations
fileprivate extension CardViewController {
    
    func configure(with contact: Contact) {
        self.attendeeNameLabel.attributedText = NSAttributedString.attributedString(for: contact.firstName, and: contact.lastName)
        self.twitterLabel.text = contact.twitterName
        self.emailLabel.text = contact.email
        self.githubLabel.text = contact.githubLink
        self.profileImageView.image = UIImage(named: contact.imageName)
        self.attendeeTypeLabel.text = contact.contactTypeToString()
    }
}

