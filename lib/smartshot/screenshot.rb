module Smartshot
  class Screenshot
    include Capybara::DSL

    def self.setup_capybara(options = {})
      defaults = { js_errors: false, phantomjs_options: ['--ignore-ssl-errors=yes', '--ssl-protocol=any'] }
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, defaults.merge(options))
      end
      Capybara.run_server = options.delete(:run_server) || false
      Capybara.current_driver = :poltergeist
      Capybara.default_wait_time = options.delete(:default_wait_time) || 30
    end

    def initialize(options = {})
      Smartshot::Screenshot.setup_capybara(options)
    end

    def take_screenshot(params = {})
      options = { full: true, output: 'screenshot.png', url: 'http://ca.ios.ba', wait_for_element: 'body', frames_path: [] }.merge(params)
      visit options.delete(:url)
      inside_frames options.delete(:frames_path) do
        [options.delete(:wait_for_element)].flatten.each do |element|
          visible = (element =~ /^(link|meta)/).nil?
          page.find element, visible: visible
        end
      end

      timeout = options.delete(:sleep)
      sleep timeout unless timeout.nil?

      page.driver.save_screenshot(options.delete(:output), options)
    end

    def take_screenshot!(params = {})
      begin
        take_screenshot(params)
      rescue => e
        raise SmartshotError.new("Error: #{e.message.inspect}")
      end
    end

    protected

    def inside_frames(frames = [], &block)
      block.call and return if frames.empty?
      frame = frames.shift
      within_frame frame do
        inside_frames(frames, &block)
      end
    end
  end
end
