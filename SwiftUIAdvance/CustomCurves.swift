//
//  CustomCurves.swift
//  SwiftUIAdvance
//
//  Created by loratech on 05/03/24.
//

import SwiftUI

struct CustomCurves: View {
    var body: some View {
        WaterShape()
            .fill(
                LinearGradient(colors: [Color.red, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .ignoresSafeArea()
    }
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: -20),
                endAngle: Angle(degrees: 20),
                clockwise: false)
                
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            // MARK:  Top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            // MARK:  Top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            // MARK:  Mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            // MARK:  bottom
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            // MARK:  mid left
            path.addLine(to: CGPoint(x: rect.minY, y: rect.midY))
        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: .zero)
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100)
            )
        }
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40)
            )
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60)
            )
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
    }
}

#Preview {
    CustomCurves()
}
