//
//  PhysiotherapistDetailViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 13/11/25.
//


import UIKit

final class PhysiotherapistDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let detailView = PhysiotherapistDetailView()
    private var model: PhysiotherapistDetailModel!
    private var isExpanded = false
    private var expandedReviewIndex: Int? = nil


    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        configureView()
        
        detailView.reviewsTableView.delegate = self
        detailView.reviewsTableView.dataSource = self
        
        // Update height once content is loaded
        detailView.reviewsTableView.reloadData()
        view.layoutIfNeeded()
        updateReviewsTableHeight()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateReviewsTableHeight()
    }
    
    // MARK: - Model Setup
    private func setupModel() {
        // Use your own data later; this is demo
        model = PhysiotherapistDetailModel(
            name: "Dr. David Sainz",
            specialization: "Knee pain specialist",
            experience: "10+ years",
            rating: 5.0,
            reviewsCount: 1872,
            patientsCount: "2000+",
            distance: "within 5 km",
            consultationFee: "₹1000/hr",
            description: "Dr. David is a highly experienced physiotherapist specialising in sports injuries and rehabilitation. He is dedicated to helping patients recover and regain their optimal physical function with personalised, evidence-based treatment plans tailored to each individual’s needs.",
            imageName: "doc1",
            reviews: [
                Review(reviewerName: "Emily Anderson",
                       rating: 5.0,
                       comment: "Dr. David is a true professional who genuinely cares about his patients. I highly recommend him to anyone seeking exceptional care.",
                       imageName: "profile1"),
                Review(reviewerName: "Sarah Miller",
                       rating: 5.0,
                       comment: "Extremely knowledgeable, patient and compassionate. My knee pain improved significantly within a few sessions.",
                       imageName: "profile2"),
                Review(reviewerName: "John Carter",
                       rating: 4.5,
                       comment: "Professional and friendly. Explained every exercise clearly and helped me recover faster than expected.",
                       imageName: "profile3")
            ]
        )
    }
    
    // MARK: - Configure View
    private func configureView() {
        let v = detailView
        
        v.doctorImageView.image = UIImage(named: model.imageName)
        v.nameLabel.text = model.name
        v.ratingLabel.text = "⭐️ \(model.rating)  |  \(model.reviewsCount) reviews"
        v.distanceLabel.text = "📍 \(model.distance)"
        v.specializationLabel.text = model.specialization
        v.feeLabel.text = model.consultationFee
        
        // Justified About text using attributed string
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .justified
        paragraph.lineSpacing = 6 
        paragraph.paragraphSpacing = 4
        
        let aboutAttr = NSAttributedString(
            string: model.description,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.darkGray,
                .paragraphStyle: paragraph
            ]
        )
        v.aboutText.attributedText = aboutAttr
        
        // Button styling (tap can be wired later to navigation)
        v.bookButton.addTarget(self, action: #selector(bookAppointmentTapped), for: .touchUpInside)
        
        detailView.seeMoreButton.addTarget(self, action: #selector(toggleAboutSection), for: .touchUpInside)

    }
    
    
    @objc private func toggleAboutSection() {
        isExpanded.toggle()
        
        if isExpanded {
            // Expand
            detailView.aboutText.numberOfLines = 0
            detailView.seeMoreButton.setTitle("See Less", for: .normal)
        } else {
            // Collapse
            detailView.aboutText.numberOfLines = 3
            detailView.seeMoreButton.setTitle("See More", for: .normal)
        }
        
        // Animate the height change smoothly
        UIView.animate(withDuration: 0.25) {
            self.detailView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }

    
    // MARK: - Dynamic Table Height
    private func updateReviewsTableHeight() {
        detailView.reviewsTableView.layoutIfNeeded()
        let contentHeight = detailView.reviewsTableView.contentSize.height
        detailView.reviewsTableHeightConstraint.constant = contentHeight
    }
    
    // MARK: - Table Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Show only top 3 reviews
        return min(model.reviews.count, 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ReviewCell",
            for: indexPath
        ) as! ReviewCell
        
        let review = model.reviews[indexPath.row]
        let isExpanded = (expandedReviewIndex == indexPath.row)

        cell.configure(with: review, expanded: isExpanded)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if expandedReviewIndex == indexPath.row {
            // collapse
            expandedReviewIndex = nil
        } else {
            // expand selected review
            expandedReviewIndex = indexPath.row
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)

        // update table height inside scroll view
        DispatchQueue.main.async {
            self.updateReviewsTableHeight()
        }
    }

    // Optional: fixed height or automatic dimension (we've set automaticDimension)
    // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //     return 130
    // }
    
    // MARK: - Actions
    @objc private func bookAppointmentTapped() {
        // later: push booking screen
        print("Book appointment tapped")
    }
}
