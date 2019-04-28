
#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mBannerView;
@property (weak, nonatomic) IBOutlet UILabel *mBannerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mMensPanelImage;
@property (weak, nonatomic) IBOutlet UIImageView *mWomensPanelImage;

@property (weak, nonatomic) IBOutlet UIView *mMensContainer;
@property (weak, nonatomic) IBOutlet UIView *mWomensContainer;

@property (weak, nonatomic) IBOutlet UIButton *mMensButton;
@property (weak, nonatomic) IBOutlet UIButton *mWomensButton;

-(IBAction)mensButtonTap;
-(IBAction)womensButtonTap;

@end
