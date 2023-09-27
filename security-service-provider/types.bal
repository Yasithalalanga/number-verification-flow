public type NumberVerification record {
    boolean devicePhoneNumberVerified;
};

public type NumberVerificationRequest record {
    string phoneNumber?;
    string hashedPhoneNumber?;
};

public type NetworkVerification record {|
    string url;
    string sessionId?;
|};
