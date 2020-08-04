//
//  AppDelegate.swift
//  CoreDataTaskList Test
//
//  Created by Александр Бехтер on 03.08.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit
//import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
// ПЕРЕНЕСЕНО В Storage Manager
    
//    lazy var persistentContainer: NSPersistentContainer = {
//          let container = NSPersistentContainer(name: "CoreDataTaskList_Test")
//          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//              if let error = error as NSError? {
//                  fatalError("Unresolved error \(error), \(error.userInfo)")
//              }
//          })
//          return container
//      }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
        return true
    }
    // MARK: - Core Data stack

    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveContext()
    }

    // MARK: - Core Data Saving support
    
 // ПЕРЕНЕСЕНО В Storage Manager
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

