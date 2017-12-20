//
//  FriendRecommendViewController.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "FriendRecommendViewController.h"
#import "FriendRecommendLeftTableViewCell.h"
#import "FriendRecommendRightTableViewCell.h"
#import "RecommedCategoryListModel.h"
#import "RecommedUserListModel.h"
#import "MJRefresh.h"
#import "ComNetWorkTool.h"


@interface FriendRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *friendRecommedLeftTableView;
@property (weak, nonatomic) IBOutlet UITableView *friendRecommedRightTableView;

@property(nonatomic,strong)NSArray *leftDataArr;
@property(nonatomic,strong)NSMutableArray *rightDataArr;
@property (nonatomic, strong) NSMutableDictionary *params;//请求参数
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation FriendRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.leftDataArr = [NSArray array];
    self.rightDataArr = [NSMutableArray array];
    [self creatNavItem];
    [self creatSubView];
    [self requestLeftData];
}

#pragma mark -请求
-(void)requestLeftData{
    NSString *urlStr=@"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *paraDic=[[NSMutableDictionary alloc] init];
    paraDic[@"a"] = @"category";
    paraDic[@"c"] = @"subscribe";
    [[ComNetWorkTool shareManager] startRequestMethod:GET urlStr:urlStr parameters:paraDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
        RecommedCategoryListModel *categoryListModel = [RecommedCategoryListModel mj_objectWithKeyValues:responseObject];
        self.leftDataArr = categoryListModel.list;
        [self.friendRecommedLeftTableView reloadData];
        [self.friendRecommedLeftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];// 默认选中首行
        [self.friendRecommedRightTableView.mj_header beginRefreshing]; //让右侧tableView进入下拉刷新状态
    } failureBlock:^(NSError *error) {
        
    }];
}


-(void)requestRightData{
    RecommedCategoryModel *categoryModel = self.leftDataArr[self.friendRecommedLeftTableView.indexPathForSelectedRow.row];
    
    NSString *urlStr=@"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    paramDic[@"a"]=@"list";
    paramDic[@"c"]=@"subscribe";
    paramDic[@"category_id"]=@(categoryModel.id);
    paramDic[@"page"]=@(0);
    self.params=paramDic;
    
    //发送请求给服务器
    [[ComNetWorkTool shareManager] startRequestMethod:GET urlStr:urlStr parameters:paramDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
        RecommedUserListModel *userListModel = [RecommedUserListModel mj_objectWithKeyValues:responseObject];
        [self.rightDataArr setArray:userListModel.list];
        self.currentPage = self.currentPage + 1;
        if (self.params != paramDic)return;
        //刷新右边的tableView
        [self.friendRecommedRightTableView reloadData];
        [self.friendRecommedRightTableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        if (self.params !=paramDic) return ;
        [self.friendRecommedRightTableView.mj_header endRefreshing];
    }];
    if (self.params !=paramDic) return ;
    [self.friendRecommedRightTableView.mj_header endRefreshing];
}


-(void)requestMoreRightData{
    RecommedCategoryModel *categoryModel = self.leftDataArr[self.friendRecommedRightTableView.indexPathForSelectedRow.row];
    
    NSString *urlStr=@"http://api.budejie.com/api/api_open.php";
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    paramDic[@"a"]=@"list";
    paramDic[@"c"]=@"subscribe";
    paramDic[@"category_id"]=@(categoryModel.id);
    paramDic[@"page"] = @(_currentPage);
    self.params=paramDic;
    
    [[ComNetWorkTool shareManager] startRequestMethod:GET urlStr:urlStr parameters:paramDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
       
        RecommedUserListModel *userListModel = [RecommedUserListModel mj_objectWithKeyValues:responseObject];
        [self.rightDataArr addObjectsFromArray:userListModel.list];
        self.currentPage = self.currentPage + 1;
        if (self.params !=paramDic)return;
        [self.friendRecommedRightTableView reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}



#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithTitle:@"推荐关注"];
    [self initNavigationLeftButtonBack];
}

-(void)creatSubView{
    self.friendRecommedLeftTableView.delegate=self;
    self.friendRecommedLeftTableView.dataSource=self;
    self.friendRecommedLeftTableView.showsVerticalScrollIndicator=NO;

    self.friendRecommedRightTableView.dataSource=self;
    self.friendRecommedRightTableView.delegate=self;
    
    self.friendRecommedRightTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRightData)];
    self.friendRecommedRightTableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreRightData)];
//    self.friendRecommedRightTableView.mj_footer.hidden=YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.friendRecommedLeftTableView) {
        return self.leftDataArr.count;
    }else if(tableView==self.friendRecommedRightTableView){
        return self.rightDataArr.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.friendRecommedLeftTableView) {
        static NSString *leftIdentifier=@"leftCell";
        FriendRecommendLeftTableViewCell *leftCell=[tableView dequeueReusableCellWithIdentifier:leftIdentifier];
        if (leftCell==nil) {
            leftCell=[[[NSBundle mainBundle] loadNibNamed:@"FriendRecommendLeftTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        leftCell.categoryModel = [self.leftDataArr objectAtIndex:indexPath.row];
        return leftCell;
    }else{
        static NSString *rightIdentifier=@"rightCell";
        FriendRecommendRightTableViewCell *rightCell=[tableView dequeueReusableCellWithIdentifier:rightIdentifier];
        if (rightCell==nil) {
            rightCell=[[[NSBundle mainBundle] loadNibNamed:@"FriendRecommendRightTableViewCell" owner:self options:nil] objectAtIndex:0];
            rightCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        rightCell.userModel = [self.rightDataArr objectAtIndex:indexPath.row];
        return rightCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.friendRecommedLeftTableView) {//点击左边tableView
        RecommedCategoryModel *categoryModel = self.leftDataArr[indexPath.row];
        if(categoryModel.userArr.count){//已经获取过数据
            self.rightDataArr=categoryModel.userArr;
            [self.friendRecommedRightTableView reloadData];
        }else{//请求数据
            NSString *urlStr=@"http://api.budejie.com/api/api_open.php";
            NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
            paramDic[@"a"]=@"list";
            paramDic[@"c"]=@"subscribe";
            paramDic[@"category_id"]=@(categoryModel.id);
            paramDic[@"page"] = @(0);
            [[ComNetWorkTool shareManager] startRequestMethod:GET urlStr:urlStr parameters:paramDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
                
                RecommedUserListModel *userListModel = [RecommedUserListModel mj_objectWithKeyValues:responseObject];
                [self.rightDataArr setArray:userListModel.list];
                //将这次获取的数据存储到该类别下面的userArr数组中
                [categoryModel.userArr addObjectsFromArray:self.rightDataArr];
                [self.friendRecommedRightTableView reloadData];
            } failureBlock:^(NSError *error) {
                
            }];  
        }
    }else{//点击右边tableView
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
