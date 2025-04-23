import Foundation

func fetchAUDToUSDRate(callback: @escaping (String) -> Void) {
    guard let url = URL(string: "https://www.rba.gov.au/exchange-rates-overview.html") else {
        return
    }
    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let data = data else {
            return
        }
        var rate: String.SubSequence = ""
        if let htmlString = String(data: data, encoding: .utf8) {
            if let start = htmlString.range(of: "<p class=\"landing-page-chart-statistic-value\">") {
                rate = htmlString[start.upperBound...]
                if let end = rate.range(of: "</p>") {
                    rate = rate[..<end.lowerBound]
                }
            }
        }
        callback(rate.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    task.resume()
}
