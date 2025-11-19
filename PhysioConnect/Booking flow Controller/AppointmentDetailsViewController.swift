//
//  AppointmentDetailsViewController.swift
//  PhysioConnect
//
//  Created by user@8 on 18/11/25.
//

import UIKit

final class AppointmentDetailsViewController: UIViewController {
    
    // MARK: - Appointment Model (passed from Home)
    var appointment: AppointmentDetail!     // correct single model
    
    // MARK: - View
    private let detailsView = AppointmentDetailsView()
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setupActions()
        populateData()
        
        // configure view with model (if view has extra styling)
        detailsView.configure(with: appointment)
    }
    
    
    // MARK: - Setup Actions
    private func setupActions() {
        detailsView.backButton.addTarget(self,
                                         action: #selector(backTapped),
                                         for: .touchUpInside)
        
        detailsView.clearNotesButton.addTarget(self,
                                               action: #selector(clearNotesTapped),
                                               for: .touchUpInside)
    }
    
    
    // MARK: - Populate Data
    private func populateData() {
        let doc = appointment.doctor
        
        // Doctor card
        detailsView.doctorCard.configure(with: doc)
        
        // Format date & time
        let df = DateFormatter()
        df.dateFormat = "EEE, MMM dd"
        
        let tf = DateFormatter()
        tf.dateFormat = "h:mm a"
        
        detailsView.dateValueLabel.text =
            "\(df.string(from: appointment.date)), \(tf.string(from: appointment.date))"
        
        detailsView.locationValueLabel.text = appointment.location
        detailsView.statusValueLabel.text = appointment.status.rawValue

        
        // Load saved session notes
        detailsView.notesTextView.text =
            UserDefaults.standard.string(forKey: appointment.notesKey) ?? ""
    }
    
    
    // MARK: - Actions
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func clearNotesTapped() {
        detailsView.notesTextView.text = ""
        UserDefaults.standard.removeObject(forKey: appointment.notesKey)
    }
    
    
    // MARK: - Autosave Notes
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let notes = detailsView.notesTextView.text ?? ""
        UserDefaults.standard.set(notes, forKey: appointment.notesKey)
    }
}
