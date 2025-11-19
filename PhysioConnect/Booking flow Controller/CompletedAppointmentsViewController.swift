//
//  CompletedAppointmentsViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//
import UIKit

final class CompletedAppointmentsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let content = UIView()
    
    private var completed: [AppointmentDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "E4F0FF")
        setupLayout()
        loadAppointments()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(content)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func loadAppointments() {
        // Placeholder data — replace with actual persistence later
        completed = CompletedAppointmentStore.shared.items
        reloadUI()
    }
    
    private func reloadUI() {
        content.subviews.forEach { $0.removeFromSuperview() }
        
        var y: CGFloat = 0
        
        for appt in completed {
            let card = AppointmentCardView(type: .completed)
            card.configure(with: appt)
            
            card.rebookAction = { [weak self] in
                self?.rebook(appt)
            }
            card.reportAction = { [weak self] in
                self?.openReport(appt)
            }
            
            content.addSubview(card)
            card.frame = CGRect(x: 16, y: y, width: view.bounds.width - 32, height: 180)
            
            y += 200
        }
        
        content.frame.size.height = y + 40
    }
    
    private func rebook(_ appt: AppointmentDetail) {
        print("Rebook → Launch booking flow")
    }
    
    private func openReport(_ appt: AppointmentDetail) {
        print("Open PDF / Report screen")
    }
}
