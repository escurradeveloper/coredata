//
//  UserTableViewCell.swift
//  Clase34CoreData
//
//  Created by Escurra Colquis on 25/11/24.
//

import UIKit //importamos a al UI

//clase padre del UITableViewCell
class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    //variables
    var person: Person? //de tipo person de la base de datos
    var viewController: UIViewController? //de tipo viewController ya que se llamará del ViewController en donde esta el TableView padre
    
    //funcion que se crea por defecto
    //es para inicializar valores
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none //ninguna selección de color
        backgroundColor = UIColor.clear //la celda su background no tenga color
    }

    //funcion que se crea por defecto
    //si algo se selecciona
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //funciones
    //para configurar y cargar el contenido de la tabla
    func configurePerson(person: Person, viewController: UIViewController) {
        self.nameLabel.text = "Nombre: \(person.name ?? "") 🙌" //le pasamos el nombre
        self.person = person //le pasamos al person
        self.viewController = viewController //le pasamos al mismo viewController
    }
}
