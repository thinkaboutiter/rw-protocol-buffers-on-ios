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

import Foundation
import SimpleLogger

class SpeakersViewModel {
    
    // MARK: - Properties
    private(set) var speakers: Speakers
    private(set) var selectedSpeaker: Contact?
    
    // MARK: - Initializaiton
    init(speakers: Speakers) {
        self.speakers = speakers
    }
    
    deinit {
        Logger.debug.message("\(String(describing: SpeakersViewModel.self)) deinitialized")
    }
    
    // MARK: - TableView data
	func numberOfRows() -> Int {
		return self.speakers.contacts.count
	}
	
	func numberOfSections() -> Int {
		return 1
	}
    
    // MARK: - Custom accessors
    func getSpeaker(for indexPath: IndexPath) -> Contact? {
        // check index
        guard indexPath.item < self.speakers.contacts.count else {
            Logger.error.message("Index \(indexPath.item) out of bound \(self.speakers.contacts.count)")
            return nil
        }
        return self.speakers.contacts[indexPath.item]
    }
    
    func selectSpeaker(for indexPath: IndexPath) {
        self.selectedSpeaker = self.getSpeaker(for: indexPath)
    }
}
