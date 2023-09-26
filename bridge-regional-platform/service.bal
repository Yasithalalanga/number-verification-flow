import ballerina/http;

configurable int port = 9091;

configurable string supplierBMOServiceURL = "localhost:9090";

service /number\-verification/v0 on new http:Listener(port) {

    isolated resource function post init\-request(NumberVerificationRequest payload) returns NetworkVerificationResponse|InternalServerError {
        do {
            http:Client supplierBMOClient = check new (supplierBMOServiceURL);
            NetworkVerification response = check supplierBMOClient->/verify.post(payload);
            return {
                body: response
            };
        } on fail error err {
            return {
                body: {
                    status: http:STATUS_INTERNAL_SERVER_ERROR,
                    code: "NUMBER_VERIFICATION.INTERNAL_SERVER_ERROR",
                    message: err.message()
                }
            };
        }
    }

    isolated resource function post verify(@http:Header string? x\-correlator, NumberVerificationRequest payload) returns
            OkNumberVerification|BadRequest|Unauthorized|Forbidden|InternalServerError|ServiceUnavailable|GatewayTimeout {

        do {
            check validateNumberVerificationRequest(payload);
        } on fail error err {
            return <BadRequest>{
                body: {
                    status: http:STATUS_BAD_REQUEST,
                    code: "NUMBER_VERIFICATION.INVALID_REQUEST",
                    message: err.message()
                }
            };
        }
        do {
            http:Client supplierBMOClient = check new (supplierBMOServiceURL);
            NumberVerification response = check supplierBMOClient->/verify\-number.post(payload);
            return {
                body: response
            };
        } on fail error err {
            return <InternalServerError>{
                body: {
                    status: http:STATUS_INTERNAL_SERVER_ERROR,
                    code: "NUMBER_VERIFICATION.INTERNAL_SERVER_ERROR",
                    message: err.message()
                }
            };
        }
    }

}
