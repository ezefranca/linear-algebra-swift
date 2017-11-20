//
//  AppDelegate.swift
//  Vector_Sum
//
//  Created by Ezequiel França on 19/11/17.
//  Copyright © 2017 Ezequiel. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        guard let frame = self.window.contentView?.frame else {
            return
        }
        
        self.window.backgroundColor = NSColor.darkGray
        
        let coordinates1 = Vector2(x: 100, y: 100)
        let vector1 = Vector(frame: frame, coordinates: coordinates1, vectorColor: .red)
       
        let coordinates2 = Vector2(x: 10, y: 100)
        let vector2 = Vector(frame: frame, coordinates: coordinates2, vectorColor: .blue)
       
        // X = vector1.coordinates.x + vector2.coordinates.x
        // Y = vector1.coordinates.y + vector2.coordinates.y
        let sumVector = Vector(frame: frame, coordinates: coordinates1 + coordinates2, vectorColor: .green)
        
        self.window.contentView?.addSubview(vector1)
        self.window.contentView?.addSubview(vector2)
        self.window.contentView?.addSubview(sumVector)
    }
}

public class Vector: NSView {
    
    private var coordinates:Vector2
    private var vectorColor:NSColor
    private var xAxis:Vector2
    private var Yaxis:Vector2
    
    init(frame frameRect: NSRect, coordinates:Vector2, vectorColor:NSColor) {
        self.coordinates = coordinates
        self.vectorColor = vectorColor
        xAxis = Vector2(x: 0, y: Scalar(frameRect.size.height))
        Yaxis = Vector2(x: Scalar(frameRect.size.width), y: 0)
        super.init(frame:frameRect)
    }
    
    required public init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawAxis(drawVector:Vector2) {
        if let context = self.currentContext {
        context.beginPath()
        context.move(to: CGPoint.zero)
        context.addLine(to: CGPoint(x: Double(drawVector.x), y: Double(drawVector.y)))
        context.setStrokeColor(NSColor.black.cgColor)
        context.setLineWidth(5.0)
        context.strokePath()
        }
    }
    
    private var currentContext : CGContext? {
        get {
            return NSGraphicsContext.current?.cgContext
        }
    }
    
    private func saveGState(_ drawVector:Vector2, _: (_ ctx:CGContext) -> ()) -> () {
        if let context = self.currentContext {
            context.beginPath()
            context.move(to: CGPoint.zero)
            context.addLine(to: CGPoint(x: Double(drawVector.x), y: Double(drawVector.y)))
            context.setStrokeColor((vectorColor.cgColor))
            context.setLineWidth(5.0)
            context.strokePath()
        }
    }
    
    override public func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.drawAxis(drawVector: self.xAxis)
        self.drawAxis(drawVector: self.Yaxis)
        saveGState(self.coordinates) { ctx in
            // Drawing code here.
          
            print("desenhando vector")
        }
    }
}
