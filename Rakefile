require 'rake/testtask'

desc 'Run Unit Tests'
Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test_*.rb']
  t.verbose = true
end

task :default => :test
