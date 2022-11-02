//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation

protocol MainVCOutput {
    func viewIsReady()
}

final class MainPresenter {
    weak var view: MainVCInput?
    private let dataConverter: MainDataConverterInput?
    private let networkManager: NetworkManager?
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone.current
        return formatter
    } ()


    
    init(dataConverter: MainDataConverterInput, networkManager: NetworkManager) {
        self.dataConverter = dataConverter
        self.networkManager = networkManager
    }
}


extension MainPresenter: MainVCOutput {
    func viewIsReady() {
        let textDate1 = "2022-10-29 22:32:16 +0300"
        let nowTime = dateFormatter.string(from: Date())
        let date1 = dateFormatter.date(from: textDate1)
        let date2 = dateFormatter.date(from: String("\(nowTime)"))

        if let date1 = date1, let date2 = date2 {
            let diff = date1.timeOfDayInterval(toDate: date2)

            // as text
            if diff > 0 {
                print("Time of the day in the second date is greater")
            } else if diff < 0 {
                print("Time of the day in the first date is greater")
            } else {
                print("Times of the day in both dates are equal")
            }


            // show interval as as H M S
            let timeIntervalFormatter = DateComponentsFormatter()
            timeIntervalFormatter.unitsStyle = .abbreviated
            timeIntervalFormatter.allowedUnits = [.hour, .minute, .second]
            print("Difference between times since midnight is", timeIntervalFormatter.string(from: diff) ?? "n/a")

        }


        getData()
    }
    

}

extension MainPresenter: MainTVManagerDelegate {
}


extension MainPresenter {
    private func getData() {
        networkManager?.request(fromURL: URL(string: App.url)!, completion: { (result: Result<MainModel, Error>) in
            switch result {
            case .success(let items):
                guard let viewModel = self.dataConverter?.convert(data: items, delegate: self) else { return }
                self.view?.success(viewModel: viewModel, delegate: self)
                print(items)
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func getTime() {
        
    }
    
    
}



// Date extensions
extension Date {
    func secondsFromBeginningOfTheDay() -> TimeInterval {
        let calendar = Calendar.current
        // omitting fractions of seconds for simplicity
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: self)

        let dateSeconds = dateComponents.hour! * 3600 + dateComponents.minute! * 60 + dateComponents.second!

        return TimeInterval(dateSeconds)
    }

    // Interval between two times of the day in seconds
    func timeOfDayInterval(toDate date: Date) -> TimeInterval {
        let date1Seconds = self.secondsFromBeginningOfTheDay()
        let date2Seconds = date.secondsFromBeginningOfTheDay()
        return date2Seconds - date1Seconds
    }
}
