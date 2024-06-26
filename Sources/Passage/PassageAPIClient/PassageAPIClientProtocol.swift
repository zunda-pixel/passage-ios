import AuthenticationServices

/// Protocol that any Passage API Client must implement
protocol PassageAuthAPIClient  {
    
    /// The Passage AppId
    var appId: String? { get set }
    
    /// The baseUrl of the api server. This should be set in
    /// the Passage.plist file or it will default to the production url
    var baseUrl: String? { get set }
    
    /// Get the configured Passage Application details.
    /// - Returns: ``AppInfo``
    func appInfo() async throws -> AppInfo
    
    
    /// Perform a webauthn login start request
    /// - Returns: ``WebauthnLoginStartResponse``
    /// - Throws: ``PassageAPIClientError``
    @available(iOS 16.0, *)
    func webauthnLoginStart(identifier: String?) async throws -> WebauthnLoginStartResponse
    
    
    /// Perform a webauthn login finish request to complete an authentication attempt
    /// - Parameters:
    ///   - startResponse: ``WebauthnLoginStartResponse`` from the previous login start request
    ///   - credentialAssertion: ``ASAuthorizationPlatformPublicKeyCredentialAssertion``
    /// - Returns: ``AuthResult``
    /// - Throws: ``PassageAPIClientError``
    @available(iOS 16.0, *)
    func webauthnLoginFinish(
        startResponse: WebauthnLoginStartResponse,
        credential: ASAuthorizationPublicKeyCredentialAssertion?
    ) async throws -> AuthResult
    
    
    /// Perform a webauthn registration start request
    /// - Parameter identifier: The users identifier (email or phone number)
    /// - Returns: ``WebauthnRegisterStartResponse``
    /// - Throws: ``PassageAPIClientError``
    @available(iOS 16.0, *)
    func webauthnRegistrationStart(
        identifier: String,
        authenticatorAttachment: AuthenticatorAttachment?
    ) async throws -> WebauthnRegisterStartResponse
    
    
    /// Performa a webauthn registration finish request
    /// - Parameters:
    ///   - startResponse: ``WebauthnRegisterStartResponse`` from the registrationStart request
    ///   - credential: ``ASAuthorizationPublicKeyCredentialRegistration`` from the credential registration request
    /// - Returns: ``AuthResult``
    /// - Throws: ``PassageAPIClientError``
    @available(iOS 16.0, *)
    func webauthnRegistrationFinish(
        startResponse: WebauthnRegisterStartResponse,
        credential: ASAuthorizationPublicKeyCredentialRegistration?
    ) async throws -> AuthResult
    
    
    /// Peform a webauthn add device start request
    /// - Parameter token: The users access token
    /// - Returns: ``WebauthnRegisterStartResponse``
    /// - Throws ``PassageAPIClientError``
    @available(iOS 16.0, *)
    func addDeviceStart(token: String) async throws -> WebauthnRegisterStartResponse
    
    
    /// Perform a webauthn add device finish request
    /// - Parameters:
    ///   - token: The users access token
    ///   - startResponse: The ``WebauthnRegisterStartResponse`` from the  addDeviceStart request
    ///   - params: The ASAuthorizationPlatformPublicKeyCredentialRegistration
    /// - Returns: ``Void``
    @available(iOS 16.0, *)
    func addDeviceFinish(
        token: String,
        startResponse: WebauthnRegisterStartResponse,
        credential: ASAuthorizationPublicKeyCredentialRegistration
    ) async throws -> DeviceInfo
    
    
    /// Send a new login magic link to the user's email or phone
    /// - Parameters:
    ///   - identifier: The users email or phone number
    ///   - path: optional path to append to the redirect url
    ///   - language: optional language string for localizing emails, if no lanuage or an invalid language is provided the application default lanuage will be used
    /// - Returns: ``MagicLink``
    func sendLoginMagicLink(identifier: String, path: String?, language: String?) async throws -> MagicLink
    
    
    /// Send a new registration magic link to the users email or phone
    /// - Parameters:
    ///   - identifier: The users email or phone number
    ///   - path: optional path to append to the redirect url
    ///   - language: optional language string for localizing emails, if no lanuage or an invalid language is provided the application default lanuage will be used
    /// - Returns: ``MagicLink``
    func sendRegisterMagicLink(identifier: String, path: String?, language: String?) async throws -> MagicLink
    
    
    /// Check the status of a magic link
    /// - Parameter id: magic link id
    /// - Returns: ``AuthResult``
    func magicLinkStatus(id: String) async throws -> AuthResult
    
    
    /// Active a magic link
    /// - Parameter magicLink: The magic link to activate
    /// - Returns: ``AuthResult``
    func activateMagicLink(magicLink: String) async throws -> AuthResult
    
    
    /// Send a new login one time passcode to the user's email or phone
    /// - Parameters:
    ///   - identifier: The users email or phone number
    ///   - language: optional language string for localizing emails, if no lanuage or an invalid language is provided the application default lanuage will be used
    /// - Returns: ``OneTimePasscode``
    func sendLoginOneTimePasscode(identifier: String, language: String?) async throws -> OneTimePasscode
    
    
    /// Send a new registration one time passcode to the user's email or phone
    /// - Parameters:
    ///   - identifier: The users email or phone number
    ///   - language: optional language string for localizing emails, if no lanuage or an invalid language is provided the application default lanuage will be used
    /// - Returns: ``OneTimePasscode``
    func sendRegisterOneTimePasscode(identifier: String, language: String?) async throws -> OneTimePasscode
    
    
    /// Active a magic link
    /// - Parameters:
    ///   - otp: The one time passcode to activate
    ///   - otpId: The one time passcode id
    /// - Returns: ``AuthResult``
    func activateOneTimePasscode(otp: String, otpId: String) async throws -> AuthResult
    
