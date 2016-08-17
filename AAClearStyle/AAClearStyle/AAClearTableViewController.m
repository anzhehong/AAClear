//
//  AAClearTableViewController.m
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import "AAClearTableViewController.h"



@interface AAClearTableViewController () {
    NSMutableArray* _toDoItems;
    
    AAClearPullToAdd* _pullAddNewBehaviour;
    
    // the offset applied to cells when entering 'edit mode'
    float _editingOffset;
}

@end

@implementation AAClearTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setDefaultItems];
    
    
    
    //Set the estimated height for tableview cell
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 44.0;
    
    self.myTableView.backgroundColor = [UIColor blackColor];
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
//    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.myDataSource = self;
    _pullAddNewBehaviour = [[AAClearPullToAdd alloc] initWithTableView:self.myTableView];
    
    //Cannot use it if you want to load the cell from the interface builder.
//    [self.tableView registerClass:[AAClearCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDefaultItems {
    // create a dummy to-do list
    _toDoItems = [[NSMutableArray alloc] init];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Feed the cat"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Buy eggs"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Pack bags for WWDC"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Rule the web"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Buy a new iPhone"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Find missing socks"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Write a new tutorial"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Master Objective-C"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Remember your wedding anniversary!Remember your wedding anniversary!Remember your wedding anniversary!"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Drink less beer"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Learn to draw"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Take the car to the garage"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Sell things on eBay"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Learn to juggle"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Give up"]];
}

- (UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _toDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed:1.0 green:val blue:0.1 alpha:1.0];
}

#pragma mark - AAClearCellDelegate
- (void)toDoItemDeleted:(id)toDoItem {
//    NSUInteger index = [_toDoItems indexOfObject:toDoItem];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [_toDoItems removeObject:toDoItem];
//    
//    [self.tableView beginUpdates];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
//                          withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.tableView endUpdates];
    
    float delay = 0.0;
    NSTimeInterval interval = 0.3;
    [_toDoItems removeObject:toDoItem];
    
    NSArray* visibleCells = [self.myTableView visibleCells];
    
    UIView* lastView = [visibleCells lastObject];
    
    bool startAnimating = false;
    
    for (AAClearCell* cell in visibleCells) {
        if (startAnimating) {
            [UIView animateWithDuration:interval
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
                             } completion:^(BOOL finished) {
                                 if (cell == lastView) {
                                     [self.myTableView reloadData];
                                 }
                             }];
            delay += 0.03;
        }
        
        //if you have reached the item that was deleted, start animating
        if (cell.todoItem == toDoItem) {
            startAnimating = true;
            cell.hidden = YES;
        }
    }
}

- (void) cellDidBeginEditing:(AAClearCell*) editingCell {
    _editingOffset = _myTableView.contentOffset.y - editingCell.frame.origin.y;
    for (AAClearCell* cell in [_myTableView visibleCells]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.transform = CGAffineTransformMakeTranslation(0, _editingOffset);
                             if (cell != editingCell) {
                                 cell.alpha = 0.3;
                             }
                         }];
    }
}

- (void) cellDidEndEditing:(AAClearCell*) editCell {
    for (AAClearCell* cell in [_myTableView visibleCells]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.transform = CGAffineTransformIdentity;
                             if (cell != editCell) {
                                 cell.alpha = 1.0;
                             }
                         }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%lu", (unsigned long)_toDoItems.count);
    return _toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AAClearCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSInteger index = indexPath.row;
    AATodoItem *item = _toDoItems[index];
    cell.delegate = self;
    cell.todoItem = item;
    cell.backgroundColor = [self colorForIndex:indexPath.row];
    return cell;
}

#pragma mark - AAClearTable View Data Source
- (void)itemAdded {
    [self itemAddedAtIndex:0];
    NSLog(@"Item added");
}

- (void)itemAddedAtIndex:(NSInteger)index {
    // create the new item
    AATodoItem* toDoItem = [[AATodoItem alloc]init];
    [_toDoItems insertObject:toDoItem atIndex:index];
    
    // refresh the table
    [_myTableView reloadData];
    
    // enter edit mode
    AAClearCell* editCell;
    for (AAClearCell* cell in _myTableView.visibleCells) {
        if (cell.todoItem == toDoItem) {
            editCell = cell;
            break;
        }
    }
    [editCell.textLabel becomeFirstResponder];
}

@end