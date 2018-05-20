#import <UIKit/UIKit.h>

@interface TransactionVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *mCreditInformationView;
@property (weak, nonatomic) IBOutlet UILabel *mCreditInformationLabel;

@property (weak, nonatomic) IBOutlet UILabel *mCreditCardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCVVLabel;
@property (weak, nonatomic) IBOutlet UILabel *mFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mStreetLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mZipcodeLabel;

@property (weak, nonatomic) IBOutlet UITextField *mFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCreditCardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCVVTextField;
@property (weak, nonatomic) IBOutlet UITextField *mStreetTextField;
@property (weak, nonatomic) IBOutlet UITextField *mCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *mZipcodeTextField;

@property (weak, nonatomic) IBOutlet UIView *mTransactionView;
@property (weak, nonatomic) IBOutlet UIButton *mTransactionButton;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)makeTransaction;

@end
