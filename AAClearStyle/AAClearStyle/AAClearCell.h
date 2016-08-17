//
//  AAClearCell.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AATodoItem.h"
#import "AAStrikeTextField.h"
#import "AAClearCellDelegate.h"


@interface AAClearCell : UITableViewCell <UITextFieldDelegate> {
    CGPoint _originalCenter;
    BOOL _deleteOnDragRelease;
    bool _markCompleteOnDragRelease;
    
    AAStrikeTextField* _labelText;
    CALayer* _itemCompleteLayer;
    
}

@property (nonatomic) AATodoItem* todoItem;

@property (nonatomic, assign) id<AAClearCellDelegate> delegate;

- (AAStrikeTextField*)getLabelText;

@end

