//
//  CJMultiValue.m
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

#import "CJMultiValue.h"

// This will work with 2.x or 3.0, use this to be compatible with 2.x
#define FIRMWARE_2_COMPATIBILITY 0

@implementation CJMultiValue

@synthesize tableView = _tableView, headerNote = _headerNote, footerNote = _footerNote, choices = _choices;
@synthesize choice = _choice, canCancel = _canCancel, del = _del;

- (id)initWithTitle:(NSString *)title delegate:(id<CJMultiValueDelegate>)delegate choices:(NSArray *)choices {
  _tableView = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
  _tableView.tableView.dataSource = self;
  _tableView.tableView.delegate = self;
  self = [super initWithRootViewController:_tableView];
  if (self) {
    _tableView.title = title;
    self.del = delegate;
    self.choices = choices;    
  }
  
  [_tableView release];
  
  return self;
}


- (void) setCanCancel:(BOOL)canCancel {
  NSLog(@"canCancel set %d", canCancel);
  _canCancel = canCancel;
  if (_canCancel) {
    _tableView.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                              target:self 
                                              action:@selector(cancel)];
  }
  else {
    _tableView.navigationItem.rightBarButtonItem = nil;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_choices count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return _headerNote;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return _footerNote;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellID = @"CJMultiValueCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (cell == nil) {
#if FIRMWARE_2_COMPATIBILITY
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellID] autorelease];
#else
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
#endif
  }
  
#if FIRMWARE_2_COMPATIBILITY
  cell.text = NSLocalizedString([_choices objectAtIndex:indexPath.row], @"CJMultiValue Label");
#else
  cell.textLabel.text =  NSLocalizedString([_choices objectAtIndex:indexPath.row], @"CJMultiValue Label");
#endif
  
  return cell;
}


- (void)dismiss {
  if ([_del respondsToSelector:@selector(multiValue:willDismissWithChoice:)]) {
    [_del multiValue:self willDismissWithChoice:_choice];
  }  
  [self.parentViewController dismissModalViewControllerAnimated:YES];  
}


- (void)cancel {
  self.choice = nil;
  [self dismiss];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.choice = [_choices objectAtIndex:indexPath.row];
  [_tableView.tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self dismiss];
}


- (void)dealloc {
  [_headerNote release];
  [_footerNote release];
  [_choice release];
  [_choices release];
  _delegate = nil;
  
  [super dealloc];
}

@end