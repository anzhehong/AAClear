//
//  AAClearPullToAdd.m
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/17.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import "AAClearPullToAdd.h"

@implementation AAClearPullToAdd {
    
    // the table which this class extends and adds behaviour to
    AAClearTableView* _tableView;
    
    // indicates the state of this behaviour
    BOOL _pullDownInProgress;
    
    /**
     *   a cell which is rendered as a placeholder to indicate where a new item is added
     */
    AAClearCell* _placeholderCell;
}

- (id)initWithTableView:(AAClearTableView*)tableView {
    self = [super init];
    if (self) {
        _placeholderCell = [[AAClearCell alloc] init];
        _placeholderCell.backgroundColor = [UIColor redColor];
        
        _tableView = tableView;
        tableView.delegate = self;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // this behaviour starts when a user pulls down while at the top of the table
    _pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
    
    if (_pullDownInProgress)
    {
        // add our placeholder
        [_tableView insertSubview:_placeholderCell atIndex:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_pullDownInProgress && _tableView.contentOffset.y <= 0.0f)
    {
        // maintain the location of the placeholder
        _placeholderCell.frame = CGRectMake(0, - _tableView.contentOffset.y - AA_ROW_HEIGHT,
                                            _tableView.frame.size.width, AA_ROW_HEIGHT);
        
        [_placeholderCell getLabelText].text = -_tableView.contentOffset.y > AA_ROW_HEIGHT ?
        @"Release to Add Item" : @"Pull to Add Item";
        
        _placeholderCell.alpha = MIN(1.0f, - _tableView.contentOffset.y / AA_ROW_HEIGHT);
    }
    else
    {
        _pullDownInProgress = false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // check whether the user pulled down far enough
    if (_pullDownInProgress && - _tableView.contentOffset.y > AA_ROW_HEIGHT)
    {
        [_tableView.myDataSource itemAdded];
    }
    
    _pullDownInProgress = false;
    [_placeholderCell removeFromSuperview];
}
@end
