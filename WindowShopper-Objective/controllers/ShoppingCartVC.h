
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface ShoppingCartVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mEmptyView;
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyImage;

@property (weak, nonatomic) IBOutlet UITableView *mCartTable;

@property (weak, nonatomic) IBOutlet UIView *mSummaryView;
@property (weak, nonatomic) IBOutlet UILabel *mSummaryLabel;

@property (weak, nonatomic) IBOutlet UIView *mCheckoutView;
@property (weak, nonatomic) IBOutlet UIButton *mCheckoutButton;

@property (weak, nonatomic) IBOutlet UILabel *mTotalItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTotalAmountLabel;

@property (nonatomic) int mTotalItems;
@property (nonatomic) double mTotalAmount;

@property (nonatomic) NSMutableArray *mCheckoutList;

@property (nonatomic) FIRDatabaseReference *mRef;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)getUsersCart;
-(void)quantityStepper:(UIStepper *)sender;

@end
