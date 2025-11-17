//
//  SupabaseService.swift
//  PhysioConnect
//
//  Created by user@8 on 15/11/25.
//


import Foundation

// ---------------------------------------------------------
// MARK: - Matching EXACT Supabase Table Columns
// ---------------------------------------------------------
struct PhysiotherapistRow: Codable {
    let id: UUID
    let name: String
    let specialization: String?
    let experience: String?            // TEXT in DB
    let rating: Double?
    let reviews: Int?
    let patientsCount: Int?
    let latitude: Double?
    let longitude: Double?
    //let fee_per_hour: String?          // TEXT in DB
    let feePerHour: Int?               // INTEGER in DB
    let description: String?
    let imageURL: String?
}

final class SupabaseService {

    static let shared = SupabaseService()

    private let supabaseURL = URL(string: "https://tptsltxtipojsgbsekdl.supabase.co")!
    private let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRwdHNsdHh0aXBvanNnYnNla2RsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMxOTYwOTQsImV4cCI6MjA3ODc3MjA5NH0.m_avQJKhPWQBoDELq9YhMkskbMWht5rm8y5Q285gfng"

    private init() {}

    // ---------------------------------------------------------
    // MARK: - Generic GET Request
    // ---------------------------------------------------------
    private func get<T: Decodable>(
        path: String,
        query: String? = nil,
        decodeType: T.Type
    ) async throws -> T {

        var url = supabaseURL
        url.appendPathComponent(path) // rest/v1/physiotherapists

        if let query = query {
            var comps = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            comps.query = query
            url = comps.url!
        }

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue(supabaseKey, forHTTPHeaderField: "apikey")
        req.setValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: req)

        if let http = response as? HTTPURLResponse,
           !(200...299).contains(http.statusCode) {

            let body = String(data: data, encoding: .utf8) ?? ""
            throw NSError(
                domain: "SupabaseService",
                code: http.statusCode,
                userInfo: [NSLocalizedDescriptionKey: "HTTP \(http.statusCode): \(body)"]
            )
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    // ---------------------------------------------------------
    // MARK: - PUBLIC API
    // ---------------------------------------------------------

    /// Fetch ALL physiotherapists
    func fetchPhysiotherapists() async throws -> [PhysiotherapistRow] {
        let result: [PhysiotherapistRow] = try await get(
            path: "rest/v1/physiotherapists",
            query: "select=*",
            decodeType: [PhysiotherapistRow].self
        )

        print("DEBUG FETCH COUNT:", result.count)
        print("DEBUG SAMPLE:", result.first ?? "NONE")

        return result
    }

    /// Fetch ONE physiotherapist by UUID
    func fetchPhysiotherapistDetail(id: UUID) async throws -> PhysiotherapistRow? {
        let rows: [PhysiotherapistRow] = try await get(
            path: "rest/v1/physiotherapists",
            query: "id=eq.\(id.uuidString)&select=*",
            decodeType: [PhysiotherapistRow].self
        )
        return rows.first
    }
}
