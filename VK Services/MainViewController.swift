//
//  ViewController.swift
//  VK Test
//
//  Created by Ilya Vladimirovich on 14.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI
    var topLabel: UILabel!
    var tableView: UITableView!
    var data: [Services]!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupTopLabel()
        
        Api().getPost(completion: { [weak self] array in
            
            guard let self = self else { return }
            
            self.data = array
            print(self.data!.count)
            self.setupTableView()
        })
        
    }
    
    // MARK: - Setup UI
    
    
    
    // MARK: - Setup Background
    fileprivate func setupBackground() {
        
        self.view.backgroundColor = .black
    }
    
    // MARK: - Setup Top Label
    fileprivate func setupTopLabel() {
        
        topLabel = UILabel()
        
        topLabel.text = "Сервисы VK"
        
        topLabel.font = UIFont(name: "Helvetica Neue Regular", size: 23)
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 1
        topLabel.textColor = .white
        topLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(topLabel)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    
    // MARK: - Setup Table View
    private func setupTableView() {
        
        tableView = UITableView()
        
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        
        tableView.backgroundColor = .clear
        
        tableView.separatorColor = .white.withAlphaComponent(0.18)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        tableView.showsVerticalScrollIndicator = true
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        guard let data = data else {
            print("NO DATA")
            return UITableViewCell()
        }
        
        for i in 0..<data.count {
            
            if indexPath.row == i {
                
                cell.mainLabel.text = data[i].name
                cell.descriptionLabel.text = data[i].description
                downloadImage(from: data[i].icon_url, completion: { image in
                    cell.imageView1.image = image
                })
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        guard let data = data else { return }
        
        for i in 0..<data.count {
            
            if indexPath.row == i {
                
                let appScheme = "\(data[i].name)://app"
                let appUrl = URL(string: appScheme)
                
                if (appUrl != nil) && UIApplication.shared.canOpenURL(appUrl! as URL) {
                    UIApplication.shared.open(appUrl!)
                } else {
                    print("App not installed")
                    if let url = URL(string: data[i].link) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:])
                        }
                    }
                }
                
            }
            
        }
    }
    
}

extension MainViewController {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
    
    func openApp(appName: String) {
        
        
        
    }
    
}
