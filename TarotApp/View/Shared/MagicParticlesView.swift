//
//  MagicParticlesView.swift
//  TarotApp
//
//  Created by Edward Gasparian on 11.04.2025.
//

import SwiftUI

// A model representing a single particle in the system
struct Particle: Identifiable {
    let id = UUID()                     // Unique ID for identifying each particle
    var x: CGFloat                      // X position
    var y: CGFloat                      // Y position
    var size: CGFloat                  // Size of the particle (used for drawing)
    var speed: CGFloat                 // Vertical movement speed
    var opacity: Double                // Opacity of the particle
}

struct MagicParticlesView: View {
    let width: CGFloat                  // Width of the available area for particles
    let height: CGFloat                 // Height of the available area
    @State private var particles: [Particle] = [] // List of current particles
    
    var body: some View {
        // TimelineView allows you to animate over time using system-driven updates
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                // Draw each particle as a glowing circle
                for i in particles.indices {
                    let particle = particles[i]
                    
                    var circle = Path()
                    circle.addEllipse(in: CGRect(x: particle.x, y: particle.y, width: particle.size, height: particle.size))
                    
                    // Fill the circle with semi-transparent glowing gold color
                    context.fill(circle, with: .color(.pureGold.opacity(particle.opacity)))
                }
            }
        }
        .onAppear {
            // Initialize particles with random positions, sizes, speeds and opacities
            particles = (0..<50).map { _ in
                Particle(
                    x: CGFloat.random(in: 0...width),
                    y: CGFloat.random(in: 0...height),
                    size: CGFloat.random(in: 2...6),
                    speed: CGFloat.random(in: 0.5...1.5),
                    opacity: Double.random(in: 0.3...0.8)
                )
            }
        }
        // Update particles every ~16ms (60 FPS)
        .onReceive(Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()) { _ in
            for i in particles.indices {
                // Move particle upward
                particles[i].y -= particles[i].speed
                
                // If it goes above the top edge, reset it to the bottom
                if particles[i].y < 0 {
                    particles[i].y = height
                    particles[i].x = CGFloat.random(in: 0...width)
                }
            }
        }
        .allowsHitTesting(false)      // Let touches pass through
        .blendMode(.plusLighter)      // Additive blend for glowing effect
    }
}

// Preview with a black background and fixed size
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        MagicParticlesView(width: 300, height: 600)
    }
}
