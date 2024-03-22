@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    
    private var app: Application!
    
    override func setUp() async throws
    {
        try await super.setUp()
        
        app = Application(.testing)
        try await configure(app)
    }
    
    override func tearDown() async throws
    {
        app.shutdown()
        
        try await super.tearDown()
    }
    
    func testHelloWorld() throws
    {
        try app.test(.GET, "hello") { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        }
    }
    
    func testRoot() throws
    {
        try app.test(.GET, "/") { res in
            XCTAssertEqual(res.status, .ok)
        }
    }
    
    func testMockingRequest()
    {
        _ = Request(application: app, on: app.eventLoopGroup.next())
        
        XCTAssertTrue(true)
    }
}
