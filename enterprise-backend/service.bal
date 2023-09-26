import ballerina/http;

configurable int port = 9093;
configurable string securityServiceUrl = "localhost:9092";

listener http:Listener enterpriseBackend = new (port);

final http:Client securityServiceProvider = check new (securityServiceUrl);

service / on enterpriseBackend {

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
