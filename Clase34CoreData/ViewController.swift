//
//  ViewController.swift
//  Clase34CoreData
//
//  Created by Escurra Colquis on 25/11/24.
//

import UIKit //importamos UI
import CoreData //importamos CoreData para la persistencia en IOS

class ViewController: UIViewController {
    //controles de la UI
    @IBOutlet weak var nameTextField: UITextField! //nombre
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Funciones
    //función para la conexión a la base de datos
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate //instanciamos y llamamos al AppDelegate
        return delegate.persistentContainer.viewContext //retornamos el contexto de Coredata del AppDelegate
    }
    
    //función para guardar
    func savePerson() {
        let context = connectBD() //contexto para conectarnos a la base de datos
        let entityPerson = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person //insertamos objetos en la base da datos Person
        entityPerson.name = nameTextField.text //le asignamos valor al nombre lo que vamos escribiendo
        
        //capturador de error
        do {
            try context.save() //guardamos la información
            clearTextField() //llamamos la función de limpiar los campos
            print("Se guardó a la persona") //imprimir por consola
        } catch let error as NSError {
            //aca va el error
            //podriamos poner una vista en especifica pero por el momento solo imprimimos por consola
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    
    //función para limpiar los campos de texto
    func clearTextField() {
        nameTextField.text = "" //nombre
        nameTextField.becomeFirstResponder() //focus al nombre
    }
    
    //acciones
    //botón guardar
    @IBAction func didTapRegister(_ sender: UIButton) {
        savePerson() //llamamos a la función de guardar
    }
}
