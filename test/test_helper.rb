require 'test/unit'

def windows_platform?
  # Check if on Windows via RUBY_PLATFORM (CRuby) and RUBY_DESCRIPTION (JRuby)
  win_platform_regex = /mingw|mswin/
  RUBY_PLATFORM =~ win_platform_regex || RUBY_DESCRIPTION =~ win_platform_regex
end

if windows_platform?
  script_file = File.expand_path('test_script')
  powershell_script_file = "#{script_file}.ps1"
  File.write("#{script_file}.ps1", <<-SCRIPT)
    echo "PowerShell"
  SCRIPT
  File.chmod('+x', script_file)
  cmd_script_file = "#{script_file}.cmd"
  File.write("#{script_file}.cmd", <<-SCRIPT)
    echo "CMD"
  SCRIPT
  output, status = Open3.capture2e(script_file)
  FileUtils.rm(powershell_script_file)
  FileUtils.rm(cmd_script_file)
  assert_equal(0, status.exitstatus)
  output.chomp!
  puts "Windows Shell Type: #{output}"
end
