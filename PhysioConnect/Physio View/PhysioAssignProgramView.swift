import UIKit

final class PhysioAssignProgramView: UIView {

    let scrollView = UIScrollView()
    let contentView = UIView()

    // ❌ Removed big title label
    // let headerLabel = ...

    // MARK: - Choose Template
    let chooseTemplateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Choose Template"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let templateButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Select Template", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 18
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        btn.showsMenuAsPrimaryAction = true
        return btn
    }()

    // MARK: - Customise Program
    let customiseLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Customise Program"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let selectVideosButton = PhysioAssignProgramView.makeChevronButton("Select Videos")
    let setDaysButton = PhysioAssignProgramView.makeChevronButton("Set Days")
    // ❌ Removed Reorder button

    // MARK: - Redeem Code
    let redeemTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Redeem Code"
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()

    let redeemCard = UIView()
    let redeemCodeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = .systemBlue
        lbl.textAlignment = .center
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#E3F0FF")
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - New chevron button factory
    static func makeChevronButton(_ title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 18
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)

        // add chevron
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = .gray
        chevron.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(chevron)

        NSLayoutConstraint.activate([
            chevron.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -16)
        ])

        return btn
    }

    private func setupUI() {

        redeemCard.backgroundColor = .white
        redeemCard.layer.cornerRadius = 18

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [
            chooseTemplateLabel, templateButton,
            customiseLabel, selectVideosButton, setDaysButton,   // ❌ removed reorderButton
            redeemTitleLabel, redeemCard
        ].forEach { contentView.addSubview($0) }

        redeemCard.addSubview(redeemCodeLabel)
    }

    private func setupConstraints() {

        [
            scrollView, contentView,
            chooseTemplateLabel, templateButton,
            customiseLabel, selectVideosButton, setDaysButton,
            redeemTitleLabel, redeemCard, redeemCodeLabel
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            chooseTemplateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            chooseTemplateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            templateButton.topAnchor.constraint(equalTo: chooseTemplateLabel.bottomAnchor, constant: 10),
            templateButton.leadingAnchor.constraint(equalTo: chooseTemplateLabel.leadingAnchor),
            templateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            templateButton.heightAnchor.constraint(equalToConstant: 48),

            customiseLabel.topAnchor.constraint(equalTo: templateButton.bottomAnchor, constant: 28),
            customiseLabel.leadingAnchor.constraint(equalTo: chooseTemplateLabel.leadingAnchor),

            selectVideosButton.topAnchor.constraint(equalTo: customiseLabel.bottomAnchor, constant: 10),
            selectVideosButton.leadingAnchor.constraint(equalTo: customiseLabel.leadingAnchor),
            selectVideosButton.trailingAnchor.constraint(equalTo: templateButton.trailingAnchor),
            selectVideosButton.heightAnchor.constraint(equalToConstant: 48),

            setDaysButton.topAnchor.constraint(equalTo: selectVideosButton.bottomAnchor, constant: 14),
            setDaysButton.leadingAnchor.constraint(equalTo: selectVideosButton.leadingAnchor),
            setDaysButton.trailingAnchor.constraint(equalTo: selectVideosButton.trailingAnchor),
            setDaysButton.heightAnchor.constraint(equalToConstant: 48),

            redeemTitleLabel.topAnchor.constraint(equalTo: setDaysButton.bottomAnchor, constant: 25),
            redeemTitleLabel.leadingAnchor.constraint(equalTo: customiseLabel.leadingAnchor),

            redeemCard.topAnchor.constraint(equalTo: redeemTitleLabel.bottomAnchor, constant: 10),
            redeemCard.leadingAnchor.constraint(equalTo: redeemTitleLabel.leadingAnchor),
            redeemCard.trailingAnchor.constraint(equalTo: templateButton.trailingAnchor),
            redeemCard.heightAnchor.constraint(equalToConstant: 52),

            redeemCodeLabel.centerXAnchor.constraint(equalTo: redeemCard.centerXAnchor),
            redeemCodeLabel.centerYAnchor.constraint(equalTo: redeemCard.centerYAnchor),

            redeemCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
