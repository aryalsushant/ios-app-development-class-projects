//
//  ContentView.swift
//  PlantWateringTracker
//
//  Created by Sushant Aryal on 9/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var plantHealth = 1
    @State private var waterCount = 0
    @State private var skippedDays = 0

    private let stages = ["🥀", "🌱", "🪴", "🌻"]

    private var plantEmoji: String {
        stages[plantHealth]
    }

    private var moodTitle: String {
        switch plantHealth {
        case 0:
            return "Needs water"
        case 1:
            return "Hanging in there"
        case 2:
            return "Growing strong"
        default:
            return "Blooming!"
        }
    }

    private var careMessage: String {
        switch plantHealth {
        case 0:
            return "Your plant is droopy. Give it some love."
        case 1:
            return "A little care today will help it perk up."
        case 2:
            return "Nice work. The leaves are looking brighter."
        default:
            return "Perfect care streak. Your plant is thriving."
        }
    }

    private var progressValue: Double {
        Double(plantHealth) / Double(stages.count - 1)
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.88, green: 0.96, blue: 0.91),
                    Color(red: 0.98, green: 0.94, blue: 0.83)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(spacing: 10) {
                    Text("Plant Care")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(red: 0.13, green: 0.27, blue: 0.17))

                    Text("Tap a button to change your plant's day.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 18) {
                    Text(plantEmoji)
                        .font(.system(size: 110))
                        .contentTransition(.symbolEffect(.replace))

                    Text(moodTitle)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(red: 0.15, green: 0.32, blue: 0.21))

                    Text(careMessage)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 280)

                    ProgressView(value: progressValue)
                        .tint(Color(red: 0.14, green: 0.55, blue: 0.25))
                        .padding(.horizontal)
                }
                .padding(28)
                .frame(maxWidth: 360)
                .background(.white.opacity(0.82))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: 10)

                HStack(spacing: 14) {
                    StatView(label: "Waters", value: waterCount, color: .blue)
                    StatView(label: "Skipped", value: skippedDays, color: .orange)
                }

                HStack(spacing: 14) {
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            waterCount += 1
                            plantHealth = min(plantHealth + 1, stages.count - 1)
                        }
                    } label: {
                        Label("Water plant", systemImage: "drop.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.13, green: 0.55, blue: 0.83))

                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            skippedDays += 1
                            plantHealth = max(plantHealth - 1, 0)
                        }
                    } label: {
                        Label("Skip a day", systemImage: "sun.max.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(Color(red: 0.77, green: 0.42, blue: 0.12))
                }
                .controlSize(.large)
                .frame(maxWidth: 360)
            }
            .padding()
        }
    }
}

struct StatView: View {
    let label: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(color)

            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .frame(width: 120, height: 72)
        .background(.white.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
