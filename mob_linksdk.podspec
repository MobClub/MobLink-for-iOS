Pod::Spec.new do |s|
	s.name                = "mob_linksdk"
	s.version             = "2.2.1"
	s.summary             = 'mob.com网页一键唤醒App并到达指定内页SDK,原Pod名称为:MobLink,请知悉～'
	s.license             = 'Copyright © 2012-2017 mob.com'
	s.author              = { "MobProducts" => "mobproducts@163.com" }
	s.homepage            = 'http://www.mob.com'
	s.source              = { :git => "https://github.com/MobClub/MobLink-for-iOS.git", :tag => s.version.to_s }
	s.platform            = :ios, '8.0'
	s.frameworks          = "ImageIO", "JavaScriptCore"
	s.libraries           = "icucore", "z", "stdc++.6.0.9", "sqlite3"
	s.vendored_frameworks = 'SDK/MobLink/MobLink.framework'
	s.dependency 'MOBFoundation'
end
