//
//  WorkSpaceService.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/18/23.
//

import Foundation
import AppKit
import Combine

internal final class KindleNotesService {
	
	init(fileManager: FileManager,
		 nsOpenPanel: NSOpenPanel)
	{
		
		self.fileManager = fileManager
		self.nsOpenPanel = nsOpenPanel
	}
	
	//References
	let fileManager: FileManager
	let nsOpenPanel: NSOpenPanel
	
	//Properties
	@Published private final var selectedURL: URL?
}

//MARK: Interface
extension KindleNotesService: KindleNotesServiceProtocol {
	
	internal final func fetchNewKindleFile() {
		
		setup()
	}

	internal final var kindleURLBinding: Published<URL?>.Publisher {
		
		$selectedURL
	}
}

//MARK: Private Helpers
extension KindleNotesService {
	
	private final func setup() {
		
		setupFindKindlePath()
		setupOpenPanel()
	}
	
	private final func setupOpenPanel() {
		
		nsOpenPanel.canChooseDirectories = true
		nsOpenPanel.canChooseFiles = true
		nsOpenPanel.canCreateDirectories = false
		nsOpenPanel.allowsMultipleSelection = false
		nsOpenPanel.allowedContentTypes = [.text]
	}
	
	private final func setupFindKindlePath() {
		
		guard
			let mountedVolumeURLs = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: nil),
			let kindleURL = mountedVolumeURLs.kindle()
		else { return }

		setupLaunchOpenPanel(kindleURL: kindleURL)
	}
	
	//TODO: Move this to the view layer if possible
	private final func setupLaunchOpenPanel(kindleURL: URL) {
				
		nsOpenPanel.directoryURL = URL(fileURLWithPath: kindleURL.relativePath)
		
		nsOpenPanel.begin {
			
			[weak self]
			
			result in
			
			guard let self,
				  result == NSApplication.ModalResponse.OK,
				  let url = self.nsOpenPanel.urls.first
			else { return }

			self.setupCopyToDisk(selectedUrl: url)
		}
	}
	
	private final func setupCopyToDisk(selectedUrl: URL) {
		
		let clippingsURL = fileManager
			.homeDirectoryForCurrentUser
			.appending(path: Date.hyphenatedString())
			.appendingPathExtension(for: .text)
		
		do {
			
			try fileManager.copyItem(
				atPath: selectedUrl.relativePath,
				toPath: clippingsURL.relativePath)
			
			self.selectedURL = clippingsURL
			
		} catch let error {
			
			print(error)
		}
	}
}

//MARK: Protocols
protocol KindleNotesServiceProtocol {
	
	var kindleURLBinding: Published<URL?>.Publisher { get }
	func fetchNewKindleFile()
}

//MARK: Private Extensions
fileprivate extension Array<URL> {
	
	func kindle() -> Element? {
		
		for volumeURL in self {
			
			do {
				// Get the resource values for the volume
				let resourceValues = try volumeURL
					.resourceValues(forKeys: [.volumeNameKey, .volumeURLKey])
				
				// Get the volume name and URL
				if let volumeName = resourceValues.volumeName,
				   let volumeURL = resourceValues.volume,
				   volumeName == WorkSpaceKeys.kindle
				{
					
					let clippingsURL: URL = volumeURL
						.appending(path: WorkSpaceKeys.clippingsPath)

					return clippingsURL
				}
				
			} catch {
				
				print("Error getting resource values for volume: \(error)")
			}
		}
		
		return nil
	}
}

fileprivate enum WorkSpaceKeys {
	
	static let kindle = "Kindle"
	static let clippingsPath = "documents/My Clippings.txt"
	static let clippings = "clippings"
}
