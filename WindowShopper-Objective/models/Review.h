
#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic) int id;
@property (nonatomic) NSString *uid;
@property (nonatomic) NSString *comment;
@property (nonatomic) int rating;
@property (nonatomic) NSString *date;

@end
