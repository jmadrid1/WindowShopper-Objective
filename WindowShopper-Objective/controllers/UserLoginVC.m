
#import "UserLoginVC.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import "Reachability.h"

@interface UserLoginVC ()

@end

@implementation UserLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mEmailLabel.text = @"Email:";
    _mPasswordLabel.text = @"Password:";
    
    _mEmailLabel.frame = CGRectMake(87, 321, 42, 21);
    _mPasswordLabel.frame = CGRectMake(58, 375, 71, 21);
    
    _mEmailLabel.textColor = [UIColor whiteColor];
    _mPasswordLabel.textColor = [UIColor whiteColor];
    
//    _mEmailLabel.text = UIFo
    
    _mEmailTextField.frame = CGRectMake(135, 316, 223, 30);
    _mPasswordTextField.frame = CGRectMake(135, 370, 223, 30);
    
    _mEmailTextField.tag = 0;
    _mPasswordTextField.tag = 1;
    
    [_mEmailTextField setKeyboardType: UIKeyboardTypeEmailAddress];
    [_mPasswordTextField setSecureTextEntry: YES];
    
    _mEmailTextField.returnKeyType = UIReturnKeyDone;
    _mPasswordTextField.returnKeyType = UIReturnKeyDone;
    
    _mIncorrectCredentialsLabel.text = @"*Email and/or password do not match any accounts";
    _mIncorrectCredentialsLabel.frame = CGRectMake(20, 455, 385, 21);
    _mIncorrectCredentialsLabel.textColor = [UIColor redColor];
    [_mIncorrectCredentialsLabel setHidden: true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [self checkIfUserIsLoggedIn];
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
            
        default:
            return newLength <= 25;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case 0:
            [_mEmailTextField resignFirstResponder];
            return TRUE;
            
        case 1:
            [_mPasswordTextField resignFirstResponder];
            return TRUE;

        default:
            return true;
    }
}

-(void)checkIfUserIsLoggedIn {
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    if(userId != nil){
        UIViewController *accountDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier: @"accountDetailsVC"];
        
        [self.navigationController pushViewController: accountDetailsVC animated: false];
    }
}

-(IBAction)signIn {
    
    NSString *email = _mEmailTextField.text.lowercaseString;
    NSString *password = _mPasswordTextField.text;
    
    if([self isNetworkAvailable]){
        
        [[FIRAuth auth] signInWithEmail: email password: password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            
            if(error){
                NSLog(@"Failed to log in user.");
                [_mIncorrectCredentialsLabel setHidden: false];
            }
            
            [_mIncorrectCredentialsLabel setHidden: true];
            
            NSString *userId = user.uid;
            [[NSUserDefaults standardUserDefaults] setObject: userId forKey: @"uid"];
            
            [self.tabBarController setSelectedIndex: 0];
        }];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

-(IBAction)createAccount {
    UIViewController *createAccountVC = [self.storyboard instantiateViewControllerWithIdentifier: @"createAccountVC"];

    [self.navigationController pushViewController: createAccountVC animated:true];
}

@end
