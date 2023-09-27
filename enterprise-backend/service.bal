import ballerina/http;

configurable string securityServiceUrl = ?;
configurable string tokenUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

final http:Client securityServiceProvider = check new (securityServiceUrl,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret
    }
);

service / on new http:Listener(9093) {

    resource function post initiate\-request(NumberVerificationRequest payload)
            returns NetworkVerification|error {

        NetworkVerification|error response = securityServiceProvider->/init\-request.post(payload);
        return response;
    }

    resource function post 'check\-result(NumberVerificationRequest payload)
            returns NumberVerification|error {

        NumberVerification|error response = securityServiceProvider->/verify.post(payload);
        return response;
    }
}
