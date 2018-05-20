
#import "CartCell.h"

@implementation CartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _mItemTitleLabel.font = [UIFont boldSystemFontOfSize: 18];
    _mItemTitleLabel.frame = CGRectMake(15, 0, 110, 22);
    
    _mQuantityLabel.font = [UIFont systemFontOfSize: 17];
    _mQuantityLabel.frame = CGRectMake(51, 25, 70, 21);
    
    _mQuantityStepper.frame = CGRectMake(193, 23, 94, 29);
//    _mQuantityStepper.tintColor =[UIColor];
    
}

@end
