
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface UpdateAccountVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *mConfirmPasswordLabel;

@property (weak, nonatomic) IBOutlet UITextField *mFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *mConfirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *mEmailTextField;

@property (weak, nonatomic) IBOutlet UILabel *mMismatchedPasswordsLabel;

@property (weak, nonatomic) IBOutlet UIButton *mUpdateButton;

@property (nonatomic) FIRDatabaseReference *mRef;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)updateAccount;

@end
