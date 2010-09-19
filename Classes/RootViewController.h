//
//  RootViewController.h
//  EditableTableViewCells
//
//  Created by Jacques Fortier on 9/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableTableViewCell.h"

@class DetailViewController;

@interface RootViewController : UITableViewController<EditableTableViewCellDelegate> {
    DetailViewController *detailViewController;
    
    NSArray *textItems;
    
    EditableTableViewCell *editingTableViewCell;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
