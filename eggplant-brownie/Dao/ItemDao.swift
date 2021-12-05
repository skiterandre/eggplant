//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 05/12/21.
//

import Foundation

class ItemDao{
    
    private let DIRETORIO = "itens"
    
    func salvar(listaItem: [Item]){
        guard let caminho = recuperaDiretorioItens() else {return}
        
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: listaItem, requiringSecureCoding: false)
            try data.write(to: caminho)
                    
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func listar() -> [Item] {
        guard let caminho = recuperaDiretorioItens() else {return []}
        
        do{
            let data = try Data(contentsOf: caminho)
            guard let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Item> else{return []}
            return itensSalvos
        }catch{
            print(error.localizedDescription)
        }
        return []
    }
    
    private func recuperaDiretorioItens() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let caminho = diretorio.appendingPathComponent(DIRETORIO)
        
        return caminho
    }
}
