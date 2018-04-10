//
//  DescriptionTableViewController.m
//  弾き語りスクロール３
//
//  Created by 平岡 建 on 2016/10/20.
//  Copyright © 2016年 平岡 建. All rights reserved.
//

#import "DescriptionTableViewController.h"

@interface DescriptionTableViewController ()

@end

@implementation DescriptionTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden=YES;
    self.navigationController.navigationBarHidden=NO;
    self.title=NSLocalizedString(@"Help", nil);
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *screenName = NSStringFromClass([self class]);
    [TrackingManager sendScreenTracking:screenName];
    //左側に編集ボタンを表示する。
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(torikeshi:)];
        self.navigationItem.leftBarButtonItem=cancel;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=NSLocalizedString(@"The input of the chord and lyrics", nil);
            break;
        case 1:
            cell.textLabel.text=NSLocalizedString(@"Scrolling and Tempo", nil);
            break;
        case 2:
            cell.textLabel.text=NSLocalizedString(@"Transposition and copy paste", nil);
            break;
        case 3:
            cell.textLabel.text=NSLocalizedString(@"Start from the middle of the song", nil);
            break;
        case 4:
            cell.textLabel.text=NSLocalizedString(@"Change the time signature in the midddle of a song", nil);
            break;
        case 5:
            cell.textLabel.text=NSLocalizedString(@"Change of color and font", nil);
            break;
        default:
            break;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//セルが選択されたら
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DescriptionViewController *Description=[[DescriptionViewController alloc]init];
    switch (indexPath.row) {
        case 0:
            Description.title=NSLocalizedString(@"The input of the chord and lyrics", nil);
            break;
        case 1:
            Description.title=NSLocalizedString(@"Scrolling and Tempo", nil);
            break;
        case 2:
            Description.title=NSLocalizedString(@"Transposition and copy paste", nil);
            break;
        case 3:
            Description.title=NSLocalizedString(@"Start from the middle of the song", nil);
            break;
        case 4:
            Description.title=NSLocalizedString(@"Change the time signature in the midddle of a song", nil);
            break;
        case 5:
            Description.title=NSLocalizedString(@"Change of color and font", nil);
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:Description animated:YES];
}

-(void)torikeshi:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}


@end
