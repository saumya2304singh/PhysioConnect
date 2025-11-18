//
//  DoctorListViewController.swift
//  PhysioConnect
//

import UIKit
import CoreLocation


final class DoctorListViewController: UIViewController {
    
    // Callback up to Home with final booked doctor + date
    var onBookingComplete: ((Doctor, Date) -> Void)?
    
    private let doctorListView = DoctorListView()

    private var doctors: [Doctor] = []
    private var filteredDoctors: [Doctor] = []
    private var isSearching = false
        
    var activeFilters = Filters()

    // MARK: - Load View
    override func loadView() {
        view = doctorListView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        doctorListView.tableView.dataSource = self
        doctorListView.tableView.delegate = self
        doctorListView.searchBar.delegate = self

        setupLocationUpdates()
        fetchDoctors()

        doctorListView.calendarButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
        doctorListView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        doctorListView.datePicker.addTarget(self, action: #selector(dateSelected(_:)), for: .valueChanged)
        doctorListView.filterButton.addTarget(self, action: #selector(openFilters), for: .touchUpInside)
    }

    // ===========================================================
    // MARK: - FETCH DOCTORS FROM SUPABASE
    // ===========================================================
    private func fetchDoctors() {
        Task {
            do {
                let rows = try await SupabaseService.shared.fetchPhysiotherapists()

                let mapped: [Doctor] = rows.map { row in
                    let feeString = "\(row.feePerHour ?? 0)"
                    return Doctor(
                        id: row.id,
                        name: row.name,
                        rating: row.rating ?? 0,
                        reviews: row.reviews ?? 0,
                        specialization: row.specialization ?? "",
                        feePerHour: feeString,
                        imageURL: row.imageURL ?? "",
                        latitude: row.latitude,
                        longitude: row.longitude,
                        distance: "Calculating..."
                    )
                }

                if let loc = LocationService.shared.lastLocation {
                    var updated = mapped
                    for i in updated.indices {
                        updated[i].updateDistance(from: loc)
                    }
                    await updateUI(doctors: updated)
                } else {
                    await updateUI(doctors: mapped)
                }

            } catch {
                print("❌ Error fetching doctors:", error)
            }
        }
    }

    @MainActor
    private func updateUI(doctors: [Doctor]) {
        self.doctors = doctors
        self.filteredDoctors = doctors
        self.doctorListView.tableView.reloadData()
    }

    // ===========================================================
    // MARK: - LOCATION
    // ===========================================================
    private func setupLocationUpdates() {

        LocationService.shared.onLocationUpdate = { [weak self] city, location in
            guard let self = self else { return }

            self.doctorListView.cityLabel.text = city

            guard let loc = location else { return }

            for i in self.doctors.indices {
                self.doctors[i].updateDistance(from: loc)
            }
            for i in self.filteredDoctors.indices {
                self.filteredDoctors[i].updateDistance(from: loc)
            }

            self.doctorListView.tableView.reloadData()
        }

        LocationService.shared.requestLocation()
    }

    // ===========================================================
    // MARK: - CALENDAR & FILTERS
    // ===========================================================
    @objc private func openCalendar() {
        doctorListView.showDatePicker()
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func openFilters() {
        let vc = FiltersOverlayViewController()
        vc.selectedFilters = activeFilters

        vc.onApply = { [weak self] newFilters in
            guard let self = self else { return }
            self.activeFilters = newFilters
            self.applyFilters()
        }

        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: false)
    }
    
    private func applyFilters() {
        filteredDoctors = doctors

        if !activeFilters.specialities.isEmpty {
            filteredDoctors = filteredDoctors.filter {
                activeFilters.specialities.contains($0.specialization)
            }
        }

        filteredDoctors = filteredDoctors.filter {
            let dist = Double($0.distance.replacingOccurrences(of: " km", with: "")) ?? 0
            return dist <= activeFilters.maxDistance
        }

        if activeFilters.minRating > 0 {
            filteredDoctors = filteredDoctors.filter {
                Int($0.rating) >= activeFilters.minRating
            }
        }

        doctorListView.tableView.reloadData()
    }

    @objc private func dateSelected(_ sender: UIDatePicker) {
        let d = DateFormatter()
        d.dateFormat = "dd MMM yyyy"
        doctorListView.datePill.text = d.string(from: sender.date)

        let t = DateFormatter()
        t.dateFormat = "h:mm a"
        doctorListView.timePill.text = t.string(from: sender.date)
    }
}

// ===========================================================
// MARK: - TABLE VIEW
// ===========================================================

extension DoctorListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredDoctors.count : doctors.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: DoctorCell.reuseID,
            for: indexPath
        ) as! DoctorCell

        let doctor = isSearching ? filteredDoctors[indexPath.row] : doctors[indexPath.row]
        cell.configure(with: doctor)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let doctor = isSearching ? filteredDoctors[indexPath.row] : doctors[indexPath.row]

        let vc = PhysiotherapistDetailViewController()
        vc.configureWith(doctor: doctor)

        vc.onBookingComplete = { [weak self] doctor, date in
            self?.onBookingComplete?(doctor, date)
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}

// ===========================================================
// MARK: - SEARCH BAR
// ===========================================================

extension DoctorListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            isSearching = false
            filteredDoctors = doctors
        } else {
            isSearching = true

            filteredDoctors = doctors.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.specialization.lowercased().contains(searchText.lowercased()) ||
                $0.distance.lowercased().contains(searchText.lowercased())
            }
        }

        doctorListView.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        filteredDoctors = doctors
        searchBar.text = ""
        doctorListView.tableView.reloadData()
    }
}
