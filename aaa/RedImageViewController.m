//
//  RedImageViewController.m
//  aaa
//
//

#import "RedImageViewController.h"

@interface RedImageViewController ()

@end

@implementation RedImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.closeButton.hidden = YES;
}

- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray <id <UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"action1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action1 selected.");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"action2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action1 selected.");
    }];
    UIPreviewAction *action3_1 = [UIPreviewAction actionWithTitle:@"action3-1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action1 selected.");
    }];
    UIPreviewAction *action3_2 = [UIPreviewAction actionWithTitle:@"action3-2" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action1 selected.");
    }];
    UIPreviewActionGroup *action3 = [UIPreviewActionGroup actionGroupWithTitle:@"action3" style:UIPreviewActionStyleDestructive actions:@[action3_1, action3_2]];
    
    return @[action1, action2, action3];
}


@end
