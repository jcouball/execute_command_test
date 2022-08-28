require "test_helper"
require 'open3'

class Capture2eTest < Test::Unit::TestCase
  def test_set_path
    output, status = Open3.capture2e(env, cmd, unsetenv_others: false)
    output.chomp!
    assert(status.exitstatus == 0)
    assert_equal(expected_path, output)
  end

  private

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
    'echo "$PATH"'
  end
end
