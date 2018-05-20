
#import "TransactionVC.h"
#import "Reachability.h"

@interface TransactionVC ()

@end

@implementation TransactionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mCreditInformationLabel.font = [UIFont boldSystemFontOfSize: 18];
    _mCreditCardNumberLabel.font = [UIFont systemFontOfSize: 14];
    _mCVVLabel.font = [UIFont systemFontOfSize: 14];
    _mFirstNameLabel.font = [UIFont systemFontOfSize: 14];
    _mLastNameLabel.font = [UIFont systemFontOfSize: 14];
    _mCityLabel.font = [UIFont systemFontOfSize: 14];
    _mZipcodeLabel.font = [UIFont systemFontOfSize: 14];
    _mTransactionButton.titleLabel.font = [UIFont boldSystemFontOfSize: 18];
    
    _mCreditInformationLabel.textColor = [UIColor whiteColor];
    _mTransactionButton.titleLabel.textColor = [UIColor whiteColor];
    
    _mCreditInformationLabel.text = @"Enter Credit Card Information:";
    _mCreditCardNumberLabel.text = @"Credit Card Number:";
    _mCVVLabel.text = @"CVV:";
    _mFirstNameLabel.text = @"First Name:";
    _mLastNameLabel.text = @"Last Name:";
    _mCityLabel.text = @"City:";
    _mZipcodeLabel.text = @"Zipcode:";
    
    _mCreditCardNumberTextField.tag = 0;
    _mCVVTextField.tag = 1;
    _mFirstNameTextField.tag = 2;
    _mLastNameTextField.tag = 3;
    _mStreetTextField.tag = 4;
    _mCityTextField.tag = 5;
    _mZipcodeTextField.tag = 6;
    
    _mCreditCardNumberTextField.placeholder = @"XXXX-XXXX-XXXX-XXXX";
    _mCVVTextField.placeholder = @"XXX";
    _mFirstNameTextField.placeholder = @"Enter First Name";
    _mLastNameTextField.placeholder = @"Enter Last Name";
    _mStreetTextField.placeholder = @"Enter Street Address";
    _mCityTextField.placeholder = @"Enter City";
    _mZipcodeTextField.placeholder = @"Zipcode";
    
    _mCreditInformationView.frame = CGRectMake(20, 117, 291, 41);
    _mCreditInformationLabel.frame = CGRectMake(8, 10, 278, 21);
    _mCreditCardNumberTextField.frame = CGRectMake(170, 177, 189, 30);
    _mCVVTextField.frame = CGRectMake(170, 177, 189, 30);
    _mFirstNameTextField.frame = CGRectMake(170, 253, 137, 30);
    _mLastNameTextField.frame = CGRectMake(170, 291, 137, 30);
    _mStreetTextField.frame = CGRectMake(170, 329, 156, 30);
    _mCityTextField.frame = CGRectMake(170, 329, 156, 30);
    _mZipcodeTextField.frame = CGRectMake(170, 405, 67, 30);
    _mTransactionView.frame = CGRectMake(15, 563, 382, 45);
    _mTransactionButton.frame = CGRectMake(0, 0, 382, 45);
    
//    _mCreditInformationView.backgroundColor =
//    _mTransactionView.backgroundColor =
    
    _mFirstNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mLastNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mCityTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mStreetTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _mFirstNameTextField.returnKeyType = UIReturnKeyDone;
    _mLastNameTextField.returnKeyType = UIReturnKeyDone;
    _mCreditCardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mCVVTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mCityTextField.returnKeyType = UIReturnKeyDone;
    _mStreetTextField.returnKeyType = UIReturnKeyDone;
    _mZipcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
 
    [self addDoneButtonsToFields];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)isNetworkAvailable {
    return [[Reachability reachabilityWithHostName:@"www.google.com"] currentReachabilityStatus];
}

-(void)showNoNetworkConnectionAlert{
    if ([self isNetworkAvailable] == NotReachable) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Check Network Connection" message:@"Please check internet connection and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Ok action here
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *charactersFromTextField = [NSCharacterSet characterSetWithCharactersInString: string];
    
    BOOL isStringValid = [numbers isSupersetOfSet:charactersFromTextField];
    
    switch (textField.tag) {
            
        case 0:
            return newLength <= 30;
            
        case 1:
            return newLength <= 30;
            
        case 2:
            return newLength <= 20 && isStringValid;
            
        case 3:
            return newLength <= 3 && isStringValid;
            
        case 4:
            return newLength <= 25;
            
        case 5:
            return newLength <= 25;
            
        case 6:
            return newLength <= 5 && isStringValid;
            
        default:
            return newLength <= 25;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case 0:
            [_mFirstNameTextField resignFirstResponder];
            return TRUE;
            
        case 1:
            [_mLastNameTextField resignFirstResponder];
            return TRUE;
            
        case 2:
            [_mCreditCardNumberTextField resignFirstResponder];
            return TRUE;
        
        case 3:
            [_mCVVTextField resignFirstResponder];
            return TRUE;
            
        case 4:
            [_mStreetTextField resignFirstResponder];
            return TRUE;
    
        case 5:
            [_mCityTextField resignFirstResponder];
            return TRUE;
            
        case 6:
            [_mZipcodeTextField resignFirstResponder];
            return TRUE;
            
        default:
            return true;
    }
}

- (void)addDoneButtonsToFields {
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self.view action:@selector(endEditing:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    _mCreditCardNumberTextField.inputAccessoryView = keyboardToolbar;
    _mCVVTextField.inputAccessoryView = keyboardToolbar;
    _mZipcodeTextField.inputAccessoryView = keyboardToolbar;
}

-(void)makeTransaction{
    
    NSString *firstName = _mFirstNameTextField.text;
    NSString *lastName = _mLastNameTextField.text;
    NSString *creditCardNumber = _mCreditCardNumberTextField.text;
    NSString *cvv = _mCVVTextField.text;
    NSString *street = _mStreetTextField.text;
    NSString *city = _mCityTextField.text;
    NSString *zipcode = _mZipcodeTextField.text;
    
    if([self isNetworkAvailable]){
        //Payment is processed here
    }
}

@end
