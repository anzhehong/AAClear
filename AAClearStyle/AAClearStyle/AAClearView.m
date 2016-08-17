////
////  AAClearView.m
////  AAClearStyle
////
////  Created by An, Fowafolo on 16/8/17.
////  Copyright © 2016年 An, Fowafolo. All rights reserved.
////
//
//#import "AAClearView.h"
//
//@implementation AAClearView {
//    // the scroll view that hosts the cells
//    UIScrollView* _scrollView;
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectNull];
//        [self addSubview: _scrollView];
//        _scrollView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
//    }
//    return self;
//}
//- (void)layoutSubviews {
//    _scrollView.frame = self.frame;
//    [self refreshView];
//}
//
//
//
//- (void)refreshView {
//    // set the scollview height
//    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width,
//                                         [_dataSource numberofRows] * AA_ROW_HEIGHT);
//    
//    // add the cells
//    for (int row = 0; row < [_dataSource numberofRows]; row++) {
//        // obtain a cell
//        UIView* cell = [_dataSource cellForRow:row];
//        
//        // set its location
//        float topEdgeForRow = row * AA_ROW_HEIGHT;
//        CGRect frame = CGRectMake(0, topEdgeForRow,
//                                  _scrollView.frame.size.width, AA_ROW_HEIGHT);
//        cell.frame = frame;
//        [_scrollView addSubview:cell];
//    }
//}
//
//#pragma mark - property setters
//- (void)setDataSource:(id<AAClearViewDataSource>)dataSource {
//    _dataSource = dataSource;
//    [self refreshView];
//}
//
//@end
