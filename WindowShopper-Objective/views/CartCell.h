
#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mItemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPriceLabel;

@property (weak, nonatomic) IBOutlet UIStepper *mQuantityStepper;

@end
