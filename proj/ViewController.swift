//
//  ViewController.swift
//  proj
//
//  Created by student on 10.09.2018.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var Id: UILabel!
    
    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var completed: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    var sample = Product()
    
    var myTitle1 = "";
    var myId1 = 0;
    var myUdserId1 = 0;
    var myCompleted1 = false;
    
    @IBAction func getData(_ sender: Any) {
        let restServerURL: String = "https://jsonplaceholder.typicode.com/todos/1"
        let url = NSURL(string: restServerURL)
        let request = NSURLRequest(url: url! as URL)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        DispatchQueue.main.async {
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print(error ?? "error calling GET on /todos/1")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                let realm = try! Realm()
                print("The todo is: " + todo.description)
                
                
                
                print("Saving to object...")
                self.sample.id = (todo["id"]?.integerValue)!
                print("Id: \(self.sample.id)")
                self.sample.title = (todo["title"] as? String)!
                print("Title: \(self.sample.title)")
                self.sample.userId = (todo["userId"]?.integerValue)!
                print("UserId: \(self.sample.userId)")
                self.sample.completed = (todo["completed"]?.boolValue)!
                print("Id: \(self.sample.completed)")
                try! realm.write {
                    realm.add(self.sample)
                }
                
                print("Test get from DB")
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                self.myTitle1 = todoTitle
                print("The title is: " + todoTitle)
                
                guard let todoId = todo["id"] as? Int else {
                    print("Could not get todo title from JSON")
                    return
                }
                self.myId1 = todoId
                print("The Id is: " + String(todoId))
                
                guard let todoUserId = todo["userId"] as? Int else {
                    print("Could not get todo title from JSON")
                    return
                }
                self.myUdserId1 = todoUserId
                print("The UserIdi: " + String(todoUserId))
                
                guard let todoComplited = todo["completed"] as? Bool else {
                    print("Could not get todo title from JSON")
                    return
                }
                self.myCompleted1 = todoComplited
                print("The completed is: " + String(todoComplited))
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            
        }
        
        task.resume()
        sleep(2)
        self.showDataAuto()
        }
        
    }
    
    func showDataAuto() {
        self.Id.text = "Id = " + String(self.myId1)
        self.myTitle.text = "Title = " + self.myTitle1;
        self.userId.text = "UserId = " + String(self.myUdserId1);
        self.completed.text = "Completed = " + String(self.myCompleted1)
        
        let location = CLLocationCoordinate2DMake(50.0246289, 19.8924691)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = location.latitude
        annotation.coordinate.longitude = location.longitude
        annotation.title = "Kraków"
        annotation.subtitle = "UJ"
        map.addAnnotation(annotation)
        
        picture.isHidden = false;
    }
}

