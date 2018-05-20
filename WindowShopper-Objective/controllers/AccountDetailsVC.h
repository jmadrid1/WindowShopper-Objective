
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface AccountDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mBannerView;

@property (weak, nonatomic) IBOutlet UIImageView *mBannerIconImage;

@property (weak, nonatomic) IBOutlet UILabel *mFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mEmailLabel;

@property (weak, nonatomic) IBOutlet UIButton *mUpdateAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *mSignOutButton;

@property (strong, nonatomic) FIRDatabaseReference *mRef;


-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)checkIfUserIsLoggedIn;
-(void)getUserInformation:(NSString*)uid;
-(IBAction)segueToUpdateAccountVC;
-(IBAction)signOut;

@end
