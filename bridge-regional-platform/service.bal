import ballerina/http;

configurable string supplierBMOServiceURL = "localhost:9090";
configurable string tokenUrl = "https://localhost:9445/oauth2/token";
configurable string clientId = "FlfJYKBD2c925h4lkycqNZlC2l4a";
configurable string clientSecret = "PJz0UhTJMrHOo68QQNpvnqAY_3Aa";

service /number\-verification/v0 on new http:Listener(9091) {

    isolated resource function post init\-request(NumberVerificationRequest payload) returns NetworkVerificationResponse|InternalServerError {
        do {
            http:Client supplierBMOClient = check new (supplierBMOServiceURL,
                auth = {
                    tokenUrl: tokenUrl,
                    clientId: clientId,
                    clientSecret: clientSecret,
                    scopes: "admin"
                }
            );
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
            http:Client supplierBMOClient = check new (supplierBMOServiceURL,
                auth = {
                    tokenUrl: tokenUrl,
                    clientId: clientId,
                    clientSecret: clientSecret,
                    scopes: "admin"
                }
            );
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
