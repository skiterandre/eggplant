//
//  RefeicoesViewController.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 27/11/21


import UIKit

class RefeicoesViewController: UITableViewController, AdicionaRefeicaoDelegate{
    
    var refeicoes:[Refeicao] = []
    

    
    override func viewDidLoad() {
        refeicoes = RefeicaoDao().listar()
             
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell()
        let refeicao = refeicoes[indexPath.row]
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressGesture(_:)))
        
        celula.addGestureRecognizer(longPressGesture)
        celula.textLabel?.text = refeicao.nome
        return celula
    }
    
    func adicionar(_ refeicao:Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
        RefeicaoDao().salvar(listaRefeicoes:refeicoes)
    
    }
    
    @objc func onLongPressGesture(_ gesture:UILongPressGestureRecognizer){
        if(gesture.state == .began){
            let celula = gesture.view as! UITableViewCell
            if let indexPath = tableView.indexPath(for: celula){
                let refeicao = refeicoes[indexPath.row]
                
                Alerta(controller: self).exibe(title: refeicao.nome,
                                               message: refeicao.detalhes(),
                                                handler: {
                    self.refeicoes.remove(at: indexPath.row)
                    self.tableView.reloadData()
                })
                
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController{
            viewController.tabelaDeRefeicoes = self
        }
    }
    
    
    
}
