//
//  DBNRegisterController.h
//  Dabanniu_Hair
//
//  Created by admin on 14-5-20.
//
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "DBNViewController.h"
@interface DBNEQRegisterController : DBNViewController<UITextFieldDelegate>{
    
    BOOL _isCancelClause;
}

@property (strong, nonatomic) IBOutlet UITextField *nickNameTF;

@property (nonatomic ,strong) IBOutlet UITextField *phoneTF;

@property (nonatomic ,strong) IBOutlet UITextField *pwdTF;

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,strong)  IBOutlet TPKeyboardAvoidingScrollView *sv;

@property (nonatomic,strong)  IBOutlet UIButton *thumBtn;
@property (nonatomic,strong)  IBOutlet UIButton *selecttThumBtn;

@property (nonatomic) int grade;
@property (weak, nonatomic) IBOutlet UIView *pwNickView;


- (IBAction)registerAction:(id)sender;

@end
