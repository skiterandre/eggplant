//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Andre de Oliveira Couto on 17/11/21.
//

import UIKit

protocol AdicionaRefeicaoDelegate{
    func adicionar(_ refeicao:Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarItemDelegate {

    // MARK: - @IBOutlet
    @IBOutlet weak var nomeComida: UITextField?
    @IBOutlet weak var notaComida: UITextField?
    @IBOutlet weak var tabelaItens: UITableView?
    
    // MARK: - Atributos
    var tabelaDeRefeicoes: AdicionaRefeicaoDelegate?
    //var itens:[String] = ["molho de tomate", "massa pronta","tempero"]
    var itens:[Item] = [Item(nome:"Molho de Tomate", calorias: 40.0),
                        Item(nome:"Massa Pronta", calorias: 50.0),
                        Item(nome:"Tempero", calorias: 10.0),
                        Item(nome:"Queijo", calorias: 45.0)]
    var itensSelecionados:[Item] = []
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionarItem = UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(vaiParaAdicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionarItem
    }
    
    @objc func vaiParaAdicionarItem(){
        let adicionarItemViewController = AdicionarItemViewController(delegate: self)
        navigationController?.pushViewController(adicionarItemViewController, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        celula.textLabel?.text = itens[indexPath.row].nome
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognize(_:)))
        celula.addGestureRecognizer(gesture)
        return celula
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let celula = tableView.cellForRow(at: indexPath) else {return}
        let itemSelecionado = itens[indexPath.row]
        
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            itensSelecionados.append(itemSelecionado)
        }
        else {
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            if let posicaoItemSelecionado = itensSelecionados.firstIndex(of: item){
                itensSelecionados.remove(at: posicaoItemSelecionado)
            }
        }
        //Teste
        for item in itensSelecionados{
            print(item.nome)
        }
   
    }
    
    func recuperaRefeicaoFuncionario() -> Refeicao?{
        guard let nome  = nomeComida?.text else{
            Alerta(controller: self).exibe(message: "Campo nome inválido")
             return nil
        }
        guard let felicidadeDaRefeicao = notaComida?.text, let felicidade = Int(felicidadeDaRefeicao) else{
            Alerta(controller: self).exibe(message: "Campo felicidade inválido")
            return nil
        }
        
        let refeicao = Refeicao(nome:nome, felicidade:felicidade, itens: itensSelecionados)
        
        return refeicao
    }
    
    // MARK: - @IBAction
    @IBAction func adicionar(){
        
        if let refeicao = recuperaRefeicaoFuncionario(){
            tabelaDeRefeicoes?.adicionar(refeicao)
            navigationController?.popViewController(animated: true)
        }

    }
    
    // MARK: - methods
    func adicionarItem(_ item: Item){
        itens.append(item)
        tabelaItens?.reloadData()
    }
    
    @objc func longPressGestureRecognize(_ gesture:UILongPressGestureRecognizer){
        if(gesture.state == .began){
            print("clicou longo")
        }
    }
    
    
    
}

