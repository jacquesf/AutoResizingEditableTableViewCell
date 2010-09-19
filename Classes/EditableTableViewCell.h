#import <UIKit/UIKit.h>
#import "EditableTableViewCellDelegate.h"

@interface EditableTableViewCell : UITableViewCell<UITextViewDelegate> {
}

@property(nonatomic, assign) id<NSObject, EditableTableViewCellDelegate> delegate;
@property(nonatomic, readonly) UITextView *textView;
@property(nonatomic, retain) NSMutableString *text;

+ (UITextView *)dummyTextView;
+ (CGFloat)heightForText:(NSString *)text;

- (CGFloat)suggestedHeight;

@end
