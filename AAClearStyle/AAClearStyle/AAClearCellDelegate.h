//
//  AAClearCellDelegate.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/17.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAClearCell;

@protocol AAClearCellDelegate <NSObject>

/**
 *  indicates that the given item has been deleted
 */
- (void)toDoItemDeleted:(AATodoItem*)toDoItem;

// Indicates that the edit process has begun for the given cell
- (void) cellDidBeginEditing:(AAClearCell*) cell;

// Indicates that the edit process has committed for the given cell
- (void) cellDidEndEditing:(AAClearCell*) cell;

@end