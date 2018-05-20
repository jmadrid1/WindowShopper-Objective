
#import "AccountDetailsVC.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "Reachability.h"

@interface AccountDetailsVC ()

@end

@implementation AccountDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];
    
    [self.navigationController setNavigationBarHidden: true];
    [self.navigationController setToolbarHidden: true];
    
//    _mBannerView.backgroundColor =
    _mBannerIconImage.image = [UIImage imageNamed: @"ic_account"];
    
    _mBannerIconImage.frame = CGRectMake(88, 134, 238, 236);
    _mFullNameLabel.frame = CGRectMake(137, 377, 147, 21);
    _mEmailLabel.frame = CGRectMake(152, 404, 108, 21);
    _mUpdateAccountButton.frame = CGRectMake(113, 483, 194, 30);
    _mSignOutButton.frame = CGRectMake(171, 519, 72, 30);
    
    [_mUpdateAccountButton setTitle: @"Update Account Information" forState: normal];
    [_mSignOutButton setTitle: @"Sign Out" forState: normal];
    
    [self checkIfUserIsLoggedIn];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden: true animated: false];
    [self.navigationController setToolbarHidden: true animated: false];
    
    [self checkIfUserIsLoggedIn];
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


-(void)checkIfUserIsLoggedIn {
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    if(userId == nil){
        UIViewController *userLoginVC = [self.storyboard instantiateViewControllerWithIdentifier: @"userLoginVC"];

        [self.navigationController pushViewController: userLoginVC animated:true];
    }else{
        [self getUserInformation: userId];
    }
}

-(void)getUserInformation:(NSString *)uid {
    
    if([self isNetworkAvailable]){
        
        [[[_mRef child: @"users"] child: uid] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            NSDictionary *userDict = snapshot.value;
            
            NSString *firstName = userDict[@"firstname"];
            NSString *lastName = userDict[@"lastname"];
            
            NSString *email = userDict[@"email"];
            [_mEmailLabel sizeToFit];
            
            _mFullNameLabel.text = [NSString stringWithFormat: @"% @%", firstName, lastName, nil];
            _mEmailLabel.text = email;
            
        }];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

-(IBAction)segueToUpdateAccountVC{
    UIViewController *updateUserAccountVC = [self.storyboard instantiateViewControllerWithIdentifier: @"updateUserAccountVC"];
    
    [self.navigationController pushViewController: updateUserAccountVC animated:true];
}

-(IBAction)signOut{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: @"uid"];
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut: &signOutError];
    if (!status){
        NSLog(@"Failed to signing out due to: %@", signOutError);
        return;
    }else{
        [self.tabBarController setSelectedIndex: 0];
    }
}

@end
