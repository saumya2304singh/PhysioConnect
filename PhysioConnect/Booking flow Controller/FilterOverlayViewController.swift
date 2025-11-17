//
//  FiltersOverlayViewController.swift
//  PhysioConnect
//

import UIKit

final class FiltersOverlayViewController: UIViewController {

    // MARK: - External communication
    var selectedFilters = Filters()
    var onApply: ((Filters) -> Void)?

    // MARK: - Internal state
    private var selectedDistance: Double = 15
    private var selectedRating: Int = 0

    private var specialityButtons: [(String, UIButton)] = []
    private var genderButtons: [(String, UIButton)] = []
    private var ratingButtons: [UIButton] = []

    // MARK: - UI Elements
    private let dimView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let distanceLabel = UILabel()
    private let distanceSlider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        applySavedFilters()
    }

    // MARK: - UI Construction
    private func buildUI() {

        // ====== Dim Background ======
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        dimView.frame = view.bounds
        dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        view.addSubview(dimView)

        // ====== Scrollable Bottom Sheet ======
        scrollView.backgroundColor = UIColor(hex: "E3F0FF")
        scrollView.layer.cornerRadius = 36
        scrollView.clipsToBounds = true
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -40)
        ])

        // ContentView inside scrollView
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // ====== Title ======
        let title = UILabel()
        title.text = "Filters"
        title.font = .boldSystemFont(ofSize: 22)
        title.textAlignment = .center

        let removeBtn = UIButton(type: .system)
        removeBtn.setTitle("remove", for: .normal)
        removeBtn.addTarget(self, action: #selector(removeFilters), for: .touchUpInside)

        contentView.addSubview(title)
        contentView.addSubview(removeBtn)

        title.translatesAutoresizingMaskIntoConstraints = false
        removeBtn.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            removeBtn.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            removeBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // ====== Cards ======
        let specialityCard = makeCardSection(
            title: "Speciality",
            items: ["Knee Physiotherapy", "Neck Physiotherapy", "Shoulder Physiotherapy"],
            storage: &specialityButtons
        )

        let genderCard = makeCardSection(
            title: "Gender Preference",
            items: ["Male", "Female", "Prefer not to say"],
            storage: &genderButtons
        )

        let distanceCard = makeDistanceCard()
        let ratingCard = makeRatingCard()
        let buttonsStack = makeButtons()

        // Add all sections to contentView
        [specialityCard, genderCard, distanceCard, ratingCard, buttonsStack]
            .forEach { contentView.addSubview($0) }

        specialityCard.translatesAutoresizingMaskIntoConstraints = false
        genderCard.translatesAutoresizingMaskIntoConstraints = false
        distanceCard.translatesAutoresizingMaskIntoConstraints = false
        ratingCard.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            specialityCard.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            specialityCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            specialityCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            genderCard.topAnchor.constraint(equalTo: specialityCard.bottomAnchor, constant: 20),
            genderCard.leadingAnchor.constraint(equalTo: specialityCard.leadingAnchor),
            genderCard.trailingAnchor.constraint(equalTo: specialityCard.trailingAnchor),

            distanceCard.topAnchor.constraint(equalTo: genderCard.bottomAnchor, constant: 20),
            distanceCard.leadingAnchor.constraint(equalTo: specialityCard.leadingAnchor),
            distanceCard.trailingAnchor.constraint(equalTo: specialityCard.trailingAnchor),

            ratingCard.topAnchor.constraint(equalTo: distanceCard.bottomAnchor, constant: 20),
            ratingCard.leadingAnchor.constraint(equalTo: specialityCard.leadingAnchor),
            ratingCard.trailingAnchor.constraint(equalTo: specialityCard.trailingAnchor),

            buttonsStack.topAnchor.constraint(equalTo: ratingCard.bottomAnchor, constant: 24),
            buttonsStack.leadingAnchor.constraint(equalTo: specialityCard.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: specialityCard.trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Card Builders
    private func baseCard() -> UIView {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        return v
    }

    private func makeCardSection(title: String,
                                 items: [String],
                                 storage: inout [(String, UIButton)]) -> UIView {

        let card = baseCard()

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 16)

        card.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16)
        ])

        var previous: UIView = titleLabel

        for item in items {

            let label = UILabel()
            label.text = item
            label.font = .systemFont(ofSize: 15)

            let btn = UIButton(type: .custom)
            btn.layer.cornerRadius = 10
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.backgroundColor = .white
            btn.addTarget(self, action: #selector(toggleOption(_:)), for: .touchUpInside)

            card.addSubview(label)
            card.addSubview(btn)

            label.translatesAutoresizingMaskIntoConstraints = false
            btn.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 14),
                label.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),

                btn.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                btn.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
                btn.widthAnchor.constraint(equalToConstant: 20),
                btn.heightAnchor.constraint(equalToConstant: 20)
            ])

            storage.append((item, btn))
            previous = label
        }

        previous.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16).isActive = true
        return card
    }

    private func makeDistanceCard() -> UIView {

        let card = baseCard()

        let title = UILabel()
        title.text = "Distance"
        title.font = .boldSystemFont(ofSize: 16)

        distanceLabel.text = "within 15 km"
        distanceLabel.font = .systemFont(ofSize: 14)
        distanceLabel.textColor = .darkGray

        distanceSlider.minimumValue = 1
        distanceSlider.maximumValue = 15
        distanceSlider.value = Float(selectedDistance)
        distanceSlider.addTarget(self, action: #selector(distanceChanged), for: .valueChanged)

        [title, distanceLabel, distanceSlider].forEach { card.addSubview($0) }

        title.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceSlider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),

            distanceLabel.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            distanceSlider.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            distanceSlider.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            distanceSlider.trailingAnchor.constraint(equalTo: distanceLabel.trailingAnchor),
            distanceSlider.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])

        return card
    }

    private func makeRatingCard() -> UIView {
        let card = baseCard()

        let title = UILabel()
        title.text = "Ratings"
        title.font = .boldSystemFont(ofSize: 16)
        card.addSubview(title)

        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16)
        ])

        var previousStar: UIButton?

        for i in 1...5 {
            let star = UIButton(type: .system)
            star.tag = i
            star.tintColor = .systemYellow
            star.setImage(UIImage(systemName: "star"), for: .normal)
            star.addTarget(self, action: #selector(ratingSelected(_:)), for: .touchUpInside)
            card.addSubview(star)

            star.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                star.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
                star.widthAnchor.constraint(equalToConstant: 26),
                star.heightAnchor.constraint(equalToConstant: 26)
            ])

            if let prev = previousStar {
                star.leadingAnchor.constraint(equalTo: prev.trailingAnchor, constant: 10).isActive = true
            } else {
                star.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
            }

            previousStar = star
            ratingButtons.append(star)
        }

        previousStar!.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16).isActive = true
        return card
    }

    private func makeButtons() -> UIStackView {
        let cancel = UIButton(type: .system)
        cancel.setTitle("Cancel", for: .normal)
        cancel.backgroundColor = .white
        cancel.setTitleColor(.black, for: .normal)
        cancel.layer.cornerRadius = 22
        cancel.addTarget(self, action: #selector(close), for: .touchUpInside)

        let apply = UIButton(type: .system)
        apply.setTitle("Apply", for: .normal)
        apply.backgroundColor = UIColor(hex: "1E6EF7")
        apply.setTitleColor(.white, for: .normal)
        apply.layer.cornerRadius = 22
        apply.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [cancel, apply])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually

        cancel.heightAnchor.constraint(equalToConstant: 46).isActive = true
        apply.heightAnchor.constraint(equalToConstant: 46).isActive = true

        return stack
    }

    // MARK: - Actions
    @objc private func toggleOption(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.backgroundColor = sender.isSelected ? UIColor(hex: "1E6EF7") : .white
        sender.layer.borderColor = sender.isSelected ? UIColor.clear.cgColor : UIColor.lightGray.cgColor
    }

    @objc private func distanceChanged() {
        selectedDistance = Double(Int(distanceSlider.value))
        distanceLabel.text = "within \(Int(selectedDistance)) km"
    }

    @objc private func ratingSelected(_ sender: UIButton) {
        selectedRating = sender.tag
        for star in ratingButtons {
            let filled = star.tag <= selectedRating
            star.setImage(UIImage(systemName: filled ? "star.fill" : "star"), for: .normal)
        }
    }

    @objc private func applyFilters() {
        selectedFilters.specialities = specialityButtons.filter { $0.1.isSelected }.map { $0.0 }
        selectedFilters.gender = genderButtons.first(where: { $0.1.isSelected })?.0
        selectedFilters.maxDistance = selectedDistance
        selectedFilters.minRating = selectedRating

        onApply?(selectedFilters)
        dismiss(animated: false)
    }

    @objc private func removeFilters() {
        onApply?(Filters())
        dismiss(animated: false)
    }
    

    @objc private func close() {
        dismiss(animated: false)
    }

    // MARK: - Restore Previous Selections
    private func applySavedFilters() {
        // TODO: integrate previous selection if needed
    }
}

