source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
inhibit_all_warnings!

workspace 'RSS'
project 'RSS.xcodeproj'
platform :ios, '9.0'

target 'RSS' do
    pod 'RxSwift', '3.4.1'
    pod 'RxCocoa', '3.4.1'
    pod 'Swinject', '2.1.0'
    pod 'SwinjectStoryboard', '1.1.1'
    pod 'MBProgressHUD', '~> 1.0.0'
    pod 'DPTableView', :git => 'https://github.com/ximximik/DPTableView.git', :tag => '0.1.2'
    pod 'SWXMLHash', '~> 3.0.0'
    pod 'Alamofire', '~> 4.4.0'
    pod 'RxAlamofire', '~> 3.0.2'
    pod 'Kingfisher', '~> 3.8.0'
    
    target 'RSSTests'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
            config.build_settings['SWIFT_WHOLE_MODULE_OPTIMIZATION'] = '-YES'
        end
    end
    puts("Update debug pod settings to speed up build time")
    Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
        File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
    end
    
    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
        file = File.join(folder, flag_name)
        content = File.read(script)
        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
        File.write(script, content)
    end
end
