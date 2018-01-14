import UIKit

public struct ColorConverter {
    public static func colorFor(index: Int) -> UIColor {
        let colors = [
            UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0), //blue
            UIColor(red:0.23, green:0.76, blue:0.60, alpha:1.0), //green
            UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0), //red
            UIColor(red:0.90, green:0.49, blue:0.13, alpha:1.0), //orange
            UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0), //purple
            UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.0), //dark blue
            UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0), //light green
            UIColor(red:0.75, green:0.22, blue:0.17, alpha:1.0), //dark red
            UIColor(red:0.95, green:0.61, blue:0.07, alpha:1.0), //light orange
        ]
        return colors[index % colors.count]
    }
}
