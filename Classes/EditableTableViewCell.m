//
//  IngredientTableViewCell.m
//  Recipe Box
//
//  Created by Jacques Fortier on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EditableTableViewCell.h"
#import "JFTextViewNoInset.h"

static const CGFloat kTextViewWidth = 320 - 22;

#define kFontSize ([UIFont systemFontSize])

static const CGFloat kTextViewInset = 31;
static const CGFloat kTextViewVerticalPadding = 15;
static const CGFloat kTopPadding = 6;
static const CGFloat kBottomPadding = 6;

static UIFont *textViewFont;


@implementation EditableTableViewCell

@synthesize delegate;
@synthesize textView;
@synthesize text;

+ (void)initialize {
    textViewFont = [[UIFont systemFontOfSize:kFontSize] retain];
}


- (UITextView *)createTextView {
    UITextView *newTextView = [[JFTextViewNoInset alloc] initWithFrame:CGRectZero];
    newTextView.font = textViewFont;
    newTextView.backgroundColor = [UIColor whiteColor];
    newTextView.opaque = YES;
    newTextView.scrollEnabled = NO;
    newTextView.showsVerticalScrollIndicator = NO;
    newTextView.showsHorizontalScrollIndicator = NO;
    newTextView.contentInset = UIEdgeInsetsZero;
    newTextView.delegate = self;
    
    return newTextView;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        textView = [self createTextView];
        [self.contentView addSubview:textView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect contentRect = self.contentView.bounds;

    contentRect.origin.y += kTopPadding;
    contentRect.size.height -= kTopPadding + kBottomPadding;

    textView.frame = contentRect;
    textView.contentOffset = CGPointZero;

    if (shadowTextView != nil) {
        NSLog(@"Adjusting in superview");
        shadowTextView.frame = [shadowTextView.superview convertRect:contentRect fromView:self.contentView];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)heightForText:(NSString *)text {
    if (text == nil || text.length == 0) {
        text = @"Xy";
    }
    
    CGSize textSize = [text sizeWithFont:textViewFont constrainedToSize:CGSizeMake(kTextViewWidth, 2000)];
    
    return textSize.height + kBottomPadding + kTopPadding + kTextViewVerticalPadding;
}


- (void)setText:(NSMutableString *)newText {
    if (newText != text) {
        [text release];
        text = [newText retain];
        textView.text = newText;
    }
}


#pragma mark -
#pragma mark UITextView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView {
    if (aTextView == textView) {
        shadowTextView = [self createTextView];
        shadowTextView.backgroundColor = [UIColor orangeColor];
        shadowTextView.text = textView.text;
        
        [textView removeFromSuperview];

        shadowTextView.frame = [self.superview convertRect:textView.frame fromView:self.contentView];
        [self.superview addSubview:shadowTextView];

        [shadowTextView becomeFirstResponder];
        
        return NO;
    }
    else {
        return YES;
    }
}

- (void) textViewDidBeginEditing:(UITextView *)theTextView {
    if ([delegate respondsToSelector:@selector(editableTableViewCellDidBeginEditing:)]) {
        [delegate editableTableViewCellDidBeginEditing:self];
    }
}


- (void)textViewDidEndEditing:(UITextView *)theTextView {
    if (theTextView == shadowTextView) {
        NSLog(@"Shadow text view ended editing");
    }
    else {
        NSLog(@"Other text view ended");
    }
    
    NSLog(@"Saving string %@", theTextView.text);
    
    [text setString:theTextView.text];
    
    NSLog(@"Text is now %@", text);

    if ([delegate respondsToSelector:@selector(editableTableViewCellDidEndEditing:)]) {
        [delegate editableTableViewCellDidEndEditing:self];
    }
    
    textView.frame = [self.superview convertRect:shadowTextView.frame toView:self.contentView];

    [shadowTextView removeFromSuperview];
    [self.contentView addSubview:textView];
    
    [shadowTextView release];
    shadowTextView = nil;
}


- (void)textViewDidChange:(UITextView *)theTextView {
    
    if (fabs([EditableTableViewCell heightForText:theTextView.text] - self.frame.size.height) > 0.001) {
        if ([delegate respondsToSelector:@selector(editableTableViewCellDidChangeSize:)]) {
            [delegate editableTableViewCellDidChangeSize:self];
        }
    }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [textView release], textView = nil;
    [super dealloc];
}


@end
