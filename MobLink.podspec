Pod::Spec.new do |s|
s.name                = "MobLink"
s.version             = "1.0.0"
s.summary             = 'mob.com网页一键唤醒APP并到达指定页SDK'
s.license             = 'Copyright © 2012-2015 mob.com'
s.author              = { "lishuzhi" => "lishuzhi11212@163.com" }
s.homepage            = 'http://www.mob.com'
s.source              = { :git => "https://github.com/MobClub/MobLink-for-iOS.git", :tag => s.version.to_s }
s.platform            = :ios, '7.0'
s.frameworks          = "ImageIO", "JavaScriptCore"
s.libraries           = "icucore", "z", "stdc++", "sqlite3"
s.vendored_frameworks = 'MobLink/MobLink.framework'
s.dependency 'MOBFoundation'
end
