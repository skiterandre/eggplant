//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 01/12/21.
//

import UIKit

class Alerta{
    
    let controller:UIViewController
    
    var delegate: (()->Void)?
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func exibe(title: String = "Atenção", message: String,  handler: (()->Void)? = nil,textAction:String? = "Excluir"){
        
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let botaoOk = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(botaoOk)
        
        if let metodo = handler {
            self.delegate = metodo
            let botaoAcao = UIAlertAction(title: textAction, style: .destructive, handler: gerenciaMetodo)
            alerta.addAction(botaoAcao)
        }
        
        
        controller.present(alerta, animated: true, completion: nil)
    }
    
    func gerenciaMetodo(alert: UIAlertAction){
        delegate?()
    }
}
