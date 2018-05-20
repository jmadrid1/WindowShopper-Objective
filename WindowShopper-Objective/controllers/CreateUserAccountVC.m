
#import "CreateUserAccountVC.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Reachability.h"

@interface CreateUserAccountVC ()

@end

@implementation CreateUserAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];
    
    _mFirstNameLabel.text = @"First Name:";
    _mLastNameLabel.text = @"Last Name:";
    _mEmailLabel.text = @"Email:";
    _mPasswordLabel.text = @"Password:";
    _mConfirmPasswordLabel.text = @"Confirm Password:";
    
    _mFirstNameLabel.font = [UIFont systemFontOfSize: 17];
    _mLastNameLabel.font = [UIFont systemFontOfSize: 17];
    _mEmailLabel.font = [UIFont systemFontOfSize: 17];
    _mPasswordLabel.font = [UIFont systemFontOfSize: 17];
    _mConfirmPasswordLabel.font = [UIFont systemFontOfSize: 17];
    
    _mFirstNameTextField.tag = 0;
    _mLastNameTextField.tag = 1;
    _mEmailTextField.tag = 2;
    _mPasswordTextField.tag = 3;
    _mConfirmPasswordTextField.tag = 4;
    
    _mFirstNameTextField.placeholder = @"Enter First Name";
    _mLastNameTextField.placeholder = @"Enter Last Name";
    _mEmailTextField.placeholder = @"Enter Email";
    _mPasswordTextField.placeholder = @"Enter Password";
    _mConfirmPasswordTextField.placeholder = @"Confirm Password";
    
    _mFirstNameLabel.frame = CGRectMake(103, 192, 92, 21);
    _mLastNameLabel.frame = CGRectMake(103, 244, 91, 21);
    _mEmailLabel.frame = CGRectMake(141, 294, 46, 21);
    _mPasswordLabel.frame = CGRectMake(108, 334, 79, 21);
    _mConfirmPasswordLabel.frame = CGRectMake(43, 387, 144, 21);
    _mFirstNameTextField.frame = CGRectMake(195, 177, 152, 30);
    _mLastNameTextField.frame = CGRectMake(195, 229, 152, 30);
    _mEmailTextField.frame = CGRectMake(195, 278, 152, 30);
    _mPasswordTextField.frame = CGRectMake(195, 329, 152, 30);
    _mConfirmPasswordTextField.frame = CGRectMake(195, 381, 152, 30);
        
    _mFirstNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mLastNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [_mEmailTextField setKeyboardType: UIKeyboardTypeEmailAddress];
    [_mPasswordTextField setSecureTextEntry: YES];
    [_mConfirmPasswordTextField setSecureTextEntry: YES];
    
    _mFirstNameTextField.returnKeyType = UIReturnKeyDone;
    _mLastNameTextField.returnKeyType = UIReturnKeyDone;
    _mEmailTextField.returnKeyType = UIReturnKeyDone;
    _mPasswordTextField.returnKeyType = UIReturnKeyDone;
    _mConfirmPasswordTextField.returnKeyType = UIReturnKeyDone;
    
    _mMismatchedPasswordsLabel.text = @"*Passwords do not match";
    _mMismatchedPasswordsLabel.frame = CGRectMake(103, 468, 196, 21);
    _mMismatchedPasswordsLabel.textColor = [UIColor redColor];
    [_mMismatchedPasswordsLabel setHidden: true];
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
    
    switch (textField.tag) {
            
        case 0:
            return newLength <= 30;
            
        case 1:
            return newLength <= 30;
            
        case 2:
            return newLength <= 35;
            
        case 3:
            return newLength <= 25;
            
        case 4:
            return newLength <= 25;

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
            [_mEmailTextField resignFirstResponder];
            return TRUE;
            
        case 3:
            [_mPasswordTextField resignFirstResponder];
            return TRUE;
            
        case 4:
            [_mConfirmPasswordTextField resignFirstResponder];
            return TRUE;
            
        default:
            return true;
    }
}

-(IBAction)createAccount{
    
    NSString *firstName = _mFirstNameTextField.text;
    NSString *lastName = _mLastNameTextField.text;
    NSString *email = _mEmailTextField.text.lowercaseString;
    NSString *password = _mPasswordTextField.text;
    NSString *confirmPassword = _mConfirmPasswordTextField.text;
    
    if([self isNetworkAvailable]){
        
        if(password == confirmPassword){
            
            [[FIRAuth auth] createUserWithEmail: email  password: password  completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                
                if(error){
                    NSLog(@"%@", error);
                }else{
                    
                    [[FIRAuth auth] signInWithEmail: email password: password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                        
                        if(error){
                            NSLog(@"%@", error);
                        }
                        
                        NSString *userId = user.uid;
                        
                        NSDictionary *values = @{@"firstname": firstName,
                                                 @"lastname": lastName,
                                                 @"email": email,
                                                 @"password": password};
                        
                        [[[_mRef child: @"users"] child: userId] setValue: values];
                        
                        [self.tabBarController setSelectedIndex: 0];
                    }];
                }
            }];
        }else{
            [_mMismatchedPasswordsLabel setHidden: false];
        }
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

@end
