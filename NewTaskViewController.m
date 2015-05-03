//
//  NewTaskViewController.m
//  LocalTest
//
//  Created by Huahan on 4/30/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NewTaskViewController.h"
#import "JVFloatLabeledTextFieldViewController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "Constant.h"
#import "WCDelegate.h"
#import "MainViewController.h"

@interface NewTaskViewController (){
    UIScrollView *scrollView;
    NSString *pickerSelected;
    JVFloatLabeledTextField *urlField;
    JVFloatLabeledTextField *patternField;
    UILabel *showsUpLabel;
    UILabel *showsMoreLabel;
    UILabel *showsLessLabel;
    UILabel *showsDisappear;
    UIColor *pickerLabelDefaultColor;
}

@end

@implementation NewTaskViewController

-(instancetype)initWithParentScrollView:(UIScrollView *)sc
{
    self = [super init];
    scrollView = sc;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Floating Label Demo", @"");
    }
    return self;
}

- (void)viewDidLoad
{
    //init
    pickerSelected = PICKER_TITLE_SHOWS_UP;
    
    
    CGFloat kJVFieldHeight = 44.0f;
    CGFloat kJVFieldHMargin = 10.0f;
    CGFloat kJVFieldFontSize = 16.0f;
    CGFloat kDoneLabelFontSize = 20.0f;
    CGFloat kJVFieldFloatingLabelFontSize = 11.0f;
    CGFloat kPickerLabelWidth = (345 - kJVFieldHMargin * 3)/ 2;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
#endif
    
    UIColor *floatingLabelColor = [UIColor brownColor];
    
    //url field
    urlField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    urlField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"URL", @"http:www.")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    urlField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    urlField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    urlField.floatingLabelTextColor = floatingLabelColor;
    urlField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:urlField];
    urlField.translatesAutoresizingMaskIntoConstraints = NO;
    urlField.keepBaseline = 1;
    
    //pattern field
    patternField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    patternField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Key Words", @"")
                                                                         attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    patternField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    patternField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    patternField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:patternField];
    patternField.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div3 = [UIView new];
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    div3.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div4 = [UIView new];
    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div4];
    div4.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div5 = [UIView new];
    div5.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div5];
    div5.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div6 = [UIView new];
    div6.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div6];
    div6.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div7 = [UIView new];
    div7.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div7];
    div7.translatesAutoresizingMaskIntoConstraints = NO;

    //nickname field
    JVFloatLabeledTextField *nicknameField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    
    nicknameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Nickname", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    nicknameField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    nicknameField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    nicknameField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:nicknameField];
    nicknameField.translatesAutoresizingMaskIntoConstraints = NO;

    //picker selector
    UITapGestureRecognizer *tapGestureShowUp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regShowUp)];
    UITapGestureRecognizer *tapGestureShowsMore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regShowMore)];
    UITapGestureRecognizer *tapGestureShowsLess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regShowLess)];
    UITapGestureRecognizer *tapGestureDisappear = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regShowDisappear)];
    UITapGestureRecognizer *tapGestureDone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done)];

    showsUpLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    showsUpLabel.text = PICKER_TITLE_SHOWS_UP;
    showsUpLabel.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    showsUpLabel.userInteractionEnabled = YES;
    [showsUpLabel addGestureRecognizer:tapGestureShowUp];
    [self.view addSubview:showsUpLabel];
    showsUpLabel.translatesAutoresizingMaskIntoConstraints = NO;

    showsMoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    showsMoreLabel.text = PICKER_TITLE_SHOWS_MORE;
    showsMoreLabel.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    showsMoreLabel.userInteractionEnabled = YES;
    [showsMoreLabel addGestureRecognizer:tapGestureShowsMore];
    [self.view addSubview:showsMoreLabel];
    showsMoreLabel.translatesAutoresizingMaskIntoConstraints = NO;

    showsLessLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    showsLessLabel.text = PICKER_TITLE_SHOWS_LESS;
    showsLessLabel.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    showsLessLabel.userInteractionEnabled = YES;
    [showsLessLabel addGestureRecognizer:tapGestureShowsLess];
    [self.view addSubview:showsLessLabel];
    showsLessLabel.translatesAutoresizingMaskIntoConstraints = NO;

    showsDisappear = [[UILabel alloc] initWithFrame:CGRectZero];
    showsDisappear.text = PICKER_TITLE_DISAPPEAR;
    showsDisappear.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    showsDisappear.userInteractionEnabled = YES;
    [showsDisappear addGestureRecognizer:tapGestureDisappear];
    [self.view addSubview:showsDisappear];
    showsDisappear.translatesAutoresizingMaskIntoConstraints = NO;
    
    pickerLabelDefaultColor = showsUpLabel.textColor;
    
    // Done button
    UILabel *doneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    doneLabel.text = @"DONE";
    doneLabel.font = [UIFont systemFontOfSize:kDoneLabelFontSize];
    doneLabel.userInteractionEnabled = YES;
    doneLabel.textAlignment = NSTextAlignmentCenter;
    [doneLabel addGestureRecognizer:tapGestureDone];
    [self.view addSubview:doneLabel];
    doneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[urlField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(urlField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[patternField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(patternField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div3)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[nicknameField]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(nicknameField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div2)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[showsUpLabel(==minWidth)]-(xMargin)-[div4(1)]-(xMargin)-[showsMoreLabel]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin), @"minWidth":@(kPickerLabelWidth)} views:NSDictionaryOfVariableBindings(showsUpLabel, div4, showsMoreLabel)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div5]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div5)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[showsLessLabel(==minWidth)]-(xMargin)-[div7(1)]-(xMargin)-[showsDisappear]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(kJVFieldHMargin), @"minWidth":@(kPickerLabelWidth)} views:NSDictionaryOfVariableBindings(showsLessLabel, div7, showsDisappear)]];
                                                                                                                                                                                                                                                                                                                                                            
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div6]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div6)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[doneLabel]-(xMargin)-|" options:0 metrics:@{@"xMargin": @(kJVFieldHMargin)} views:NSDictionaryOfVariableBindings(doneLabel)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[urlField(==minHeight)][div1(1)][patternField(==minHeight)][div3(1)][nicknameField(==minHeight)][div2(1)][showsUpLabel(==minHeight)][div6(1)][showsLessLabel(==minHeight)][div5(1)][doneLabel]|" options:0 metrics:@{@"minHeight": @(kJVFieldHeight)} views:NSDictionaryOfVariableBindings(urlField, div1, patternField, div3, nicknameField, div2, showsUpLabel, div6, showsLessLabel, div5, doneLabel)]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:showsUpLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div4 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:showsUpLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:showsMoreLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:showsLessLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div7 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:showsLessLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:showsDisappear attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)regShowUp{
    NSLog(@"selected on regShowUp");
    pickerSelected = PICKER_TITLE_SHOWS_UP;
    [self _clearupLabelColor];
    showsUpLabel.textColor = [UIColor blueColor];
}

-(void)regShowMore{
    NSLog(@"selected on regShowMore");
    pickerSelected = PICKER_TITLE_SHOWS_MORE;
    [self _clearupLabelColor];
    showsMoreLabel.textColor = [UIColor blueColor];
}

-(void)regShowLess{
    NSLog(@"selected on regShowLess");
    pickerSelected = PICKER_TITLE_SHOWS_LESS;
    [self _clearupLabelColor];
    showsLessLabel.textColor = [UIColor blueColor];
}

-(void)regShowDisappear{
    NSLog(@"selected on regDisappear");
    pickerSelected = PICKER_TITLE_DISAPPEAR;
    [self _clearupLabelColor];
    showsDisappear.textColor = [UIColor blueColor];
}

-(void)_clearupLabelColor{
    showsUpLabel.textColor = pickerLabelDefaultColor;
    showsMoreLabel.textColor = pickerLabelDefaultColor;
    showsLessLabel.textColor = pickerLabelDefaultColor;
    showsDisappear.textColor = pickerLabelDefaultColor;
}

-(void)done{
    [[MainViewController sharedInstance] scrollDownScrollView];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
