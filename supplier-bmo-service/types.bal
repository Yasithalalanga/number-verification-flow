public type NumberVerificationRequest record {
    string phoneNumber?;
    string hashedPhoneNumber?;
};

type NetworkVerification record {|
    string url;
    string sessionId?;
|};

type NetworkState record {|
    string state;
    string code;
    string msisdn;
|};
