import AuthenticationServices
@testable import Passage

@available(iOS 16.0, *)
class MockRegistrationAuthorizationController : NSObject, ASAuthorizationControllerDelegate, RegistrationAuthorizationControllerProtocol {
    
    func register(
        from response: WebauthnRegisterStartResponse,
        identifier: String,
        includeSecurityKeyOption: Bool
    ) async throws -> ASAuthorizationPublicKeyCredentialRegistration? {
        return nil
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    }
    
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    }

}
