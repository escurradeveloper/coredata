//
//  ListPersonViewController.swift
//  Clase34CoreData
//
//  Created by Escurra Colquis on 25/11/24.
//

import UIKit //importamos la UI
import CoreData //importamos para usar base de datos

class ListPersonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //componentes de la UI
    @IBOutlet weak var listPersonTableView: UITableView!
    
    //variables
    var personData = [Person]() //array de tipo person para mostrar a las personas
    
    //carga en memoria
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView() //llamamos a la función de configuración de la tabla
        showData() //llamamos a la función para mostrar los datos de la persona
    }
    
    //cuando esta apunto de aparecer la vista
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listPersonTableView.reloadData() //actualizamos la tabla
    }
    
    //Funciones
    //función para la conexión a la base de datos
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate //instanciamos y llamamos al AppDelegate
        return delegate.persistentContainer.viewContext //retornamos el contexto de Coredata del AppDelegate
    }
    
    //función para configurar la tabla
    func configureTableView() {
        listPersonTableView.delegate = self //delegado
        listPersonTableView.dataSource = self //dataSource
        listPersonTableView.rowHeight = 60 //tamaño de la celda
    }
    
    //función para mostrar datos
    func showData() {
        let context = connectBD() //contexto para conectarnos a la base de datos
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest() //objeto para visualizar la información en el cual debe ser de tipo NSFetchRequest de la base de datos Person
        //en un capturador de error
        do {
            personData = try context.fetch(fetchRequest) // objeto que llama al contexto para mostrar la información
            print("Se mostraron los datos en la tabla") //imprimir por consola
        } catch let error as NSError {
            //aca va el error
            //podriamos poner una vista en especifica pero por el momento solo imprimimos por consola
            print("Error al mostrar: \(error.localizedDescription)")
        }
    }
    
    
    // UITableViewDelegate - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        //retornamos uno porque solo hay un table view
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //retornamos la cantidad del arreglo de la lista
        return personData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //llamamos a la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
        let person = personData[indexPath.row] //pasamos lo que hay en el arreglo de personas
        cell?.configurePerson(person: person, viewController: self) //llamamos a la configuración de la celda para que se muestren los datos
        return cell ?? UITableViewCell() //retornamos la celda
    }
    
    //para poder eliminar dentro del tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = connectBD() //contexto para conectarnos a la base de datos
        let person = personData[indexPath.row]
        //para elegir el swipe de eliminar
        if editingStyle == .delete {
            context.delete(person) //eliminamos a la persona de la base de datos
            //en un capturador de error
            do {
                try context.save() //guardamos
                print("Se eliminó el registro") //imprimir por consola
            } catch let error as NSError {
                //aca va el error
                //podriamos poner una vista en especifica pero por el momento solo imprimimos por consola
                print("Error al eliminar el registro: \(error.localizedDescription)")
            }
        }
        showData() //llamar a al función para mostrar a las personas
        listPersonTableView.reloadData() //actualizar la tabla
    }
    
    //para seleccionar un item de la celda del tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //le pasamos el identificador updateView
        performSegue(withIdentifier: "updateView", sender: self)
    }
    
    //llamamos a la función del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //igualamos el segue con el identificador updateView
        if segue.identifier == "updateView" {
            //validamos que el id sea el correcto de la celda de la tabla
            if let id = listPersonTableView.indexPathForSelectedRow {
                let rowPerson = personData[id.row] //le pasamos el id de la celda de la tabla a la constante rowPerson
                let router = segue.destination as? EditPersonViewController //creamos el objecto destino de la clase final
                router?.personUpdate = rowPerson //le enviamos el id hacia el otro viewController
            }
        }
    }
}
