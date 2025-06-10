//
//  DogsListTests.swift
//  DogsListTests
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import XCTest
@testable import DogsList

final class DogsListTests: XCTestCase {
    var sut: MockDogListPresenter?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MockDogListPresenter()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDogsList() throws {
        let expectation = expectation(description: "Wait until web service returns data")
        sut?.getDogsList(completion: { result in
            switch result {
            case .success(_): break
            case .failure(_): break
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 30)
        XCTAssertEqual(sut?.dataSource.first?.dogName, "Rex")
        XCTAssertEqual(sut?.dataSource.first?.description, "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot")
        XCTAssertEqual(sut?.dataSource.first?.age, 5)
        XCTAssertEqual(sut?.dataSource.first?.image, "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634")
    }
    
    func testPresentError() throws {
        sut?.presentError(message: "Error")
        XCTAssertEqual(sut?.onPresentError, true)
    }
    
    func testShowDetails() throws {
        let expectation = expectation(description: "Wait until web service returns data")
        sut?.getDogsList(completion: { result in
            switch result {
            case .success(_): break
            case .failure(_): break
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 30)
        sut?.showDetails(for: sut?.dataSource.first)
        XCTAssertEqual(sut?.onShowDetails, true)
    }
    
    func testSaveList() throws {
        let expectation = expectation(description: "Wait until web service returns data")
        sut?.getDogsList(completion: { result in
            switch result {
            case .success(_): break
            case .failure(_): break
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 30)
        sut?.save(list: sut?.dataSource ?? [])
        XCTAssertEqual(sut?.onSave, true)
    }
    
    func testGetSavedList() throws {
        let expectation = expectation(description: "Wait until web service returns data")
        sut?.getDogsList(completion: { result in
            switch result {
            case .success(_): break
            case .failure(_): break
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 30)
        let dataSource = sut?.getSavedList()
        XCTAssertEqual(dataSource?.last?.dogName, "Spots")
        XCTAssertEqual(dataSource?.last?.description, "Is the brother of Chief and are also a former guard dog for Mayor Kobayashi's ward")
        XCTAssertEqual(dataSource?.last?.age, 3)
        XCTAssertEqual(dataSource?.last?.image, "https://static.wikia.nocookie.net/isle-of-dogs/images/6/6b/Spots.jpg/revision/latest/scale-to-width-down/666?cb=20180624191101")
    }
    
    func testOnDeleteData() throws {
        sut?.deleteData()
        XCTAssertEqual(sut?.onDeleteData, true)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

final class MockDogListPresenter: DogsListPresenterProtocol {
    var onPresentError = false
    var onShowDetails = false
    var onSave = false
    var onDeleteData = false
    var dataSource: [Dog] = []
    var json = """
    [
    {
    "dogName": "Rex",
    "description": "He is much more passive and is the first to suggest to rescue and not eat The Little Pilot",
    "age": 5,
    "image": "https://static.wikia.nocookie.net/isle-of-dogs/images/a/af/Rex.jpg/revision/latest/scale-to-width-down/666?cb=20180625001634"
    },
    {
    "dogName": "Spots",
    "description": "Is the brother of Chief and are also a former guard dog for Mayor Kobayashi's ward",
    "age": 3,
    "image": "https://static.wikia.nocookie.net/isle-of-dogs/images/6/6b/Spots.jpg/revision/latest/scale-to-width-down/666?cb=20180624191101"
    }
    ]
    """
    
    func getDogsList(completion: @escaping (Result<[Dog], Error>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Dog].self, from: json.data(using: .utf8) ?? Data())
            dataSource = result
            completion(.success(result))
        } catch {
            print("Error al decodificar: \(error)")
            return completion(.failure(self.generalError()))
        }
    }
    
    func presentError(message: String) {
        onPresentError = true
    }
    
    func showDetails(for dog: Dog?) {
        onShowDetails = true
    }
    
    func save(list: [DogsList.Dog]) {
        onSave = true
    }
    
    func getSavedList() -> [Dog] {
        return dataSource
    }
    
    func deleteData() {
        onDeleteData = true
    }
    
    func generalError() -> Error {
        return NSError(domain: "",
                       code: 401,
                       userInfo: [ NSLocalizedDescriptionKey: "There was an error fetching data"])
    }
    
}
