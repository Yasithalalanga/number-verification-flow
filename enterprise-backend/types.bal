public type NumberVerificationResponse record {
    DevicePhoneNumberVerified devicePhoneNumberVerified;
};

public type DevicePhoneNumberVerified boolean;

public type NumberVerificationRequest record {
    string phoneNumber?;
    string hashedPhoneNumber?;
};

public type NetworkVerification record {|
    string url;
    string sessionId?;
|};
