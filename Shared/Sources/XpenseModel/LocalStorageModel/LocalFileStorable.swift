//
// This source file is part of the Apodini Xpense Example
//
// SPDX-FileCopyrightText: 2018-2021 Paul Schmiedmayer and project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation


// MARK: - LocalFileStorable
/// An object that can be represented and stored as a local file
public protocol LocalFileStorable: Codable, Hashable {
    /// The file name that should be used to store the elements on the local storage
    static var fileName: String { get }
}


// MARK: LocalFileStorable + Default Implementation
extension LocalFileStorable {
    /// The file name that should be used to store the elements on the local storage
    public static var fileName: String {
        "\(Self.self)s"
    }
}


// MARK: LocalFileStorable + Local Storage URL
extension LocalFileStorable {
    /// The URL of the parent folder to store the LocalFileStorable in
    static var localStorageURL: URL {
        guard let applicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Can't access the application support directory directory.")
        }
        let xpenseDirectory = applicationSupportDirectory.appendingPathComponent("Xpense")
        
        if !FileManager.default.fileExists(atPath: xpenseDirectory.path) {
            do {
                try FileManager.default.createDirectory(atPath: xpenseDirectory.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError("Can't create a subfolder in the application support directory directory.")
            }
        }
        
        return xpenseDirectory.appendingPathComponent(Self.fileName).appendingPathExtension("json")
    }
}


// MARK: LocalFileStorable + Load & Save
extension LocalFileStorable {
    ///  Load an array of `LocalFileStorables` from a file
    ///  - Returns: An array of deserialised objects
    public static func loadFromFile() -> Set<Self> {
        do {
            return try JSONDecoder().decode(Set<Self>.self, from: try Data(contentsOf: Self.localStorageURL))
        } catch {
            print("Could not load \(Self.self)s, the Model uses an empty collection: \(error)")
            return []
        }
    }
    
    /// Save a collection of `LocalFileStorables` to a file
    /// - Parameters:
    ///    - collection: Collection of objects to be saved
    public static func saveToFile(_ collection: Set<Self>) {
        do {
            let data = try JSONEncoder().encode(collection)
            try data.write(to: Self.localStorageURL)
        } catch {
            print("Could not save \(Self.self)s: \(error)")
        }
    }
    
    /// Removes the local file that is associated with that type conforming to `LocalFileStorables`
    public static func removeFile() {
        try? FileManager.default.removeItem(at: localStorageURL)
    }
}


// MARK: - Array + LocalFileStorable Extension
extension Set where Element: LocalFileStorable {
    /// Saves an array of LocalFileStorables to a file
    public func saveToFile() {
        Element.saveToFile(self)
    }
}
