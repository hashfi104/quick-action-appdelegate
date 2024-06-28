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
        // Initialize shortcut item with subtitle
        let item: UIApplicationShortcutItem = UIApplicationShortcutItem(
            type: ShortcutItemType.search.rawValue,
            localizedTitle: ShortcutItemTitle.search.rawValue,
            localizedSubtitle: "Ini Subtitle",
            icon: UIApplicationShortcutIcon(systemImageName: "magnifyingglass")
        )
        addShortcutItem(item: item)
    }

    private func addShortcutItem(item: UIApplicationShortcutItem) {
        // Remove current item if any
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
