//
//  ViewController.m
//  aaa
//
//

#import "ViewController.h"
#import "RedImageViewController.h"

@interface ViewController () <UIViewControllerPreviewingDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.imageView];
    }
    else {
        NSLog(@"ForceTouch not available. use LongPress...");
    }
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSLog(@"peek");
    
    previewingContext.sourceRect = CGRectMake(0, 0, previewingContext.sourceView.frame.size.width, previewingContext.sourceView.frame.size.height);
    
    RedImageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RedImageViewController"];
    vc.preferredContentSize = CGSizeMake(0, 300);
    return vc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    NSLog(@"pop");
    
    RedImageViewController *vc = (RedImageViewController *)viewControllerToCommit;
    vc.closeButton.hidden = NO;
    vc.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    
    NSLog(@"touchesBegan : %f / %f", t.force, t.maximumPossibleForce);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    
    NSLog(@"touchesMoved : %f / %f", t.force, t.maximumPossibleForce);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    
    NSLog(@"touchesEnded : %f / %f", t.force, t.maximumPossibleForce);
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    
    NSLog(@"touchesCancelled : %f / %f", t.force, t.maximumPossibleForce);
}

@end
