

/********************************颜色********************************/
/** 系统颜色 */
#define kBlackColor [UIColor blackColor]
#define kBlueColor [UIColor blueColor]
#define kRedColor [UIColor redColor]
#define kWhiteColor [UIColor whiteColor]
#define kGrayColor [UIColor grayColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGreenColor [UIColor greenColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
/** RGB颜色 */
#define kColor_RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define kColor_RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
/** 随机色 */
#define kRandomColor_RGB YPColor_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kRandomColor_RGBA YPColor_RGBA_256(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
/** 自定义颜色 */
#define kAllColor [UIColor colorWithRed:(58)/255.0 green:(88)/255.0 blue:(153)/255.0 alpha:(1.0)]



/*********************************尺寸*****************************/
/** 系统状态栏高度 */
UIKIT_EXTERN CGFloat const kStatusBarHeight;
/** 系统导航栏高度 */
UIKIT_EXTERN CGFloat const kNavigationBarHeight;
/** 系统tabbar高度 */
UIKIT_EXTERN CGFloat const kTabBarHeight;
