
import Vapor
import ImperialGoogle

struct GoogleController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws
    {
        guard let callbackURL = Environment.get("GOOGLE_CALLBACK_URL") else {
            fatalError("Google callback URL not found in Environment")
        }
        
        try routes.oAuth(
            from: Google.self,
            authenticate: "login/google",
            callback: callbackURL,
            scope: [ "profile", "email" ],
            completion: processLogin
        )
    }
    
    func processLogin(
        req: Request,
        token: String
    ) throws -> EventLoopFuture<ResponseEncodable> {
        let promise = req.eventLoop.makePromise(of: ResponseEncodable.self)
        promise.completeWithTask {
            return req.redirect(to: "/")
        }
        
        return promise.futureResult
    }
}
