//
//  CityDetailViewModelTests.swift
//  Weather
//
//  Created by David Silva on 14/09/2023.
//

import XCTest

@testable import Weather

class CityDetailViewModelTests: XCTestCase {
    
    override func setUp() {

        super.setUp()
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testMapForecast() async throws {
        
        let expectedCount = MockData.forecast.list.count
        let expectedDate = "2023-09-14"
        let expectedForecast = DayForecast(time: "15",
                                           temperature: 20,
                                           icon: "01d")
        
        let weatherForecast = await CityDetailViewModel.mapForecast(MockData.forecast)
        
        XCTAssertEqual(weatherForecast.count, expectedCount)
        
        let first = try XCTUnwrap(weatherForecast.first)
        
        XCTAssertEqual(first.date, expectedDate)
        XCTAssertEqual(first.forecast.time, expectedForecast.time)
        XCTAssertEqual(first.forecast.temperature, expectedForecast.temperature)
        XCTAssertEqual(first.forecast.icon, expectedForecast.icon)
    }
    
    func testGroupByDay() async throws {
        
        let expectedCount = 2
        let expectedFirstDate = "2023-09-14"
        let expectedSecondDate = "2023-09-15"

        let weatherForecast = await CityDetailViewModel.mapForecast(MockData.forecast)
        let infoByDay = await CityDetailViewModel.groupByDay(weatherForecast)
        
        XCTAssertEqual(infoByDay.count, expectedCount)
        
        let first = try XCTUnwrap(infoByDay.first)
        let second = try XCTUnwrap(infoByDay[1])
        
        XCTAssertEqual(first.day, expectedFirstDate)
        XCTAssertEqual(second.day, expectedSecondDate)
    }
}
