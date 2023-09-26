import ballerina/http;

public type InternalServerError record {|
    *http:InternalServerError;
    ErrorInfo body;
|};

public type Unauthorized record {|
    *http:Unauthorized;
    ErrorInfo body;
|};

public type GatewayTimeout record {|
    *http:GatewayTimeout;
    ErrorInfo body;
|};

public type ServiceUnavailable record {|
    *http:ServiceUnavailable;
    ErrorInfo body;
|};

public type OkNumberVerificationMatchResponse record {|
    *http:Ok;
    NumberVerificationResponse body;
|};

public type BadRequest record {|
    *http:BadRequest;
    ErrorInfo body;
|};

public type Forbidden record {|
    *http:Forbidden;
    ErrorInfo body;
|};

public type NumberVerificationResponse record {
    DevicePhoneNumberVerified devicePhoneNumberVerified;
};

public type ErrorInfo record {
    int status;
    string code;
    string message;
};

public type DevicePhoneNumberVerified boolean;

public type NumberVerificationRequest record {
    string phoneNumber?;
    string hashedPhoneNumber?;
};

public type NetworkVerificationResponse record {|
    *http:Ok;
    NetworkVerification body;
|};

public type NetworkVerification record {|
    string url;
    string sessionId?;
|};

