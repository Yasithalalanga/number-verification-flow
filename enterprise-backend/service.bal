import ballerina/http;

# The URL of the security service provider
configurable string securityServiceUrl = ?;
# The URL of the oauth2 token endpoint of the security service provider
configurable string tokenUrl = ?;
# The oauth2 client id of the security service provider
configurable string clientId = ?;
# The oauth2 client secret of the security service provider
configurable string clientSecret = ?;

# The client to connect to the security service provide service
@display {
    label: "security-service-provider",
    id: "security-service-provider-000"
}
final http:Client securityServiceProvider = check new (securityServiceUrl,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret
    }
);

# Enterprise Backend Service
@display {
    label: "enterprise-backend"
}
service / on new http:Listener(9093) {

    # Handles the phone number initiation request
    # 
    # + payload - number verification request with phone number
    # + return - network verification with verification url and optional sessionId
    resource function post initiateRequest(NumberVerificationRequest payload)
            returns NetworkVerification|error {

        NetworkVerification|error response = securityServiceProvider->/initRequest.post(payload);
        return response;
    }

    # Verifies the phone number
    # 
    # + payload - number verification request with phone number
    # + return - number verification with verification status
    resource function post checkResult(NumberVerificationRequest payload)
            returns NumberVerification|error {

        NumberVerification|error response = securityServiceProvider->/verify.post(payload);
        return response;
    }
}
