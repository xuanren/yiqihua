//
//  UIPlaceHolderTextView.h
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 5/29/13.
//
//

#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end