#import "weChatViewController.h"
#import "gongZhongHaoViewControllerViewController.h"
@interface weChatViewController ()
@property NSInteger i;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation weChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.i = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    self.array0 = @[@"仓前学生事务服务中心"];
    self.array1 = @[@"杭师大微学工",@"杭州师范大学学生会",@"杭州师范大学团委",@"杭师大国服小助理",@"杭州师范大学",@"杭师大图书馆"];
    self.array2 = @[@"廉洁杭师大"];
    self.array3 = @[@"校园114党员服务中心"];
    self.array4 = @[@"青柠音乐生活馆"];
    self.dic = @{@"0":self.array0,@"1":self.array1,@"2":self.array2,@"3":self.array3,@"4":self.array4};
    self.image1 = [UIImage imageNamed:@"事物.jpg"];
    self.image2 = [UIImage imageNamed:@"微学工.jpg"];
    self.image3 = [UIImage imageNamed:@"学生会.jpg"];
    self.image4 = [UIImage imageNamed:@"团委.jpg"];
    self.image5 = [UIImage imageNamed:@"小助理.jpg"];
    self.image6 = [UIImage imageNamed:@"杭师大.jpg"];
    self.image7 = [UIImage imageNamed:@"图书馆.jpg"];
    self.image8 = [UIImage imageNamed:@"廉洁.jpg"];
    self.image9 = [UIImage imageNamed:@"114.jpg"];
    self.image10 = [UIImage imageNamed:@"青"];
    self.dic1 = @{@"仓前学生事务服务中心":self.image1,@"杭师大微学工":self.image2,@"杭州师范大学学生会":self.image3,@"杭州师范大学团委":self.image4,@"杭师大国服小助理":self.image5,@"杭州师范大学":self.image6,@"杭师大图书馆":self.image7,@"廉洁杭师大":self.image8,@"校园114党员服务中心":self.image9,@"青柠音乐生活馆":self.image10};
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dic count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.array5 = [self.dic objectForKey: [NSString stringWithFormat:@"%d",section]];
    
    return [self.array5 count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *id = @"id";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id];
    self.array5 = [self.dic objectForKey: [NSString stringWithFormat:@"%d",indexPath.section]];
    cell.textLabel.text = self.array5[indexPath.row];
    NSString *a = cell.textLabel.text;
    cell.imageView.image = self.dic1[a];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    gongZhongHaoViewControllerViewController  *vw =  [sb instantiateViewControllerWithIdentifier:@"GongZhongHao"];
    vw.a = indexPath.section;
    vw.b = indexPath.row;
    vw.title = @"公众号";
    [self.navigationController pushViewController:vw animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *string = @[@"C",@"H",@"L",@"X",@"Q"];
    return string[section];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *string = @[@"C",@"H",@"L",@"X",@"Q"];
    return string;
}
@end
