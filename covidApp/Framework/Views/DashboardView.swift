//
//  DashboardView.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = CovidDashboardViewModel()
    
    private let suggestedCountries = [
        "Canada", "Mexico", "United States", "Brazil", "Spain",
        "France", "Germany", "Italy", "India", "Japan",
        "China", "Argentina", "Chile", "Peru", "South Africa"
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(spacing: 4) {
                    Text("COVID-19")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top, 16)
                
                HStack {
                    TextField("Escribe un país (ej. Canada)", text: $viewModel.searchText)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        Task {
                            await viewModel.loadCountry()
                        }
                    } label: {
                        Text("Buscar")
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(suggestedCountries, id: \.self) { country in
                            Button {
                                viewModel.searchText = country
                                Task {
                                    await viewModel.loadCountry()
                                }
                            } label: {
                                Text(country)
                                    .font(.caption)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                contentView
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await viewModel.loadInitialCountry()
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            VStack(spacing: 8) {
                ProgressView()
                Text("Cargando datos...")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 12) {
                Text(error)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                
                Button {
                    Task {
                        await viewModel.loadCountry()
                    }
                } label: {
                    Text("Reintentar")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.summaries.isEmpty {
            VStack(spacing: 8) {
                Text("Busca un país para ver estadísticas de COVID-19.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.summaries, id: \.displayName) { summary in
                        SummaryCard(summary: summary, latest: viewModel.latestEntry(for: summary))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
    }
}

struct SummaryCard: View {
    let summary: CovidCountrySummary
    let latest: CovidTimelineEntry?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(summary.displayName)
                .font(.headline)
            
            if let latest = latest {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Última fecha: \(latest.dateString)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Casos totales: \(latest.totalCases)")
                            Text("Casos nuevos: \(latest.newCases)")
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Muertes totales: \(latest.totalDeaths ?? 0)")
                            Text("Muertes nuevas: \(latest.newDeaths ?? 0)")
                        }
                    }
                    .font(.caption)
                }
            } else {
                Text("No se encontró información reciente.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            let lastEntries = Array(summary.timeline.suffix(7)).reversed()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Últimos días:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                ForEach(lastEntries, id: \.dateString) { entry in
                    HStack {
                        Text(entry.dateString)
                            .font(.caption2)
                            .frame(width: 80, alignment: .leading)
                        
                        Text("Casos:\(entry.newCases)")
                            .font(.caption2)
                        if let nd = entry.newDeaths {
                            Text(" M:\(nd)")
                                .font(.caption2)
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    DashboardView()
}
