//
//  ViewController.m
//  CocoaReactive
//
//  Created by Bonan Zhang on 14/10/26.
//  Copyright (c) 2014年 Bonan Zhang. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *aName) {
        return @([self isValidUsername:aName]);
    }];
    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *aPass) {
        return @([self isValidPassword:aPass]);
    }];
    RAC(self.usernameTextField, backgroundColor) = [validUsernameSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    RAC(self.passwordTextField, backgroundColor) = [validPasswordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
}



- (BOOL)isValidUsername:(NSString *)aName {
    
    return true;
}

- (BOOL)isValidPassword:(NSString *)aPass {
    
    return [@[@"pass"] containsObject:aPass];
}


@end
