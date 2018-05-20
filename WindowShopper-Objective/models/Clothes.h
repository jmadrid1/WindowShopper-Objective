
#import <Foundation/Foundation.h>

@interface Clothes : NSObject

@property (nonatomic) int id;
@property (nonatomic) NSString *title;
@property (nonatomic) double price;
@property (nonatomic) NSString *specifics;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *summary;
@property (nonatomic) NSString *image;
@property (nonatomic) NSDictionary *sizes;

@end
