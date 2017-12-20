//
//  ForgetPwdViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/11/9.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "UserInfoManager.h"
#import "AESCrypt.h"


@interface ForgetPwdViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneTF;//手机号码
@property(nonatomic,strong)UITextField *codeTF;//验证码
@property(nonatomic,strong)UITextField *pswTF;//密码
@property(nonatomic,strong)UIButton *getCodeBtn;//获取验证码按钮
@property(nonatomic,strong)UIButton *registerBtn;//注册按钮
@property(nonatomic,strong)NSTimer *myTimer;//计时器
@property(nonatomic,assign)NSInteger myCount;//60秒重发

@end

@implementation ForgetPwdViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.myCount = 30;
    [self creatNavItem];
    [self creatSubView];
}

#pragma mark -请求
-(void)requestCode{
    NSString *urlStr=@"http://tjdszxyy.zwjk.com:8000/api/exec/1.htm";
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    paramDic[@"phone"]=self.phoneTF.text;
    
    [[ComNetWorkTool shareManager] startRequestMethod:POST urlStr:urlStr parameters:paramDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
        NSLog(@"获取验证码成功");
        NSLog(@"%@",responseObject);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码发送到手机，请注意查收" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTimerAction) userInfo:nil repeats:YES];
    } failureBlock:^(NSError *error) {
        NSLog(@"获取验证码失败");
        NSLog(@"%@",error);
    }];
}

-(void)requestRegister{
    NSString *urlStr=@"http://tjdszxyy.zwjk.com:8000/api/exec/1.htm";
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    paramDic[@"login_name"]=self.phoneTF.text;
    paramDic[@"codeNumber"]=self.codeTF.text;
    paramDic[@"password"]= [self.pswTF.text SHA265:32];
    
    [[ComNetWorkTool shareManager] startRequestMethod:POST urlStr:urlStr parameters:paramDic loadingIndicatorStyle:comLoadingIndicatorStyleGif successBlock:^(id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failureBlock:^(NSError *error) {
        NSLog(@"失败");
        NSLog(@"%@",error);
    }];
}

#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithTitle:@"忘记密码"];
    [self initNavigationLeftButtonBack];
}

-(void)creatSubView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBarHeight + 10, KScreenW, 150)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor = [ComTools getColorWithComColor:ComColorLightGray].CGColor;
    bgView.layer.borderWidth = 0.5;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    for (int i=1; i<=2; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*i, KScreenW, 0.5)];
        lineView.backgroundColor = [ComTools getColorWithComColor:ComColorLightGray];
        [bgView addSubview:lineView];
    }
    
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
    
    
    UIImageView *codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 30, 30)];
    codeImgView.image = [UIImage imageNamed:@"formIcon-validcode-focus"];
    [bgView addSubview:codeImgView];
    self.codeTF=[[UITextField alloc] initWithFrame:CGRectMake(60, 50, KScreenW-60, 50)];
    self.codeTF.placeholder=@"请输入验证码";
    self.codeTF.tintColor = [ComTools getColorWithComColor:ComColorRed];
    self.codeTF.font = [UIFont systemFontOfSize:15];
    self.codeTF.backgroundColor=[UIColor clearColor];
    self.codeTF.delegate = self;
    self.codeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.codeTF.keyboardType = UIReturnKeyDone;
    self.codeTF.returnKeyType = UIReturnKeyDefault;
    [bgView addSubview:self.codeTF];
    
    
    UIImageView *pswImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 110, 30, 30)];
    pswImgView.image = [UIImage imageNamed:@"formIcon-pwd-focus"];
    [bgView addSubview:pswImgView];
    self.pswTF=[[UITextField alloc] initWithFrame:CGRectMake(60, 100, KScreenW-60, 50)];
    self.pswTF.placeholder=@"请输入密码(6-16个字符)";
    self.pswTF.tintColor = [ComTools getColorWithComColor:ComColorRed];
    self.pswTF.font = [UIFont systemFontOfSize:15];
    self.pswTF.backgroundColor=[UIColor clearColor];
    self.pswTF.delegate = self;
    self.pswTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pswTF.keyboardType = UIReturnKeyDone;
    self.pswTF.returnKeyType = UIReturnKeyDefault;
    [bgView addSubview:self.pswTF];
    
    UIButton *getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW - 100 - 10, 10, 100, 30)];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[ComTools getColorWithComColor:ComColorRed] forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[ComTools getColorWithComColor:ComColorGray] forState:UIControlStateDisabled];
    getCodeBtn.titleLabel.font = [ComTools getFontWithComFont:ComFont5];
    getCodeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [getCodeBtn addTarget:self action:@selector(getCodeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:getCodeBtn];
    self.getCodeBtn = getCodeBtn;
    
    UIButton *registerBtn  = [[UIButton alloc] initWithFrame: CGRectMake(20, bgView.bottom+20, KScreenW-40, 50)];
    [registerBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    registerBtn.backgroundColor = [ComTools getColorWithComColor:ComColorRed];
    registerBtn.layer.cornerRadius = 5.0;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    self.registerBtn = registerBtn;
}


#pragma mark -事件
-(void)getCodeBtnAction{
    if ([self checkInfoForGetCode]) {
        //请求网络
        [self requestCode];
    }
}

-(void)registerBtnAction{
    if ([self checkInfoForRegister]) {
        //请求网络
        [self requestRegister];
    }
}

- (void)myTimerAction{
    self.myCount--;
    if(self.myCount>=0){
        self.getCodeBtn.enabled = NO;
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"重新获取(%lds)",(long)self.myCount] forState:UIControlStateNormal];
    }else{
        [self.myTimer invalidate];
        self.getCodeBtn.enabled = YES;
        self.myCount = 60;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

-(BOOL)checkInfoForGetCode{
    if([self.phoneTF.text length] != 11||![self.phoneTF.text hasPrefix:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}


-(BOOL)checkInfoForRegister{
    if([self.phoneTF.text length] != 11||![self.phoneTF.text hasPrefix:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    if (self.codeTF.text==nil||[self.codeTF.text length]!=6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的验证码长度不符！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

#pragma mark -textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
