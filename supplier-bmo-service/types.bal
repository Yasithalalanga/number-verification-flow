public type NumberVerificationRequest record {
    string phoneNumber?;
    string hashedPhoneNumber?;
};

type NetworkVerification record {|
    string url;
    string sessionId?;
    string token?;
|};

type NetworkState record {|
    string state;
    string code;
    string msisdn;
|};

public type NumberVerification record {
    boolean devicePhoneNumberVerified;
};
