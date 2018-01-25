import Foundation

struct APIRequest {
    
    static func retrieveStationsApiKey() -> String {
        let path = Bundle(for: AllStationsRequest.self).path(forResource: "apikey", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        let apiKey = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        return apiKey.replacingOccurrences(of:"\n", with:"")
    }
}
