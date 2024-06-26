import AuthenticationServices
@testable import Passage

@available(iOS 16.0, *)
class MockLoginAuthorizationController : NSObject, ASAuthorizationControllerDelegate, LoginAuthorizationControllerProtocol {
    
    func login(from response: Passage.WebauthnLoginStartResponse) async throws -> ASAuthorizationPublicKeyCredentialAssertion? {
        return nil
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
}
