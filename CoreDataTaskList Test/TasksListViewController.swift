//
//  TaskListViewController.swift
//  CoreDataTaskList Test
//
//  Created by Александр Бехтер on 03.08.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit
import CoreData

class TasksListViewController: UITableViewController {
    
    private var tasks = StorageManager.shared.fetchData()
    private let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = #colorLiteral(red: 0.2257673144, green: 0.7145414948, blue: 0.7372559905, alpha: 1)
        setupNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithTransparentBackground()
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.backgroundColor = #colorLiteral(red: 0.8234713481, green: 0.2075231373, blue: 0.1613050401, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
        navigationController?.navigationBar.tintColor = .black
    }
    @objc private func addTask() {
        showAlert()
    }

    private func showAlert(task: Task? = nil, completion: (() -> Void)? = nil) {
          
          var title = "New Task"
          if task != nil { title = "Update Task" }
          
          let alert = AlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
          
          alert.action(task: task) { newValue in
              if let task = task, let completion = completion {
                  StorageManager.shared.edit(task, newName: newValue)
                  completion()
              } else {
                  StorageManager.shared.save(newValue) { task in
                      self.tasks.append(task)
                      self.tableView.insertRows(
                          at: [IndexPath(row: self.tasks.count - 1, section: 0)],
                          with: .automatic
                      )
                  }
              }
          }
          
          present(alert, animated: true)
      }}


//MARK:- table view data sourse

extension TasksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        
        return cell
    }
}

extension TasksListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        showAlert(task: task) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(task)
        }
    }
}
