//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 05/12/21.
//

import Foundation

class RefeicaoDao{
    
    private let DIRETORIO = "refeicao"
    
    func salvar(listaRefeicoes: [Refeicao]){
        guard let caminho = recuperaDiretorio() else {return}
        
        do{
            let dados = try NSKeyedArchiver.archivedData(withRootObject: listaRefeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func listar() -> [Refeicao]{
        guard let caminho = recuperaDiretorio() else {return []}
        do{
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return [] }
            return refeicoesSalvas
        }catch{
            print(error.localizedDescription)
        }
        
        return []
    }
    
    private func recuperaDiretorio() -> URL?{
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return nil}
        let caminho = diretorio.appendingPathComponent(DIRETORIO)
        
        return caminho
    }
}
