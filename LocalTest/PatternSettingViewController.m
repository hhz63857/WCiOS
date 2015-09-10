//
//  PatternSettingViewController.m
//  LocalTest
//
//  Created by Huahan on 4/15/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "PatternSettingViewController.h"
#import "MainViewController.h"
#import "WCDelegate.h"
#import "Constant.h"
#import "BackgroundUtil.h"
#define ENTITY_NAME @"WCTask"

@interface PatternSettingViewController ()

@end

extern NSString *backgroundImagePath;

@implementation PatternSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.alpha = 1;
    [self.pickerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.pickerView];
    [self.textField setReturnKeyType:UIReturnKeyDone];
    self.textField.delegate = self;
    
    [self.nicknameField setReturnKeyType:UIReturnKeyDone];
    self.nicknameField.delegate = self;
    self.view.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES :self.view.frame];
}

- (IBAction)jobDone:(id)sender {
//    [self.jobDoneAnimation startCanvasAnimation];
    self.pageViewController.newWCTaskPattern = self.textField.text;
    self.pageViewController.newWCTaskType = [self.pickerView.delegate pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:0] forComponent:0];
    self.pageViewController.newWCTaskNickname = self.nicknameField.text;
    [self.pageViewController saveNewWCTask];
    
    UIWindow *window = [(WCDelegate *)[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = [MainViewController sharedInstance];
    [window makeKeyAndVisible];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.nicknameField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.nicknameField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        [self.view endEditing:YES];
    }
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *titles = @[PICKER_TITLE_SHOWS_UP, PICKER_TITLE_SHOWS_MORE, PICKER_TITLE_SHOWS_LESS, PICKER_TITLE_DISAPPEAR];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:titles[row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = PICKER_NUM_ROWS;
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch (row) {
        case 0:
            title = PICKER_TITLE_SHOWS_UP;
            break;
        case 1:
            title = PICKER_TITLE_SHOWS_MORE;
            break;
        case 2:
            title = PICKER_TITLE_SHOWS_LESS;
            break;
        case 3:
            title = PICKER_TITLE_DISAPPEAR;
            break;
        default:
            break;
    }
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

- (void)dealloc {
    [_pickerView release];
    [_pickerView release];
    [_jobDoneButton release];
    [_jobDoneAnimation release];
    [_textField release];
    [_nicknameField release];
    [super dealloc];
}
@end
