#import <UIKit/UIKit.h>

@class EditableTableViewCell;

@protocol EditableTableViewCellDelegate

- (void)editableTableViewCellDidBeginEditing:(EditableTableViewCell *)editableTableViewCell;
- (void)editableTableViewCellDidEndEditing:(EditableTableViewCell *)editableTableViewCell;
- (void)editableTableViewCellDidChangeSize:(EditableTableViewCell *)editableTableViewCell;

@end
