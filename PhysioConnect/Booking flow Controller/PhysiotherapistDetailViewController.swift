//
//  PhysiotherapistDetailViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 13/11/25.
//
//
//  PhysiotherapistDetailViewController.swift
//  PhysioConnect
//

import UIKit

final class PhysiotherapistDetailViewController: UIViewController,
                                                UITableViewDataSource,
                                                UITableViewDelegate {

    private let detailView = PhysiotherapistDetailView()

    // Full detail model loaded from Supabase
    private var model: PhysiotherapistDetailModel?

    private var isExpanded = false
    private var expandedReviewIndex: Int? = nil

    // doctorID passed from DoctorList screen
    private var doctorID: UUID!

    // MARK: - Public configure
    func configureWith(doctor: Doctor) {
        self.doctorID = doctor.id
    }

    // MARK: - Load View
    override func loadView() {
        view = detailView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true

        detailView.reviewsTableView.delegate = self
        detailView.reviewsTableView.dataSource = self

        // Buttons
        detailView.seeMoreButton.addTarget(self, action: #selector(toggleAboutSection), for: .touchUpInside)
        detailView.bookButton.addTarget(self, action: #selector(bookAppointmentTapped), for: .touchUpInside)
        detailView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        loadDetailsFromSupabase()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Safety: ensure height is correct after auto layout
        updateReviewsTableHeight()
    }

    // MARK: - Fetch detail from Supabase
    private func loadDetailsFromSupabase() {
        Task {
            do {
                guard let row = try await SupabaseService.shared.fetchPhysiotherapistDetail(id: doctorID) else {
                    print("❌ ERROR: No detail found for ID:", doctorID as Any)
                    return
                }

                // Map Supabase row → app model
                self.model = PhysiotherapistDetailModel(
                    id: row.id,
                    name: row.name,
                    specialization: row.specialization ?? "",
                    experience: row.experience ?? "0 years",
                    rating: row.rating ?? 0,
                    reviewsCount: row.reviews ?? 0,
                    patientsCount: "\(row.patientsCount ?? 0)+",
                    distance: "Calculating…",
                    consultationFee: "\(row.feePerHour ?? 0)",
                    description: row.description ?? "",
                    imageURL: row.imageURL ?? "",
                    reviews: [
                        Review(
                            reviewerName: "Emily Anderson",
                            rating: 5.0,
                            comment: "Dr. David is a true professional who genuinely cares about his patients. I highly recommend him.",
                            imageName: "profile1"
                        ),
                        Review(
                            reviewerName: "Sarah Miller",
                            rating: 5.0,
                            comment: "Extremely knowledgeable and compassionate. My knee pain improved significantly within a few sessions.",
                            imageName: "profile2"
                        ),
                        Review(
                            reviewerName: "John Carter",
                            rating: 4.5,
                            comment: "Professional and friendly. Explained everything clearly and helped me recover faster than expected.",
                            imageName: "profile3"
                        )
                    ]
                )

                DispatchQueue.main.async {
                    self.configureView()
                }
            } catch {
                print("❌ ERROR fetching detail:", error.localizedDescription)
            }
        }
    }

    // MARK: - Configure UI
    private func configureView() {
        guard let model = model else { return }

        // Doctor card
        let cardDoctor = Doctor(
            id: model.id,
            name: model.name,
            rating: model.rating,
            reviews: model.reviewsCount,
            specialization: model.specialization,
            feePerHour: model.consultationFee,
            imageURL: model.imageURL,
            latitude: 0,
            longitude: 0,
            distance: model.distance
        )
        detailView.doctorCard.configure(with: cardDoctor)

        // Stats using StatView
        detailView.patientsStat.setValues(
            top: model.patientsCount,
            bottom: "patients"
        )

        // Strip " years" to show as e.g. "10+"
        let expText: String
        if model.experience.contains("year") {
            expText = model.experience.replacingOccurrences(of: " years", with: "+")
                .replacingOccurrences(of: " year", with: "+")
        } else {
            expText = model.experience
        }
        detailView.experienceStat.setValues(
            top: expText,
            bottom: "experience"
        )

        // About text with paragraph style
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6
        paragraph.paragraphSpacing = 4
        paragraph.alignment = .justified

        detailView.aboutText.attributedText = NSAttributedString(
            string: model.description,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.darkGray,
                .paragraphStyle: paragraph
            ]
        )
        detailView.aboutText.numberOfLines = 3

        // Reload reviews + fix height
        detailView.reviewsTableView.reloadData()
        updateReviewsTableHeight()
    }

    // MARK: - See more / less
    @objc private func toggleAboutSection() {
        isExpanded.toggle()
        detailView.aboutText.numberOfLines = isExpanded ? 0 : 3
        detailView.seeMoreButton.setTitle(isExpanded ? "See Less" : "See More", for: .normal)

        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Update reviews table height
    private func updateReviewsTableHeight() {
        // Make sure cells are laid out
        detailView.reviewsTableView.layoutIfNeeded()

        let height = detailView.reviewsTableView.contentSize.height
        detailView.reviewsTableHeightConstraint.constant = height

        view.layoutIfNeeded()
    }

    // MARK: - Table Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Show at most 3
        return min(model?.reviews.count ?? 0, 3)
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ReviewCell",
            for: indexPath
        ) as! ReviewCell

        guard let model = model else { return cell }

        let review = model.reviews[indexPath.row]
        let expanded = (expandedReviewIndex == indexPath.row)

        cell.configure(with: review, expanded: expanded)
        return cell
    }

    // MARK: - Expand / Collapse Review Card
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if expandedReviewIndex == indexPath.row {
            expandedReviewIndex = nil
        } else {
            expandedReviewIndex = indexPath.row
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)

        DispatchQueue.main.async {
            self.updateReviewsTableHeight()
        }
    }

    // MARK: - Button actions
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func bookAppointmentTapped() {
        let vc = DateAndTimeSelectionViewController()
        vc.passedDoctor = convertToDoctor()   // ✅ correct place to convert
        navigationController?.pushViewController(vc, animated: true)
    }

    
    private func convertToDoctor() -> Doctor {
        guard let model = model else {
            fatalError("Model missing before navigating!")
        }

        return Doctor(
            id: model.id,
            name: model.name,
            rating: model.rating,
            reviews: model.reviewsCount,
            specialization: model.specialization,
            feePerHour: model.consultationFee,
            imageURL: model.imageURL,
            latitude: 0,
            longitude: 0,
            distance: model.distance
        )
    }

    
    

}
