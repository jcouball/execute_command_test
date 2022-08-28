require "test_helper"
require 'open3'
require 'fileutils'

class Capture2eTest < Test::Unit::TestCase
  def test_echo_path
    output, status = Open3.capture2e(env, cmd, unsetenv_others: false)
    output.chomp!
    assert(status.exitstatus == 0)
    assert_equal(expected_path, output)
  end

  def test_echo_path_from_script
    create_test_script
    output, status = Open3.capture2e(env, test_script_path, unsetenv_others: false)
    output.chomp!
    assert(status.exitstatus == 0)
    assert_equal(expected_path, output)
  end

  private

  def test_script_path
    File.expand_path('test_script')
  end

  def create_test_script
    File.write(test_script_path, <<-SCRIPT)
      #!/bin/bash
      echo "$PATH"
    SCRIPT
    FileUtils.chmod('+x', test_script_path)
  end

  def additional_path_element
    "testing"
  end

  def expected_path
    [ENV['PATH'], additional_path_element].join(File::PATH_SEPARATOR)
  end

  def env
    ENV.to_h.tap do |env|
      env['PATH'] = expected_path
    end
  end

  def cmd
    windows_platform? ? 'echo %PATH%' : 'echo $PATH'
  end
end
