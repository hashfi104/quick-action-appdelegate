//
//  QuickActionsHandler.swift
//  QuickActionSample
//
//  Created by Hashfi on 6/19/24.
//

import UIKit

class QuickActionsHandler {
    static let shared = QuickActionsHandler()

    private init() { }
    
    func createDefaultQuickActions() {
        // Initialize shortcut item with subtitle and system image
        let firstItem: UIApplicationShortcutItem = UIApplicationShortcutItem(
            type: ShortcutItemType.search.rawValue,
            localizedTitle: ShortcutItemTitle.search.rawValue,
            localizedSubtitle: "Ini Subtitle",
            icon: UIApplicationShortcutIcon(systemImageName: "magnifyingglass")
        )
        
        // Initialize shortcut item with subtitle and icon type
        let secondItem: UIApplicationShortcutItem = UIApplicationShortcutItem(
            type: ShortcutItemType.search.rawValue,
            localizedTitle: ShortcutItemTitle.search.rawValue,
            localizedSubtitle: "Ini Subtitle",
            icon: UIApplicationShortcutIcon(type: .search)
        )
        
        // Initialize shortcut item with subtitle and custom image
        let thirdItem: UIApplicationShortcutItem = UIApplicationShortcutItem(
            type: ShortcutItemType.search.rawValue,
            localizedTitle: ShortcutItemTitle.search.rawValue,
            localizedSubtitle: "Ini Subtitle",
            icon: UIApplicationShortcutIcon(templateImageName: "contact_center")
        )
        addShortcutItem(item: firstItem)
    }

    private func addShortcutItem(item: UIApplicationShortcutItem) {
        // Remove current item if any to avoid redundancy
        removeShortcutItem(item: item)

        // Add Item
        var currentItems: [UIApplicationShortcutItem] = UIApplication.shared.shortcutItems ?? []
        currentItems.append(item)
        UIApplication.shared.shortcutItems = currentItems
    }
    
    private func removeShortcutItem(item: UIApplicationShortcutItem) {
        var currentItems: [UIApplicationShortcutItem] = UIApplication.shared.shortcutItems ?? []
        if let itemIndex: Int = currentItems.firstIndex(where: { $0.type == item.type } ) {
            currentItems.remove(at: itemIndex)
        }
        UIApplication.shared.shortcutItems = currentItems
    }
    
    private func removeAllShortcutItem() {
        UIApplication.shared.shortcutItems = []
    }
}
