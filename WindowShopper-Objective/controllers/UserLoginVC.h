
#import <UIKit/UIKit.h>

@interface UserLoginVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPasswordLabel;

@property (weak, nonatomic) IBOutlet UITextField *mEmailTextField;

@property (weak, nonatomic) IBOutlet UITextField *mPasswordTextField;

@property (weak, nonatomic) IBOutlet UILabel *mIncorrectCredentialsLabel;

@property (weak, nonatomic) IBOutlet UIButton *mLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *mCreateAccountButton;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)checkIfUserIsLoggedIn;
-(IBAction)signIn;
-(IBAction)createAccount;


@end
