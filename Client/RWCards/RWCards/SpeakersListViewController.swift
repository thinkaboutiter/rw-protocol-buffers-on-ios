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

class SpeakersListViewController: UITableViewController {
	
    // MARK: - Properties
	var speakersModel: SpeakersViewModel?
	
	// MARK: Appearance
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
    // MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        
        self.fetchSpeakers()
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showCard" {
			if let vc = segue.destination as? CardViewController {
				vc.isCurrentUser = false
				vc.speaker = self.speakersModel?.selectedSpeaker
			}
		}
	}
}

// MARK: - UITableView DataSource
extension SpeakersListViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return speakersModel?.numberOfSections() ?? 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return speakersModel?.numberOfRows() ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakerCell", for: indexPath) as! SpeakerCell
        if let speaker: Contact = self.speakersModel?.getSpeaker(for: indexPath) {
            cell.configure(with: speaker)
        }
		return cell
	}
}

// MARK: - UITableView Delegate
extension SpeakersListViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // preselect speaker
        self.speakersModel?.selectSpeaker(for: indexPath)
        
		performSegue(withIdentifier: "showCard", sender: self)
	}
}

// MARK: - Networking
fileprivate extension SpeakersListViewController {
    
    func fetchSpeakers() {
        RWService.shared.getSpeakers(success: { (speakers: Speakers) in
            self.speakersModel = SpeakersViewModel(speakers: speakers)
            self.tableView.reloadData()
        }) { (error: NSError) in
            Logger.error.message("Error fetching speakers").object(error)
        }
    }
}
