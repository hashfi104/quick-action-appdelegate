# Quick Action IOS (using App Delegate)
Because the minimum version of this project is IOS 12, so we can't use <b><s>SceneDelegate</s></b> and only use <b>AppDelegate</b> to setting the app.

## Declaration
### Static Quick Action
Declare it on <b>Info.plist</b> file
<img width="872" alt="Screenshot 2024-07-02 at 16 45 34" src="https://github.com/hashfi104/quick-action-appdelegate/assets/4686182/74374b83-f7e5-4e48-8317-c13ecd34e5f3">

Here the source code
```xml
<array>
  <dict>
    <key>UIApplicationShortcutItemIconType</key>
    <string>UIApplicationShortcutIconTypeAlarm</string>
    <key>UIApplicationShortcutItemType</key>
    <string>QuickAction.Alarm</string>
    <key>UIApplicationShortcutItemTitle</key>
    <string>Alarm Jadwal</string>
  </dict>
  <dict>
    <key>UIApplicationShortcutItemIconType</key>
    <string>UIApplicationShortcutIconTypeDate</string>
    <key>UIApplicationShortcutItemIconFile</key>
    <string>ic_add</string>
    <key>UIApplicationShortcutItemType</key>
    <string>QuickAction.Add</string>
    <key>UIApplicationShortcutItemTitle</key>
    <string>Tambah Jadwal</string>
  </dict>
</array>
```

### Dynamic Quick Action
Configure it based on user behavior
```swift
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
```

#### Add & Remove Action
Here's how we can add and remove the dynamic action
```swift
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
```

## Handler
Like I said before, we will use <b>AppDelegate</b> class to handling quick action. Here's some method that we can use for it.
```swift
func application(
    _ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void
) {
    let navVC: UINavigationController = (window?.rootViewController) as! UINavigationController
    let rootVC: UIViewController = navVC.topViewController!
    rootVC.title = shortcutItem.localizedTitle
}
```

Beside that, there is an alternative way to handle quick action only if the app is launched from non-running state through <b>didFinishLaunchingWithOptions</b> method
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ...
    // Alternative for handling launch app by quick action from not running state
    if let selectedItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
        rootVC.title = selectedItem.localizedTitle

        // Since, the app launch is triggered by QuicAction, block "performActionForShortcutItem:completionHandler" method from being called.
        return false
    }
    ...
    return true
}
```
