
#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mBannerView;
@property (weak, nonatomic) IBOutlet UILabel *mBannerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mMensPanelImage;
@property (weak, nonatomic) IBOutlet UIImageView *mWomensPanelImage;

-(void)segueToMens:(UITapGestureRecognizer*)tap;
-(void)segueToWomens:(UITapGestureRecognizer*)tap;

@end
