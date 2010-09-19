#import <UIKit/UIKit.h>
#import "EditableTableViewCellDelegate.h"

@interface EditableTableViewCell : UITableViewCell<UITextViewDelegate> {
    UITextView *shadowTextView;
}

@property(nonatomic, assign) id<NSObject, EditableTableViewCellDelegate> delegate;
@property(nonatomic, readonly) UITextView *textView;
@property(nonatomic, retain) NSMutableString *text;

+ (CGFloat)heightForText:(NSString *)text;

@end
