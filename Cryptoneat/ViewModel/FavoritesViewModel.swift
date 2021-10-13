//
//  FavoritesViewModel.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 27/9/21.
//

import UIKit
import CoreData

class FavoritesViewModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var userHasFavorites: Bool {
        return fetchFavorites().count > 0
    }
    
    
    func fetchFavorites() -> [String] {

       var favorites: [String] = []
       let context = appDelegate.persistentContainer.viewContext
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
       
       do {
           
           let fetch = try context.fetch(fetchRequest)
           for data in fetch as! [NSManagedObject] {
               favorites.append(data.value(forKey: "id") as! String)
           }
           
       } catch  {
           print(error.localizedDescription)
       }
       
       return favorites
   }
    

}
