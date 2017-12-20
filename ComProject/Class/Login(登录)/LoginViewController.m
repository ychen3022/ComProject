//
//  LoginViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/11/9.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "UserInfoManager.h"
#import "AESCrypt.h"


@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UITextField *pswTF;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *forgetPswBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    [self creatSubView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

#pragma mark -请求
-(void)requestLogin{
    NSString *urlStr=@"http://tjdszxyy.zwjk.com:8000/api/exec/1.htm";
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    paramDic[@"login_name"]=self.phoneTF.text;
    paramDic[@"password"]= [self.pswTF.text SHA265:32];
    
    [[ComNetWorkTool shareManager] startRequestMethod:POST urlStr:urlStr parameters:paramDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
        NSLog(@"登录成功");
        NSLog(@"%@",responseObject);
        //从response里面找出我们要的内容存入本地
        UserInfoModel *userInfoModel = [[UserInfoModel alloc] init];
        userInfoModel.userPhone = self.phoneTF.text;
        [[UserInfoManager sharedInstance] didLoginInWithUserInfoModel:userInfoModel];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"登录失败");
        NSLog(@"%@",error);
    }];
}

#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithTitle:@"登录"];
    [self initNavigationLeftButtonBack];
}

-(void)creatSubView{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, self.topBarHeight+10, KScreenW, 100)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor = [ComTools getColorWithComColor:ComColorLightGray].CGColor;
    bgView.layer.borderWidth = 0.5;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KScreenW, 1.0)];
    lineView.backgroundColor = [ComTools getColorWithComColor:ComColorLightGray];
    [bgView addSubview:lineView];
    
    UIImageView *phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    phoneImgView.image = [UIImage imageNamed:@"formIcon-phone-focus"];
    [bgView addSubview:phoneImgView];
    self.phoneTF=[[UITextField alloc] initWithFrame:CGRectMake(60, 0, KScreenW-60, 50)];
    self.phoneTF.placeholder=@"请输入手机号";
    self.phoneTF.tintColor = [ComTools getColorWithComColor:ComColorRed];
    self.phoneTF.font = [UIFont systemFontOfSize:15];
    self.phoneTF.backgroundColor=[UIColor clearColor];
    self.phoneTF.delegate = self;
    self.phoneTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneTF.keyboardType = UIReturnKeyDone;
    self.phoneTF.returnKeyType = UIReturnKeyDefault;
    [bgView addSubview:self.phoneTF];

    UIImageView *pswImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 30, 30)];
    pswImgView.image = [UIImage imageNamed:@"formIcon-pwd-focus"];
    [bgView addSubview:pswImgView];
    self.pswTF = [[UITextField alloc] initWithFrame:CGRectMake(60, 50,  KScreenW-60, 50)];
    self.pswTF .font = [UIFont systemFontOfSize:15];
    self.pswTF .backgroundColor=[UIColor clearColor];
    self.pswTF.placeholder=@"请输入密码";
    self.pswTF.tintColor = [ComTools getColorWithComColor:ComColorRed];
    self.pswTF .secureTextEntry = YES;
    self.pswTF .delegate = self;
    self.pswTF .returnKeyType = UIReturnKeyDone;
    [bgView addSubview:self.pswTF];
    
    self.loginBtn = [[UIButton alloc] initWithFrame: CGRectMake(20, bgView.bottom+20, KScreenW-40, 50)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.loginBtn.backgroundColor = [ComTools getColorWithComColor:ComColorRed];
    self.loginBtn.layer.cornerRadius = 5.0;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.forgetPswBtn = [[UIButton alloc] initWithFrame: CGRectMake(20, self.loginBtn.bottom+20, 100, 50)];
    [self.forgetPswBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetPswBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.forgetPswBtn setTitleColor:[ComTools getColorWithComColor:ComColorLightBlack] forState:UIControlStateNormal];
    [self.forgetPswBtn addTarget:self action:@selector(forgetPswBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPswBtn];
    
    self.registerBtn = [[UIButton alloc] initWithFrame: CGRectMake(KScreenW-120, self.loginBtn.bottom+20, 100, 50)];
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.registerBtn setTitleColor:[ComTools getColorWithComColor:ComColorRed] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
}

#pragma mark -事件
-(void)loginBtnAction:(UIButton *)sender{
    if([self checkInfo]){
        [self requestLogin];
    }
}

-(void)forgetPswBtnAction:(UIButton *)sender{
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}

-(void)registerBtnAction:(UIButton *)sender{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(BOOL)checkInfo{
    if([self.phoneTF.text length] != 11||![self.phoneTF.text hasPrefix:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    if (self.pswTF.text==nil||[self.pswTF.text length]<6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的密码长度小于6个字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
