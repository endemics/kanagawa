require 'rake/testtask'

task :default => [:unit]

desc 'run unit tests (default)'
Rake::TestTask.new(:unit) do |t|
  t.libs << "test"
  t.test_files = FileList['test/unit/*.rb']
  t.verbose = true
end

desc 'run integration tests (inc. real tsung tests)'
Rake::TestTask.new(:integration) do |t|
  t.libs << "test"
  t.test_files = FileList['test/integration/*.rb']
  t.verbose = true
end

desc 'run all tests (unit+integration)'
task :alltests => [:unit, :integration]
