//
//  JokeViewController.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Jose Javier on 27/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {

    var category: String?
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jokeLabel.text = "Carregando..."
        
        if let category = category {
            requestJokeFor(category: category)
        }
    }
    
    fileprivate func requestJokeFor(category categoryName: String) {
        let networkProvider = NetworkProider()
        
        let jokeUrl = Constants.jokeUrl + categoryName
        
        networkProvider.request(jokeUrl) { (response: Result<Joke, NetworkError>) in
            if case .success(let joke) = response {
                self.setupView(joke)
            }
        }
    }
    
    fileprivate func setupView(_ joke: Joke) {
        DispatchQueue.main.async {
            self.jokeLabel.text = joke.message
        }
    }
}
