//
//  ViewController.swift
//  Recipez
//
//  Created by Mihail Șalari on 15.03.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipes = [Recipe]()
    //var fetchedResultsController = NSFetchedResultsController()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsZero
        self.automaticallyAdjustsScrollViewInsets = false

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndResults()
        tableView.reloadData()
    }
    
    //MARK: -NSFetchedResultsController
    func fetchAndResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.recipes = results as! [Recipe]
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    
    
    
    
    //MARK: -UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as? RecipeTableViewCell {
            let recipe = recipes[indexPath.row]
            cell.configureCell(recipe)
            
            return cell
        } else {
            return RecipeTableViewCell()
        }
    }
}

