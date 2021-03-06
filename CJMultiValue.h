//
//  CJMultiValue.h
//
//  Created by Caleb Jaffa on 6/4/09.
//  Copyright (c) 2009 Caleb Jaffa
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@protocol CJMultiValueDelegate;

@interface CJMultiValue : UINavigationController <UITableViewDelegate, UITableViewDataSource> {
  UITableViewController *_tableView;
  NSString *_headerNote;
  NSString *_footerNote;
  NSString *_choice;
  NSArray *_choices;
  BOOL _canCancel;
  id <CJMultiValueDelegate> _del;
}

- (id)initWithTitle:(NSString *)title delegate:(id<CJMultiValueDelegate>)delegate choices:(NSArray *)choices;

@property (nonatomic, retain) UITableViewController *tableView;
@property (nonatomic, assign) id<CJMultiValueDelegate> del;
@property (nonatomic, retain) NSString *headerNote;
@property (nonatomic, retain) NSString *footerNote;
@property (nonatomic, retain) NSString *choice;
@property (nonatomic, retain) NSArray *choices;
@property (nonatomic, assign) BOOL canCancel;

@end

@protocol CJMultiValueDelegate <NSObject>
@optional
- (void)multiValue:(CJMultiValue *)multiValue willDismissWithChoice:(NSString *)choice;

@end