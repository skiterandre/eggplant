//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 24/11/21.
//

import UIKit

class Refeicao: NSObject {
    // Atributos
    let nome:String
    let felicidade:Int
    var itens: Array<Item> = []
    
    init(nome:String, felicidade:Int, itens:[Item] = []){
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    func totalDeCalorias() -> Double{
        var total = 0.0
        
        for item in itens {
            total += item.calorias
        }
        return total
    }
    
    func detalhes() -> String{
        var detalhe = "Felicidade: \(felicidade) \n\n"
        for item in itens{
            detalhe += " item: \(item.nome) caloria: \(item.calorias) \n"
        }
        
        return detalhe
    }
}
