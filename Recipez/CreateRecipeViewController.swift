//
//  CreateRecipeViewController.swift
//  Recipez
//
//  Created by Matthew Linaberry on 3/8/16.
//  Copyright © 2016 MRS Electronic, Inc. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var addRecipeButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        recipeImage.layer.cornerRadius = 4.0
        recipeImage.clipsToBounds = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImage.image = image
        
    }
    
    @IBAction func addImage(sender: AnyObject!) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createRecipe(sender: AnyObject!) {
        if let title = recipeTitle.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
            
            recipe.title = title
            recipe.ingredients = recipeIngredients.text
            recipe.steps = recipeSteps.text
            recipe.setRecipeImage(recipeImage.image!)
            
            context.insertObject(recipe)
            do {
                try context.save()
            } catch {
                print("couldn't save the recipe!")
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
