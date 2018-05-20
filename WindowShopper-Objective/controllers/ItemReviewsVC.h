
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Clothes.h"

@interface ItemReviewsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mReviewsTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mAddBarItem;

@property (nonatomic) NSMutableArray *mReviewsList;
@property (nonatomic) Clothes *mSelectedItem;

@property (nonatomic) FIRDatabaseReference *mRef;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)hideTable;
-(void)getReviewsForItemByDate:(NSInteger *)id;

@end
