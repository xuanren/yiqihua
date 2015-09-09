//
//  AECertificationHintView.h
//  ArtExam
//
//  Created by dahai on 14-9-21.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    Share_Type,
    Certification_Type,
}ChoiceType;

@protocol AECertificationHintViewDelegate <NSObject>

- (void)selectType:(ChoiceType)type;

@end

@interface AECertificationHintView : UIView

@property (weak, nonatomic) IBOutlet UIView *hintView;
@property (weak, nonatomic) IBOutlet UITextView *hintTextView;
@property (weak, nonatomic) IBOutlet UIButton *shareCertificationBtn;
@property (nonatomic) ChoiceType type;
@property (weak,nonatomic) id <AECertificationHintViewDelegate>delegate;

- (IBAction)onClickShareCertification:(id)sender;

@end
