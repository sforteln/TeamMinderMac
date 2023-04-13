//
//  ImportUser.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 4/11/23.
//

import SwiftUI
import UniformTypeIdentifiers
/**
 Import user UI and functions
 */
func showImportPanel() -> [URL]? {
    let openPanel = NSOpenPanel()
    openPanel.allowedContentTypes = [UTType.json]
    openPanel.allowsMultipleSelection = false
    openPanel.canChooseDirectories = false
    openPanel.canChooseFiles = true
    let response = openPanel.runModal()
    return response == .OK ? openPanel.urls : nil
}

func importUser(toTeam: Team) {
    guard let importURLs = showImportPanel() else{
        return
    }
    
    let decoder = JSONDecoder()
    for url in importURLs {
        guard url.isFileURL else {
            return
        }
        do {
            let memberData = try Data(contentsOf: url)
            let member = try decoder.decode(TeamMember.self, from: memberData)
            toTeam.addMember(member: member)
        } catch {
            print(error)
        }
    }
}

/**
 Export user UI and functions
 */
func exportUser(member: TeamMember) {
    guard let saveURL = showExportPanel() else{
        return
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        let data = try encoder.encode(member)
        try data.write(to: saveURL)
    } catch {
        print(error)
    }
}

func showExportPanel() -> URL? {
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = [UTType.json]
    savePanel.canCreateDirectories = true
    savePanel.isExtensionHidden = false
    savePanel.allowsOtherFileTypes = false
    savePanel.title = "Export the team members data"
    savePanel.message = "Choose a folder and a name for the json file."
    savePanel.nameFieldLabel = "File name:"
    let response = savePanel.runModal()
    return response == .OK ? savePanel.url : nil
}