    /// Get social authorization url
    /// - Parameters:
    ///   - queryParams: Request query parameters
    /// - Returns: ``URL``
    func getAuthUrl(queryParams: String) throws -> URL
    
    /// Exchange social auth code for AuthResult
    /// - Parameters:
    ///   - code: Social auth code
    ///   - verifier: Social auth verifier
    /// - Returns: ``AuthResult``
    func exchange(code: String, verifier: String) async throws -> AuthResult
    
    /// Exchange social auth code and id token for AuthResult
    /// - Parameters:
    ///   - code: Social auth code
    ///   - idToken: Social auth id token
    /// - Returns: ``AuthResult``
    func exchange(code: String, idToken: String) async throws -> AuthResult
    
    /// Get the detail for the current user
    /// - Parameter token: The user's access token
    /// - Returns: ``PassageUserInfo``
    func currentUser(token: String) async throws -> PassageUserInfo
    
    
    /// Make a request to get the current user's devices
    /// - Parameter token: The user's access token
    /// - Returns: Array of ``DeviceInfo``
    func listDevices(token: String) async throws -> [DeviceInfo]
    
    
    /// Change the current user's email, will send a magic link to confirm
    /// - Parameters:
    ///   - token: The user's access token
    ///   - newEmail: New email address
    ///   - magicLinkPath: optional path to append to the redirect url
    ///   - redirectUrl: optional path to append to the redirect url
    ///   - language: optional language string for localizing emails, if no lanuage or an invalid language is provided the application default lanuage will be used
    /// - Returns: ``MagicLink``
    func changeEmail(token: String, newEmail: String, magicLinkPath: String?, redirectUrl: String?, language: String?) async throws -> MagicLink

    
    /// Change the current user's phone, will send a magic link to confirm
    /// - Parameters:
    ///   - token: The user's access token
    ///   - newPhone: The user's new phone number
    ///   - magicLinkPath: optional path to append to the redirect url
    ///   - redirectUrl: optional path to append to the redirect url
    ///   - language: optional language string for localizing emails, if no lanuage or an invalid language is provided the application default lanuage will be used
    /// - Returns: ``MagicLink``
    func changePhone(token: String, newPhone: String, magicLinkPath: String?, redirectUrl: String?, language: String?) async throws -> MagicLink
    
    
    /// Update the user's device, only supports the friendly name currently
    /// - Parameters:
    ///   - token: The user's access token
    ///   - deviceId: The id of the device to update
    ///   - friendlyName: The device's new friendly name
    /// - Returns: ``DeviceInfo``
    func updateDevice(token: String, deviceId: String, friendlyName: String) async throws -> DeviceInfo

    
    /// Revoke the device
    /// - Parameters:
    ///   - token: The user's access token
    ///   - deviceId: The id of the device to revoke
    /// - Returns: Void
    func revokeDevice(token: String, deviceId: String) async throws -> Void
    
    
    /// Load a user
    /// - Parameter The identifier (email or phone) of the user to get
    /// - Returns: ``PassageUserInfo``
    func getUser(identifier: String) async throws -> PassageUserInfo
    
    /// Refresh a session using a refresh token
    ///  - Parameter The user's refresh token
    ///  - Returns ``AuthResult``
    ///  - Throws ``PassageAPIError``
    func refresh(refreshToken: String) async throws -> AuthResult
    
    /// Sign out the current user's session
    /// - Parameter The user's refresh token
    /// - Returns: Void
    /// - Throws: ``PassageAPIError``
    func signOut(refreshToken: String) async throws
}
