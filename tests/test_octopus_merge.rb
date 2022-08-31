require 'fileutils'
require 'open3'
require 'tmpdir'
require 'test/unit'

class TestOctopusMerge < Test::Unit::TestCase
  def setup
    command('git config --global user.name "Test User"')
    command('git config --global user.email "test@example.com"')
    command('git config --global init.defaultBranch main')
  end

  def test_octopus_merge
    Dir.mktmpdir do |dir|
      FileUtils.cd(dir) do
        command('git init')
        File.write("file1.txt", "main")
        command('git add .')
        command('git commit -m "Add file1 on main"')
        assert_equal(['file1.txt'], Dir["**/*.txt"].sort)

        command('git checkout -b branch1')
        File.write("file2.txt", "branch1")
        File.write("file3.txt", "branch1")
        command('git add .')
        command('git commit -m "Add file2 and file3 on branch1"')
        assert_equal(['file1.txt', 'file2.txt', 'file3.txt'], Dir["**/*.txt"].sort)

        command('git checkout main')

        command('git checkout -b branch2')
        File.write("file4.txt", "branch2")
        File.write("file5.txt", "branch2")
        command('git add .')
        command('git commit -m "Add file4 and file5 on branch2"')
        assert_equal(['file1.txt', 'file4.txt', 'file5.txt'], Dir["**/*.txt"].sort)

        command('git checkout main')
        command('git merge branch1 branch2 -m "Merge branch1 and branch2"')
        assert_equal(['file1.txt', 'file2.txt', 'file3.txt', 'file4.txt', 'file5.txt'], Dir["**/*.txt"].sort)
      end
    end
  end

  private

  def command(cmd)
    puts '-' * 80
    puts "Running: #{cmd}"
    puts '-' * 10
    output, status = Open3.capture2e("#{cmd} 2>&1")
    puts output
    puts '-' * 10
    pp status
    puts '-' * 80
    puts

    exit 1 unless status.success?
  end
end
