import ballerina/http;

configurable string securityServiceUrl = "localhost:9092";

final http:Client securityServiceProvider = check new (securityServiceUrl);

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
