
#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>


@interface WomensClothingVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mEmptyView;
@property (weak, nonatomic) IBOutlet UIImageView *mEmptyImage;

@property (weak, nonatomic) IBOutlet UICollectionView *mClothesCollection;

@property (nonatomic) NSMutableArray *mDressesList;
@property (nonatomic) NSMutableArray *mShirtsList;
@property (nonatomic) NSMutableArray *mPantsList;

@property (nonatomic) FIRDatabaseReference *mRef;

-(BOOL)isNetworkAvailable;
-(void)showNoNetworkConnectionAlert;
-(void)hideTable;
-(void)getInventory;
-(void)filterClothes:(NSMutableArray *)clothes;

@end
