//
//  RootViewController.m
//  EditableTableViewCells
//
//  Created by Jacques Fortier on 9/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "JFTextViewNoInset.h"


@implementation RootViewController

@synthesize detailViewController;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        NSMutableString *tempString = [NSMutableString stringWithFormat:@"Editable item %d", i + 1];
        for (int j = 0; j < i; j++) {
            [tempString appendString:@" meow meow meow"];
        }
        [tempArray addObject:tempString];
    }
    
    [self.view addSubview:[EditableTableViewCell dummyTextView]];
    
    textItems = tempArray;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [textItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    /* If the requested row is currently being edited, return the cached copy we're holding onto */
    if (editingTableViewCell != nil) {
        NSLog(@"Returning cached item");
        NSString *text = [textItems objectAtIndex:indexPath.row];
        if (text == editingTableViewCell.text) {
            return editingTableViewCell;
        }
        
    }
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    EditableTableViewCell *cell = (EditableTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EditableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.delegate = self;
    }
    
    // Configure the cell.
    cell.text = [textItems objectAtIndex:indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [textItems objectAtIndex:indexPath.row];
    
    if (editingTableViewCell.text == text) {
        // Use the cell's version of the text because edits may not have been committed back the array
        return editingTableViewCell.textView.contentSize.height + 11;
    }
    else {
        return [EditableTableViewCell heightForText:text];
    }
    
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


#pragma mark -
#pragma mark EditableTableViewCellDelegate

- (void)editableTableViewCellDidBeginEditing:(EditableTableViewCell *)editableTableViewCell {
    editingTableViewCell = editableTableViewCell;
}


- (void)editableTableViewCellDidEndEditing:(EditableTableViewCell *)editableTableViewCell {
    editingTableViewCell = editableTableViewCell;
}


- (void)editableTableViewCell:(EditableTableViewCell *)editableTableViewCell heightChangedTo:(CGFloat)newHeight {
    // Calling beginUpdates/endUpdates causes the table view to reload cell geometries
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [detailViewController release];
    [super dealloc];
}


@end

