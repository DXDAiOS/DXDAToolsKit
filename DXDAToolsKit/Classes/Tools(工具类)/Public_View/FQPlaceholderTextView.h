//
//  拥有占位文字功能的TextView

#import <UIKit/UIKit.h>

@interface FQPlaceholderTextView : UITextView<UITextViewDelegate>
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 设置当前placeholder文本中，个别文字的颜色*/
- (void)setSomePlaceholderColor:(UIColor *)color withText:(NSString *)text;

@end
