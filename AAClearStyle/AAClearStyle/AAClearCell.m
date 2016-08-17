//
//  AAClearCell.m
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import "AAClearCell.h"

@implementation AAClearCell
{
    CAGradientLayer* _gradientLayer;
    
    UILabel *_tickLabel;
    UILabel *_crossLabel;
}

const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 50.0f;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (self) {

        [self createTickAndCrossLabel];
        
        [self createStrileAndComplete];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
        _itemCompleteLayer = [CALayer layer];
        _itemCompleteLayer.backgroundColor = [[[UIColor alloc]initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
        _itemCompleteLayer.hidden = YES;
        [self.layer insertSublayer:_itemCompleteLayer atIndex:0];
        
        [self addPanGesture];
        
        _labelText.delegate = self;
    }
}

const float LABEL_LEFT_MARGIN = 15.0f;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _gradientLayer.frame = self.bounds;
    _itemCompleteLayer.frame = self.bounds;
    _labelText.frame = CGRectMake(LABEL_LEFT_MARGIN, 0,
                                    self.bounds.size.width - LABEL_LEFT_MARGIN, self.bounds.size.height);
    _tickLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0,
                                  UI_CUES_WIDTH, self.bounds.size.height);
    _crossLabel.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0,
                                   UI_CUES_WIDTH, self.bounds.size.height);
}

- (void)setTodoItem:(AATodoItem*)toDoItem {
    _todoItem = toDoItem;
    _labelText.text = toDoItem.text;
    _labelText.strikeThrough = toDoItem.completed;
    _itemCompleteLayer.hidden = !toDoItem.completed;
}

- (void)createStrileAndComplete {
    _labelText = [[AAStrikeTextField alloc]initWithFrame:CGRectNull];
    _labelText.textColor = [UIColor whiteColor];
    _labelText.font = [UIFont boldSystemFontOfSize:16];
    _labelText.backgroundColor = [UIColor clearColor];
    [self addSubview:_labelText];
    
    _labelText.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint* top = [NSLayoutConstraint
                               constraintWithItem:_labelText
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                               toItem:self
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0
                               constant:5];
    NSLayoutConstraint* bottom = [NSLayoutConstraint
                                  constraintWithItem:_labelText
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                  toItem:self
                                  attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                  constant:5];
    NSLayoutConstraint* leading = [NSLayoutConstraint
                                   constraintWithItem:_labelText
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationGreaterThanOrEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0
                                   constant:5];
    NSLayoutConstraint* trailing = [NSLayoutConstraint
                                    constraintWithItem:_labelText
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationGreaterThanOrEqual
                                    toItem:self
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0 constant:5];
    [self addConstraints:@[top, bottom, leading, trailing]];
}

- (void) createTickAndCrossLabel {
    _tickLabel = [self createCueLabel];
    _tickLabel.text = @"\u2713";
    _tickLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_tickLabel];
    _crossLabel = [self createCueLabel];
    _crossLabel.text = @"\u2717";
    _crossLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_crossLabel];
}

// utility method for creating the contextual cues
-(UILabel*) createCueLabel {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:32];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)addPanGesture {
    // add a pan recognizer
    UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [self addGestureRecognizer:recognizer];
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    // Check for horizontal gesture
    if (fabs(translation.x) > fabs(translation.y)) {
        return YES;
    }
    return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    // 2
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 3;
        
        _markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width / 3;
        
        float cueAlpha = fabs(self.frame.origin.x) / (self.frame.size.width / 3);
        _tickLabel.alpha = cueAlpha;
        _crossLabel.alpha = cueAlpha;
        
        _tickLabel.textColor = _markCompleteOnDragRelease ? [UIColor greenColor] : [UIColor whiteColor];
        _crossLabel.textColor = _deleteOnDragRelease ? [UIColor redColor] : [UIColor whiteColor];
    }
    
    // 3
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_deleteOnDragRelease) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
        
        if (_deleteOnDragRelease) {
            [self.delegate toDoItemDeleted:self.todoItem];
        }
        
        if (_markCompleteOnDragRelease) {
            //mark the item as complete and update the UI state
            self.todoItem.completed = YES;
            _itemCompleteLayer.hidden = NO;
            _labelText.strikeThrough = YES;
        }
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return !self.todoItem.completed;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.todoItem.text = textField.text;
    [self.delegate cellDidEndEditing:self];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate cellDidBeginEditing:self];
}

#pragma mark - Getter and Setter
- (AAStrikeTextField*)getLabelText {
    return _labelText;
}

@end
