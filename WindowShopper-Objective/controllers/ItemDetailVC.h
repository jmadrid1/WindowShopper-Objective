
#import "Clothes.h"
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
//#import <HCSStarRatingView/HCSStarRatingView.h>


@interface ItemDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mItemImage;

@property (weak, nonatomic) IBOutlet UILabel *mItemTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *mPriceView;
@property (weak, nonatomic) IBOutlet UILabel *mPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *mReviewsLabel;

//@property (weak, nonatomic) IBOutlet HCSStarRatingView *mRatingScale;

@property (weak, nonatomic) IBOutlet UITextView *mItemDescriptionTextView;

@property (weak, nonatomic) IBOutlet UILabel *mSizeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mSizeSegment;

@property (weak, nonatomic) IBOutlet UILabel *mQuantityLabel;
@property (weak, nonatomic) IBOutlet UIStepper *mQuantityStepper;

@property (weak, nonatomic) IBOutlet UIView *mButtonView;

@property (weak, nonatomic) IBOutlet UIButton *mCartButton;

@property (nonatomic) Clothes *mSelectedItem;

@property (nonatomic) NSString *mSelectedSize;
@property (nonatomic) NSInteger *mSelectedQuantity;

@property (nonatomic) int mCurrentQuantityXS;
@property (nonatomic) int mCurrentQuantityS;
@property (nonatomic) int mCurrentQuantityM;
@property (nonatomic) int mCurrentQuantityL;
@property (nonatomic) int mCurrentQuantityXL;

@property (nonatomic) FIRDatabaseReference *mRef;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)disableZeroQuantitySegments;
-(IBAction)addToCart;
-(void)getItemReviewsCount;
-(void)updateReviewCount:(NSInteger *) count;
-(void)segueToReviews:(UITapGestureRecognizer*)tap;


@end

