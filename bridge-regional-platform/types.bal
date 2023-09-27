import ballerina/http;

public type InternalServerError record {|
    *http:InternalServerError;
    ErrorInfo body;
|};

public type OkNumberVerification record {|
    *http:Ok;
    NumberVerification body;
|};

public type BadRequest record {|
    *http:BadRequest;
    ErrorInfo body;
|};

public type NumberVerification record {
    boolean devicePhoneNumberVerified;
};

public type ErrorInfo record {
    int status;
    string code;
    string message;
};

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
    string token?;
|};

public type NetworkVerificationBody record {|
    string url;
    string sessionId?;
|};
