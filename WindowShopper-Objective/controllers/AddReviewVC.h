
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface AddReviewVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mIconImage;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *mRatingScale;

@property (weak, nonatomic) IBOutlet UITextField *mCommentTextField;

@property (weak, nonatomic) IBOutlet UIButton *mSubmitButton;

@property (weak, nonatomic) FIRDatabaseReference *mRef;
@property (nonatomic) int mItemId;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(IBAction)submitReview;

@end
