import UIKit

final class PhysioSelectExerciseViewController: UIViewController {

    private let mainView = PhysioSelectExerciseView()

    private var exercises: [PhysioExercise] = [
        PhysioExercise(id: 1, title: "Shoulder pain relief", duration: "15 mins", equipment: "none", imageName: "physio1"),
        PhysioExercise(id: 2, title: "Shoulder pain relief", duration: "15 mins", equipment: "none", imageName: "physio2"),
        PhysioExercise(id: 3, title: "Shoulder pain relief", duration: "15 mins", equipment: "none", imageName: "physio3")
    ]

    private var selectedIDs: Set<Int> = [] {
        didSet { updateBottomBar() }
    }

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Select Exercise"
        navigationItem.backButtonTitle = "Back"

        loadCards()

        mainView.addButton.addTarget(self, action: #selector(addSelected), for: .touchUpInside)
    }

    private func loadCards() {
        mainView.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for ex in exercises {
            let card = mainView.createExerciseCard(ex, isSelected: selectedIDs.contains(ex.id))
            card.tag = ex.id
            card.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSelection(_:)))
            card.addGestureRecognizer(tap)

            mainView.stackView.addArrangedSubview(card)
        }
    }

    @objc private func toggleSelection(_ sender: UITapGestureRecognizer) {
        guard let id = sender.view?.tag else { return }

        if selectedIDs.contains(id) {
            selectedIDs.remove(id)
        } else {
            selectedIDs.insert(id)
        }

        loadCards()
    }

    private func updateBottomBar() {
        mainView.selectedLabel.text = "\(selectedIDs.count) videos selected"
    }

    @objc private func addSelected() {
        // Later: pass the selected IDs back if required
        navigationController?.popViewController(animated: true)
    }
}
