import UIKit

final class PhysioSelectExerciseView: UIView {

    // MARK: - Scroll & Container
    let scrollView = UIScrollView()
    let stackView = UIStackView()

    // MARK: - Bottom Bar
    let bottomBar = UIView()
    let selectedLabel = UILabel()
    let addButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        scrollView.showsVerticalScrollIndicator = false

        stackView.axis = .vertical
        stackView.spacing = 25

        bottomBar.backgroundColor = .white
        bottomBar.layer.shadowOpacity = 0.15
        bottomBar.layer.shadowOffset = .zero
        bottomBar.layer.shadowRadius = 4

        selectedLabel.text = "0 videos selected"
        selectedLabel.font = .systemFont(ofSize: 14)

        addButton.setTitle("Add selected videos", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 24
        addButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)

        addSubview(scrollView)
        addSubview(bottomBar)
        scrollView.addSubview(stackView)

        bottomBar.addSubview(selectedLabel)
        bottomBar.addSubview(addButton)
    }

    private func setupConstraints() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        selectedLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            // ScrollView
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),

            // StackView
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),

            // Bottom Bar
            bottomBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 70),

            selectedLabel.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            selectedLabel.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 20),

            addButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 170),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: - Create Card (NO reusable file)
    func createExerciseCard(_ exercise: PhysioExercise, isSelected: Bool) -> UIView {

        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 20
        card.layer.shadowOpacity = 0.1
        card.layer.shadowRadius = 4
        card.layer.shadowOffset = CGSize(width: 0, height: 3)

        let image = UIImageView(image: UIImage(named: exercise.imageName))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true

        let playIcon = UIImageView(image: UIImage(systemName: "play.circle.fill"))
        playIcon.tintColor = .white

        let radioButton = UIImageView()
        radioButton.tintColor = isSelected ? .systemBlue : .lightGray
        radioButton.image = UIImage(systemName: isSelected ? "largecircle.fill.circle" : "circle")

        let durationLabel = UILabel()
        durationLabel.font = .systemFont(ofSize: 13)
        durationLabel.text = "Time: \(exercise.duration)"

        let equipmentLabel = UILabel()
        equipmentLabel.font = .systemFont(ofSize: 13)
        equipmentLabel.text = "Equipments: \(exercise.equipment)"
        equipmentLabel.textColor = .gray

        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.text = exercise.title

        // Add subviews
        [image, playIcon, radioButton, durationLabel, equipmentLabel, titleLabel]
            .forEach { card.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([

            image.topAnchor.constraint(equalTo: card.topAnchor),
            image.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 180),

            playIcon.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            playIcon.widthAnchor.constraint(equalToConstant: 45),
            playIcon.heightAnchor.constraint(equalToConstant: 45),

            radioButton.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            radioButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -10),
            radioButton.widthAnchor.constraint(equalToConstant: 22),
            radioButton.heightAnchor.constraint(equalToConstant: 22),

            durationLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 15),

            equipmentLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 3),
            equipmentLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),

            titleLabel.topAnchor.constraint(equalTo: equipmentLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -15)
        ])

        return card
    }
}
