Pod::Spec.new do |s|
  s.name             = 'CoreDataPod'
  s.version          = '0.1.2'
  s.summary          = 'Dont Panic' 
 
  s.description      = <<-DESC
CoreDataPod is a great resource for example CoreData projects. 
                       DESC
 
  s.homepage         = 'https://github.com/Cfiddle/CoreDataPod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Charles Fiedler' => 'charlesfiedleriii@gmail.com' }
  s.source           = { :git => 'https://github.com/Cfiddle/CoreDataPod.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.swift_version = '4.1'
  s.source_files = 'CoreDataPod/Classes/*'
  s.resource_bundles = {
      'DataStore' => ['CoreDataPod/*.xcdatamodeld']
  }
 
end