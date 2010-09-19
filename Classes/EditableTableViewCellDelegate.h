#import <UIKit/UIKit.h>

@class EditableTableViewCell;

@protocol EditableTableViewCellDelegate

- (void)editableTableViewCellDidBeginEditing:(EditableTableViewCell *)editableTableViewCell;
- (void)editableTableViewCellDidEndEditing:(EditableTableViewCell *)editableTableViewCell;
- (void)editableTableViewCell:(EditableTableViewCell *)editableTableViewCell heightChangedTo:(CGFloat)newHeight;

@end
