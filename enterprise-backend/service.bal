import ballerina/http;

listener http:Listener enterpriseBackend = new (9093);

final http:Client securityServiceProvider = check new ("localhost:9092");

service / on enterpriseBackend {

    resource function post initiate\-request(NumberVerificationRequest payload)
            returns NetworkVerification|error {

        NetworkVerification|error response = securityServiceProvider->/init\-request.post(payload);
        return response;
    }

    resource function post 'check\-result(NumberVerificationRequest payload)
            returns NumberVerificationResponse|error {

        NumberVerificationResponse|error response = securityServiceProvider->/verify.post(payload);
        return response;
    }
}
