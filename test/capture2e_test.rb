require "test_helper"
require 'open3'

class Capture2eTest < Test::Unit::TestCase
  def test_set_path
    output, status = Open3.capture2e(env, cmd, unsetenv_others: false)
    output.chomp!
    assert(status.exitstatus == 0)
    assert(output.end_with?(additional_path_element))
  end

  private

  def additional_path_element
    "#{File::PATH_SEPARATOR}testing"
  end

  def env
    ENV.to_h.tap do |env|
      env['PATH'] = "#{env['PATH']}#{additional_path_element}"
    end
  end

  def cmd
    'echo "$PATH"'
  end
end
