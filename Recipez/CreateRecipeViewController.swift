//
//  CreateRecipeViewController.swift
//  Recipez
//
//  Created by Mihail Șalari on 15.03.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var recipeTitleTextField: UITextField!
    @IBOutlet weak var receipeIngredientsTextField: UITextField!
    @IBOutlet weak var recipeStepsTextField:UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var addRecipeButton: UIButton!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        
        recipeImage.layer.cornerRadius = recipeImage.frame.size.width / 2
        recipeImage.clipsToBounds = true
        
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        
        self.title = "Create"
        
        // Configure nav bar back button
        if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let barButtonAtributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: buttonFont
            ]
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAtributesDictionary, forState: .Normal)
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImage.image = image
    }
    
    @IBAction func addImageButtonPressed(sender: UIButton) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createRecipeButtonPressed(sender: UIButton) {
        if let newTitle = recipeTitleTextField.text where newTitle != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
            
            recipe.title = newTitle
            recipe.ingredients = receipeIngredientsTextField.text
            recipe.steps = recipeStepsTextField.text
            recipe.setRecipeImage(recipeImage.image!)
            
            context.insertObject(recipe)
            
            do {
                try context.save()
            } catch {
                print("Could not save recipe")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
