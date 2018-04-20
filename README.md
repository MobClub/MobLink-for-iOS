# MobLink For iOS
### [MobLink](http://moblink.mob.com/),为您提供移动端场景还原解决方案。10分钟快速集成即可打破App孤岛，实现Web与App的无缝链接，让App间无缝跳转，加强用户体验，提升App活跃度。

**当前版本**

- iOS v2.2.0

**集成文档**

- [iOS](http://wiki.mob.com/moblink-ios-doc/)

--------

## 一、到Mob官网申请MobLink所需的APPKey
1. 打开[Mob官网](http://mob.com/)，在官网首页选择登录或注册，新用户先注册，老用户直接登录。

    ![mob_home](http://onmw6wg88.bkt.clouddn.com/mob.png)

	注册页面如下图：
	
	![mob_reg](http://onmw6wg88.bkt.clouddn.com/mob_reg.png)

2. 注册或登录完成后，会返回至首页，点击右上角的 **“进入后台”** ，会跳转至管理后台，点击 **“下拉列表”** ，选择 **“创建新应用”** 。如下图：

	![Snip20170612_9](http://onmw6wg88.bkt.clouddn.com/Snip20170612_9.png)
	
	输入应用名称后点击 **“保存”** ，如下图：
	
	![mob_create_app](http://onmw6wg88.bkt.clouddn.com/Snip20170525_11.png)
	
	应用创建后在左边导航栏点击 **“添加产品”** ，如下图：
	
	![mob_add_product](http://onmw6wg88.bkt.clouddn.com/Snip20170525_12.png)
	
	在产品列表中选择MobLink并点击 **“马上开始”** ，如下图：
	
	![mob_start](http://onmw6wg88.bkt.clouddn.com/Snip20170525_14.png)
	
	此时左边导航栏就能看到您添加的产品了，点击 **“概况”** 即可看到您接下来需要的AppKey和AppSecret了，如下图：
	
	![mob_appkey](http://onmw6wg88.bkt.clouddn.com/Snip20170525_16.png)

3. 后台基础配置。请务必根据自身客户端应用实际情况，进行相关项的配置。填写完毕后请点击 **“保存”** 以确保生效。

	![mob_conf](http://onmw6wg88.bkt.clouddn.com/Snip20170525_17.png)
	
	下面仅对iOS各项基础配置进行说明，安卓部分请参考：[安卓集成文档](http://wiki.mob.com/apply-appkey-android/)
	
	<table>
    	<tr>
        	<th colspan="3" align="center">配置说明</th>
    	</tr>
    	<tr>
        	<td align="center">字段名称</td>
        	<td align="center">是否必填</td>
        	<td align="center">字段作用/说明</td>
    	</tr>
    	<tr>
        	<td>BundleID</td>
        	<td>是</td>
        	<td>项目唯一标识。请务必与项目中保持一致。可见于项目Info.plist文件的Bundle identifier</td>
    	</tr>
    	<tr>
        	<td>下载地址</td>
        	<td>是</td>
        	<td>应用在App Store的下载地址</td>
    	</tr>
    	<tr>
        	<td>URL Scheme</td>
        	<td>是</td>
        	<td>请务必与项目中的配置保持一致，否则可能会导致无法跳转应用（下文将介绍）</td>
    	</tr>
    	<tr>
        	<td>Team ID</td>
        	<td>是</td>
        	<td>开发团队的ID，可在苹果开发者后台查看</td>
    	</tr>
    	<tr>
        	<td>右上角跳转链接</td>
        	<td>否</td>
        	<td>通过Universal Link跳转到app后右上角会出现一个 “mob.com” 标志，点击后会通过Safari打开一个链接，可以在这里填写您想要打开的链接，如果不填，则默认打开之前的Web页面</td>
    	</tr>
    	<tr>
        	<td>Universal Link开关</td>
        	<td>是</td>
        	<td>强烈建议使用Mob生成的Universal Link。iOS 9.0及以上使用Universal Link能优化场景恢复过程，提供更好的用户体验。选择并使用我们帮您生成的Universal Link并正确配置到您的项目中(下文将介绍)，将为您节省大量工作和时间。</td>
    	</tr>
	</table>

## 二、下载客户端SDK

### 1.使用CocoaPods自动集成MobLink

MobLink支持使用CocoaPods集成，请在您app的 `Podfile` 中添加 `pod 'mob_linksdk'` 后执行 `pod update`。

**注意：** 最初MobLink的Pod就叫 `MobLink`，但为了统一维护，现MobLink的Pod已更名为`mob_linksdk`，之前的pod也可以使用，但只更新到MobLink的2.0.5版本，后续版本将不再更新之前的pod，请各位开发者即使更新到新的pod `mob_linksdk` 上来。

### 2.手动集成MobLink

请从官网[下载客户端SDK](http://mob.com/)，解压后可得到如下文件夹目录：

![Snip20170525_2](http://onmw6wg88.bkt.clouddn.com/Snip20170525_2.png)


> **说明：**

> * Sample文件夹里存放MobLinkDemo - MobLink的演示demo（供使用参考）

> * SDK文件夹下的MobLink文件夹里存放MobLink.framework - 核心功能库（必要）

> * SDK文件夹下的Required文件夹里存放MOBFoundation.framework - 基础功能框架（必要）

## 三、快速集成SDK

### 一、iOS 快速集成

1. 在项目中添加SDK（使用CocoaPods集成的请忽略该步骤）

	i. 将MobLink.framework，MOBFoundation.framework添加到项目中，如下图：
	
	![Snip20170525_3](http://onmw6wg88.bkt.clouddn.com/Snip20170525_3.png)

	
	ii. 选择将文件夹复制到项目中，如下图：
	
	![Snip20170525_4](http://onmw6wg88.bkt.clouddn.com/Snip20170525_4.png)
	
	iii. 添加依赖库
	
	![Snip20170525_7](http://onmw6wg88.bkt.clouddn.com/Snip20170525_7.png)
	
	>选择项目Target - Build Phases - Link Binary With Libraries，然后选择“+”进行添加系统库：
	
	> * libsqlite3
	> * libz1.2.5
	> * libstdc++6.0.9


2. 配置URL Scheme及Universal Link

	i. URL Scheme
	项目中需要配置URL Scheme以用于场景恢复时跳转到应用中。请参考下图配置您自己的URL Scheme：
	
	![mob_url](http://onmw6wg88.bkt.clouddn.com/mob_url.png)
	
	这里所配置的务必与后台填写的一致，如下图：
	
	![Snip20170525_8](http://onmw6wg88.bkt.clouddn.com/Snip20170525_8.png)
	
	ii. Universal Link
	后台已经为您生成好您的Universal Link，如下图：
	
	![Snip20170525_9](http://onmw6wg88.bkt.clouddn.com/Snip20170525_9.png)
	
	然后在项目中配置Universal Link， ***<font color=red>请务必填写与后台生成的Universal Link地址</font>*** 参考下图：
	
	![Snip20170526_11](http://onmw6wg88.bkt.clouddn.com/Snip20170526_11.png)
	
3. 添加代码

	i. 在Info.plist文件中右键空白处，选择 **“Add Row”** ，添加“MOBAppKey”和“MOBAppSecret”对应值为上述在管理后台中获得的AppKey和AppSecret（点击 **“显示”** 查看），如下图所示：
	
	![Snip20170526_12](http://onmw6wg88.bkt.clouddn.com/Snip20170526_12.png)
	
	无需代码即可完成MobLink的初始化工作。
	
	ii. 在需要恢复的控制器中实现`UIViewController+MLSDKRestore`的两个方法，如下图所示：
	
	![mob_restore_oc](http://onmw6wg88.bkt.clouddn.com/mob_restore_oc.png)
	
	第一个是实现标识控制器路径的方法：

	```
	// 控制器路径
    + (NSString *)MLSDKPath
	{
		// 该控制器的特殊路径
    	return @"/demo/a";
	}
	```
	第二个是实现带有场景参数的初始化方法，并根据场景参数还原该控制器： 
	
	```
	// 根据场景信息初始化方法
    - (instancetype)initWithMobLinkScene:(MLSDKScene *)scene
	{
    	if (self = [super init])
    	{
        	self.scene = scene;
    	}
    	return self;
	}
	```
	
	**<font color="red">关于实现带有场景参数初始化方法的补充：</font>**
	
	如果您的控制器采用xib的方式来初始化的，那么实现该初始化方法时请参考如下代码：
	
		
	```
	// 根据场景信息初始化方法
    - (instancetype)initWithMobLinkScene:(MLSDKScene *)scene
	{
    	// 使用xib进行初始化
    	if (self = [super initWithNibName:@"xib 名称" bundle:nil])
    	{
        	self.scene = scene;
    	}
    	return self;
	}
	```
	
	iii. 获取MobId
	
	```
	- (void)getMobId
	{
    	// 构造自定义参数（可选）
    	NSMutableDictionary *customParams = [NSMutableDictionary dictionary];
    	customParams[@"key1"] = @"value1";
    	customParams[@"key2"] = @"value2";
    	// 根据路径、来源以及自定义参数构造scene
    	MLSDKScene *scene = [[MLSDKScene alloc] initWithMLSDKPath:@"控制器的特殊路径" source:@"来源信息，如：uuid-123456" params:customParams];
    	// 请求MobId
    	__weak typeof(self) weakSelf = self;
    	[MobLink getMobId:scene result:^(NSString *mobId) {
        	weakSelf.mobid = mobId;
        	NSString *msg = mobId == nil ? @"获取Mobid失败" : @"获取Mobid成功";
        	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        	[alert show];
    	}];
	}
	```
	
	<table>
		<tr>
			<th colspan="2" align="center">参数说明</th>
		</tr>
		<tr>
			<td>path</td>
			<td>本次生成的mobid所对应的控制器唯一路径，即上述第2点中所提及的+ MLSDKPath方法返回的路径。在场景还原时（即客户端还原网页内容）会根据path寻找匹配的控制器进行还原。</td>
		</tr>
		<tr>
			<td>source</td>
			<td>来源标识,可用于在场景还原时辨别来源，例如：传入一个当前控制器名称。</td>
		</tr>
		<tr>
			<td>params</td>
			<td>字段类型,此时传入的字典数据，在场景还原时能够重新得到，例如：传入一些回复控制器时需要的参数。</td>
		</tr>
		<tr>
			<th colspan="2" align="center">回调值说明</th>
		</tr>
		<tr>
			<td>mobid</td>
			<td>生成的mobid可用于拼接到需要进行推广的链接后，例如：http://www.abc.com/?mobid=123456，<strong><font color=red>注意：该网站页面必须集成了JS模块的代码（下文将说明），方可实现网页-应用无缝接合。</font></strong></td>
		</tr>
	</table>
	
	**备注：如果您的页面参数固定，则可以将获取到的这个mobid缓存起来，不用每次都去获取新的mobid以节约时间成本。**
	
	到此，最简单的MobLink就集成好了，打开上述集成好JS模块(Web端集成请看下文)并带有mobid的链接即可跳转到您的APP并自动恢复到您实现了恢复方法的控制器中。 ***<font color="red">请注意：如果您的APP中带有导航控制器（UINavigationController），则恢复时MobLink会采用Push的方式，但是如果您的APP中没有导航控制器，则恢复时MobLink会采用Modal的方式，此时就需要您自行dismiss恢复出来的控制器了。</font>***

### 二、Web 快速集成

1. 在开发者后台找到MobLink的 **页面配置** 栏，在 **浮层配置** 选项卡中，参考下图所示步骤来个性化你的App：

![mob_page](http://onmw6wg88.bkt.clouddn.com/Snip20171024_16.png)

2. 浮层配置完成后切换到 **引用JS文件** 选项卡，直接点击 **复制** 按钮，如下图所示：

![mob_js](http://onmw6wg88.bkt.clouddn.com/Snip20171024_17.png)

3. 随后直接在你的网页源码的适当位置粘贴前面复制的JS代码，再根据你的需求做响应修改。代码及相关注释示例如下：

```
<script type="text/javascript" src="//f.moblink.mob.com/v2_0_1/moblink.js?appkey=请替换你自己的AppKey></script>
/*
 * MobLink 支持数组=>MobLink([...]) 和对象=>MobLink({...}) 两种初始化形式
 * 页面上有多个元素需要跳转时使用数组方式,仅单个元素需要跳转时可以使用对象的方式进行初始化
 * el: 表示网页上Element的id值,该字段为空或者不写则表示MobLink默认浮层上的打开按钮(注意:必须为元素id,以#开头)
 * path: 对应App里的路径
 * params: 网页需要带给客户端的参数
 */
 // 单元素初始化方式
 MobLink({
     el: '',
     path: 'demo/a',
     params: {
         key1: 'value1',
         key2: 'value2',
     }
 })
 // 多元素初始化方式
 MobLink([
     {
         el: '',
         path: 'demo/a',
         params: {
             key1: 'value1',
             key2: 'value2',
         }
     },
     {
         el: '#openAppBtn1',
         path: 'demo/b',
         params: {
             key1: 'value1',
             key2: 'value2',
         }
     },
     {
         el: '#openAppBtn2',
         path: 'demo/c',
         params: {
             key1: 'value1',
             key2: 'value2',
         }
     }
 ]);
```

## 三、高级功能

### 一、iOS 高级功能

1. MobLink在运行的时候会通过delegate将整个运作过程呈现出来，所有的delegate方法都不是必须实现的，但这些delegate能够帮助您实现更多自定义的操作。设定delegate对象的方法如下图：
	
	![Snip20170526_13](http://onmw6wg88.bkt.clouddn.com/Snip20170526_13.png)
	
2. delegate中各个方法的说明如下：
	
	<table>
		<tr>
			<th align="center">方法名称</th>
			<th align="center">作用说明</th>
		</tr>
		<tr>
			<td>- (void)IMLSDKStartCheckScene</td>
			<td>开始检测是否需要场景还原  <a href="#start">查看示例</a></td>
		</tr>
		<tr>
			<td>- (void)IMLSDKEndCheckScene</td>
			<td>结束检测是否需要场景还原 <a href="#end">查看示例</a></td>
		</tr>
		<tr>
			<td>- (void)IMLSDKWillRestoreScene:(MLSDKScene *)scene Restore:(void (^)(BOOL isRestore, RestoreStyle style))restoreHandler</td>
			<td>即将进行场景还原（注意：一旦实现该方法，请务必执行restoreHandler） <a href="#will">查看示例</a></td>
		</tr>
		<tr>
			<td>- (void)IMLSDKCompleteResotre:(MLSDKScene *)scene</td>
			<td>完成场景恢复 <a href="#complete">查看示例</a></td>
		</tr>
		<tr>
			<td>- (void)IMLSDKNotFoundScene:(MLSDKScene *)scene</td>
			<td>无法进行场景恢复(通常原因是在恢复时找不到对应的path,应检查需要恢复的控制器所实现的+ MLSDKPath中返回的路径是否与生成mobid时的传入的path参数一致) <a href="#notfound">查看示例</a></td>
		</tr>
	</table>
	
	#### <a name="start">开始检测是否需要场景还原示例代码</a>

	```
	- (void)IMLSDKStartCheckScene
	{
    	NSLog(@"Start Check Scene");
	}
	```

	#### <a name="end">结束检测是否需要场景还原示例代码</a>

	```
	- (void)IMLSDKEndCheckScene
	{
    	NSLog(@"End Check Scene");
	}
	```

	#### <a name="will">即将进行场景还原示例代码</a>

	```
	- (void) IMLSDKWillRestoreScene:(MLSDKScene *)scene Restore:(void (^)(BOOL, RestoreStyle))restoreHandler
	{
    		NSLog(@"Will Restore Scene - Path:%@",scene.path);
    
    
    		[[MLDTool shareInstance] showAlertWithTitle:nil
                                        	message:@"是否进行场景恢复？"
                                    		cancelTitle:@"否"
                                     		otherTitle:@"是"
                                     		clickBlock:^(MLDButtonType type) {
                                         		type == MLDButtonTypeSure ? restoreHandler(YES, Default) : restoreHandler(NO, Default);
                                     		}];
	}
	```

	#### <a name="complete">场景恢复完成示例代码</a>

	```
	- (void)IMLSDKCompleteRestore:(MLSDKScene *)scene
	{
    	NSLog(@"Complete Restore -Path:%@",scene.path);
	}
	```

	#### <a name="notfound">找不到场景示例代码</a>

	```
	- (void)IMLSDKNotFoundScene:(MLSDKScene *)scene
	{
    	NSLog(@"Not Found Scene - Path :%@",scene.path);

    	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有找到路径"
                                                           message:[NSString stringWithFormat:@"Path:%@",scene.path]
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
    	[alertView show];

	}
	```
	
## 三、其他说明

### 一、Universal Link 介绍

#### 什么是Universal Link？

Universal Link是苹果在WWDC 2015上提出的iOS 9的新特性之一。此特性类似于深层链接，并能够方便地通过打开一个Https链接来直接启动您的客户端应用(手机有安装App)。对比起以往所使用的URL Sheme, 这种新特性在实现web-app的无缝链接时能够提供极佳的用户体验。

这具体是一种怎样的情景呢？举个例子，你的用户在微信里面浏览一个你们公司的网页，而此时用户手机也同时安装有你们公司的App ；而universal link 能够使的用户在打开某个详情页时直接打开你的app 并到达app中相应内容的页面，从而实施用户想要的操作(例如查看某条新闻,例如查看某个商品的明细)

以下分别为URL Scheme方式及Universal Link的方式呈现场景恢复的过程

1、URL Scheme方式：(第一张图是在微信中浏览web,下同)

![scheme](http://onmw6wg88.bkt.clouddn.com/scheme.png)

2、Universal Link方式：

![ul](http://onmw6wg88.bkt.clouddn.com/ul.png)

通过上述对比得知,Universal Link能够直接从微信中打开App,比起以往的URL Scheme的方式能够大大改善用户体验。

实现Univerasl Link需要有若干的准备工作：

1)拥有自己的域名，且此域名网站支持Https

2)能够上传文件都自己的域名(一个名为apple-app-site-association的json格式文件)

3)Xcode7, iOS 9以上，并且在Xcode项目中做好适配

然而，MobLink已经帮您完成了上面所有的工作，免费为您提供Universal Link服务。使用MobLink提供的技术方案，无论您是否iOS9以上，都能够助您实现 Web与App 之间的完美交互。


### 二、Universal Link 相关问题

#### 1、以不同的状态打开Universal Link

Universal Link除了能直接打开App，也能够通过Safari 打开。打开App或者打开Safari是两种不同的状态，并且可以相互切换。详细请看下图(从上往下看)

![ul_open](http://onmw6wg88.bkt.clouddn.com/ul_open.png)

#### 2、使用您自己注册的Universal Link

如果您已经有自己注册的Universal Link或者打算使用自己的Universal Link,此Universal Link地址应该指向有效的内容地址。因为如果指向的内容无效，那么用户在没有安装App或者Safari方式打开此Universal Link时会显示404，引起不好的用户体验。为此，我们更建议您使用我们的**免费**Universal Link服务。




