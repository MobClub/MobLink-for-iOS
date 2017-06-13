
SDK版本号：v2.0.0

更新内容：
1、统一Mob AppKey，优化管理后台；
2、优化SDK，无需注册；
3、优化线程安全以支持统一AppKey；

注意事项：
    1. 由于Universal Link在运行过程中会识别App的Team ID，在运行本Demo时您证书的Team ID与Demo中MobLink使用的AppKey的配置不吻合，所以您在运行本Demo时，Universal Link会失效，分享出去的链接也无法实现场景恢复；
    2. 如果想要能够正常运行本Demo：
	   i. 请先到MobLink管理后台注册应用，并根据实际情况填写相关信息后，将本Demo中的相关配置修改成与后台一致;
	   ii. 在苹果开发者账号管理后台修改对应的Bundle ID下的Associated Domains权限；
    3. 本Demo分享出去的网页链接仅作为MobLink展示所用。在调试时请使用您自己的网页并集成MobLink的JS模块，结合自己项目的实际情况调试使用。
