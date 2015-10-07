iOS9からの3D Touch実装の簡単メモ

##3D Touch

1. Home Screen Quick Actions
2. Peek and Pop
3. Force Properties

###1. Home Screen Quick Actions

By pressing an app icon on an iPhone 6s or iPhone 6s Plus, the user obtains a set of quick actions

![IMG_0022.PNG](https://qiita-image-store.s3.amazonaws.com/0/25832/6d4c12de-83e6-05a0-85c2-f05f74e843be.png "IMG_0022.PNG")

####- by info.plist

```
<key>UIApplicationShortcutItems</key>
<array>
	<dict>
		<key>UIApplicationShortcutItemIconType</key>
		<string>UIApplicationShortcutIconTypePlay</string>
		<key>UIApplicationShortcutItemTitle</key>
		<string>Play</string>
		<key>UIApplicationShortcutItemType</key>
		<string>static</string>
		<key>UIApplicationShortcutItemUserInfo</key>
		<dict>
			<key>key1</key>
			<string>value1</string>
		</dict>
	</dict>
</array>
```

####- by code

```
UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"dynamic1" localizedTitle:@"title1" localizedSubtitle:@"sub1" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"dynamic2" localizedTitle:@"title2" localizedSubtitle:@"sub2" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePause] userInfo:nil];
UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"dynamic3" localizedTitle:@"title3" localizedSubtitle:@"sub3" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:nil];

[[UIApplication sharedApplication] setShortcutItems: @[ item1, item2, item3 ]];
```

###2. Peek and Pop

Press deeply and the view transitions to show the peek

![IMG_0025.PNG](https://qiita-image-store.s3.amazonaws.com/0/25832/d506a5db-91a2-d6c3-6a53-a14d5b17a6ad.png "IMG_0025.PNG")

If instead of ending the touch, the user swipes the peek upward, the system shows the peek quick actions you’ve associated with the peek.

![IMG_0023.PNG](https://qiita-image-store.s3.amazonaws.com/0/25832/a5a5aa64-46f3-b32c-d84a-b5af5a56ee09.png "IMG_0023.PNG")


Press a bit more deeply and the view transitions to show the pop

![IMG_0024.PNG](https://qiita-image-store.s3.amazonaws.com/0/25832/b0789509-e864-114f-7aa9-99202c988d24.png "IMG_0024.PNG")


####- １. register a view in viewcontroller for 3D Touch

```
if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
    [self registerForPreviewingWithDelegate:self sourceView:self.imageView];
}
```

####- ２. implement `UIViewControllerPreviewingDelegate`

```
@interface ViewController () <UIViewControllerPreviewingDelegate>
```

```
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSLog(@"peek");
    
    previewingContext.sourceRect = self.imageView.frame;
    
    RedImageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RedImageViewController"];
    vc.preferredContentSize = CGSizeMake(0, 300);
    return vc;
}
```

```
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    NSLog(@"pop");
    
    RedImageViewController *vc = (RedImageViewController *)viewControllerToCommit;
    vc.closeButton.hidden = NO;
    vc.view.backgroundColor = [UIColor yellowColor];
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
}
```

####- ３. add preview Action

```
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
```


###3. Force Properties

the UITouch class has two new properties to support custom implementation of 3D Touch in your app: force and maximumPossibleForce

```
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    
    NSLog(@"touchesMoved : %f / %f", t.force, t.maximumPossibleForce);
}
```



参考：
https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/Adopting3DTouchOniPhone/
