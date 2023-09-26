import ballerina/http;

configurable int port = 9093;
configurable string securityServiceUrl = "localhost:9092";

final http:Client securityServiceProvider = check new (securityServiceUrl);

service / on new http:Listener(port) {

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
