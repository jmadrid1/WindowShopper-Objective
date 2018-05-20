
#import <UIKit/UIKit.h>


@interface ClothesCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mClothesImage;

@property (weak, nonatomic) IBOutlet UIView *mTitleView;

@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPriceLabel;

@end
