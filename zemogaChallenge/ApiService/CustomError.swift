import Foundation

enum CustomError {
    case noData
}
 
extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noData: return "Well, weird thing happens"
        }
    }
}
