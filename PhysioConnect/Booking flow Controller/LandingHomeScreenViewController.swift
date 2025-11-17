//
//  LandingHomeScreenViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 11/11/25.
//

import UIKit

final class LandingHomeScreenViewController: UIViewController {
    
    // MARK: - Properties
    private var homeView: LandingHomeView!          // View layer
    private var homeModel: LandingHomeModel!        // Model layer

    // MARK: - Lifecycle
    override func loadView() {
        // Replace default view with our custom UIView subclass
        homeView = LandingHomeView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        homeView.bookButton.addTarget(self, action: #selector(bookAppointmentTapped), for: .touchUpInside)

        
        // MARK: Setup Model Data
        homeModel = LandingHomeModel(
            videos: [
                Video(imageName: "vid1"),
                Video(imageName: "vid2"),
                Video(imageName: "vid3"),
                Video(imageName: "vid4"),
                Video(imageName: "vid5")
            ],
            articles: [
                Article(imageName: "art1", title: "5 Stretches for Lower Back Pain"),
                Article(imageName: "art2", title: "Posture Tips for Desk Workers"),
                Article(imageName: "art3", title: "How to Avoid Shoulder Stiffness"),
                Article(imageName: "art4", title: "When to See a Physiotherapist"),
                Article(imageName: "art5", title: "The Science of Muscle Recovery")
            ]
        )

        // Configure UI with model
        homeView.configure(with: homeModel)
        
        // Assign delegates
        homeView.videoCollectionView.delegate = self
        homeView.videoCollectionView.dataSource = self
        homeView.articlesCollectionView.delegate = self
        homeView.articlesCollectionView.dataSource = self
        homeView.redeemTextField.delegate = self

        // Animate progress after layout
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.homeView.progressCircle.setProgress(to: 0.85, withAnimation: true)
        }

        // Handle segmented control (week change)
        homeView.weekSegment.addTarget(self, action: #selector(weekChanged(_:)), for: .valueChanged)
    }
    
    @objc private func bookAppointmentTapped() {
        let vc = DoctorListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


    // MARK: - Week Segment Change
    @objc private func weekChanged(_ sender: UISegmentedControl) {
        let values: [CGFloat] = [0.62, 0.85, 0.73, 0.90]
        let target = values[min(max(sender.selectedSegmentIndex, 0), values.count - 1)]
        homeView.progressCircle.setProgress(to: target, withAnimation: true)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension LandingHomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.videoCollectionView {
            return homeModel.videos.count
        } else {
            return homeModel.articles.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.videoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
            let video = homeModel.videos[indexPath.row]
            cell.imageView.image = UIImage(named: video.imageName)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
            let article = homeModel.articles[indexPath.row]
            cell.imageView.image = UIImage(named: article.imageName)
            cell.title.text = article.title
            return cell
        }
    }
}

// MARK: - UITextFieldDelegate (Redeem Popup)
extension LandingHomeScreenViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == homeView.redeemTextField {
            let alert = UIAlertController(
                title: "Redeem Code",
                message: "Enter your physiotherapist-provided code:",
                preferredStyle: .alert
            )
            alert.addTextField { $0.placeholder = "Enter code" }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Redeem", style: .default))
            present(alert, animated: true)
            return false
        }
        return true
    }
}

