task :default => [:quicktest]

desc 'run quick unit tests (default)'
task :quicktest do
  ruby "-rubygems -C test QuickTests.rb"
end

desc 'run slow unit tests (inc. real tsung tests)'
task :slowtest do
  ruby "-rubygems -C test SlowTests.rb"
end

desc 'run all unit tests (mocks + real tsung tests)'
task :test => [:quicktest, :slowtest]
