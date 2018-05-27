
#import "ClothesCell.h"

@implementation ClothesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _mTitleLabel.font = [UIFont systemFontOfSize: 13];
    _mPriceLabel.font = [UIFont boldSystemFontOfSize: 11];
    
    _mTitleLabel.textColor = [UIColor whiteColor];
    _mPriceLabel.textColor = [UIColor whiteColor];
    
    _mClothesImage.frame = CGRectMake(1, 0, 241, 280);
    _mTitleView.frame = CGRectMake(1, 260, 241, 27);
    _mPriceLabel.frame = CGRectMake(91, 10, 58, 21);
}

@end
