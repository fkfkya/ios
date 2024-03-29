//
//  ViewController.swift
//  vsglukhov_1PW1
//
//  Created by Valentin Glukhov on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    var radius = 25.0 // Magic number
    func getUniqueColors() -> Set<UIColor>{
        // Массив различных цветов
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        return set
    }
    
    func setColors(){ // Меняет цвета
        var set = getUniqueColors()
        for view in self.views{
            view.backgroundColor = set.popFirst()
        }
    }
    
    func setCorners(){ // Меняет углы
        for view in self.views{
            view.layer.cornerRadius = CGFloat.random(in: 0...self.radius)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColors()
        self.setCorners()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var button: UIButton!
    @IBAction func buttonWasPressed(_ sender: Any) {
  
        button?.isEnabled = false

        UIView.animate(withDuration: 2,
                       animations: { [self] in
            self.setColors()
            self.setCorners()
        },
            completion: { [weak self] _ in
            self?.button.isEnabled = true
            })

        
    

}

}
