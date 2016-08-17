//
//  AAClearCell.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AATodoItem.h"
#import "AAStrikeLabel.h"

@protocol AAClearCellDelegate <NSObject>

/**
 *  indicates that the given item has been deleted
 */
- (void)toDoItemDeleted:(AATodoItem*)toDoItem;

@end

@interface AAClearCell : UITableViewCell {
    CGPoint _originalCenter;
    BOOL _deleteOnDragRelease;
    bool _markCompleteOnDragRelease;
    
    AAStrikeLabel* _strikeLabel;
    CALayer* _itemCompleteLayer;
    
}

@property (nonatomic) AATodoItem* todoItem;

@property (nonatomic, assign) id<AAClearCellDelegate> delegate;

@end

