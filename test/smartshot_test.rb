require 'test_helper'

class SmartshotTest < MiniTest::Unit::TestCase

  DATA_DIR = File.expand_path(File.dirname(__FILE__) + '/data')

  def setup
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)
    @smartshot = Smartshot::Screenshot.new
  end

  def test_http
    %w(www.yahoo.com).each do |name|
      output = thumb(name)
      File.delete output if File.exists? output
      @smartshot.take_screenshot! url: "http://#{name}/", output: output
      assert File.exists? output
    end
  end

  def test_https
    %w(github.com).each do |name|
      output = thumb(name)
      File.delete output if File.exists? output
      @smartshot.take_screenshot! url: "https://#{name}/", output: output
      assert File.exists? output
    end
  end

  def test_invalid_url
    %w(nxdomain).each do |name|
      assert_raises Smartshot::SmartshotError do
        @smartshot.take_screenshot! url: "http://#{name}/", output: thumb(name)
      end
    end
  end

  def test_iframe
    waited = notwaited = nil
   
    %w(waited).each do |name|
      waited = thumb(name)
      File.delete waited if File.exists? waited
      @smartshot.take_screenshot! url: 'http://ca.ios.ba/files/others/smartshot.html', output: waited, wait_for_element: 'p.Tweet-text',
                                  frames_path: [0, 'child', 0]
      assert File.exists? waited
    end

    %w(notwaited).each do |name|
      notwaited = thumb(name)
      File.delete notwaited if File.exists? notwaited
      @smartshot.take_screenshot! url: 'http://ca.ios.ba/files/others/smartshot.html', output: notwaited
      assert File.exists? notwaited
    end

    assert File.size(waited) > File.size(notwaited)
  end

  def test_timeout
    waited = notwaited = nil
   
    %w(withtime).each do |name|
      waited = thumb(name)
      File.delete waited if File.exists? waited
      @smartshot.take_screenshot! url: 'http://ca.ios.ba/files/others/smartshot.html', output: waited, sleep: 10
      assert File.exists? waited
    end

    %w(notime).each do |name|
      notwaited = thumb(name)
      File.delete notwaited if File.exists? notwaited
      @smartshot.take_screenshot! url: 'http://ca.ios.ba/files/others/smartshot.html', output: notwaited
      assert File.exists? notwaited
    end

    assert File.size(waited) > File.size(notwaited)
  end

  def thumb(name)
    File.join(DATA_DIR, "#{name}.png")
  end
end
