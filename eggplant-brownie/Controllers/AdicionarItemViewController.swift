//
//  AdicionarItemViewController.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 28/11/21.
//

import UIKit

protocol AdicionarItemDelegate{
    func adicionarItem(_ item: Item)
}

class AdicionarItemViewController: UIViewController {

    
    // MARK: - Atributos
    var adicionarItemDelegate: AdicionarItemDelegate?
    
    //MARK: - Construtor
    init(delegate: AdicionarItemDelegate){
        super.init(nibName: "AdicionarItemViewController", bundle: nil)
        self.adicionarItemDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - @IBOutlet

    @IBOutlet weak var campoItemNome: UITextField?
    @IBOutlet weak var campoItemCaloria: UITextField?
    
    
    
    // MARK: - @IBAction
    
    @IBAction func botaoAdicionarItem(_ sender: Any) {
        guard let nomeItem = campoItemNome?.text,let calorias = campoItemCaloria?.text else{return}
        guard let caloriasDouble = Double(calorias) else {return}
        let item = Item(nome: nomeItem, calorias: caloriasDouble)
        adicionarItemDelegate?.adicionarItem(item)
        navigationController?.popViewController(animated: true)
    }
    


}
