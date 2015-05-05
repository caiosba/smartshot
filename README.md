# Smartshot

[![Build Status](https://travis-ci.org/caiosba/smartshot.png)](https://travis-ci.org/caiosba/smartshot) 
[![Gem Version](https://badge.fury.io/rb/smartshot.png)](http://badge.fury.io/rb/smartshot)

Captures a web page as a screenshot using Poltergeist, Capybara and PhantomJS.
It can wait for elements and also dive into iframes, while the existing gems
just wait for time or expect elements on the main window.

## Installation

Download and install [PhantomJS](http://phantomjs.org/),
add the directory containing the binary to your PATH.

Add the `smartshot` gem to your Gemfile:

    gem "smartshot"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smartshot

## Usage

```rb
# Instantiate - additional "options" can be passed to Capybara
fetcher = Smartshot::Screenshot.new(window_size: [800, 600])

# Simpler usage - you can now grab a screenshot of a page
fetcher.take_screenshot! url: 'http://www.google.com', output: '/tmp/google.png'

# More complex example
# Let's take the screenshot only when some element (here a "div"
# with class "embed") is present on an iframe which is inside two
# other iframes - the iframes path to be followed by the bot
# is defined by an array, where iframes can be defined by
# index (0-based), name or id
fetcher.take_screenshot! url: 'http://some.page.with/deep/iframes',
                         output: '/tmp/screenshot.png',
                         wait_for_element: 'div.embed',
                         frames_path: [0, 'name-of-an-iframe-inside-the-first-iframe', 'id-of-an-iframe-inside-the-previous-one']

# It's also possible to just wait for some time (for example, 5 seconds)
fetcher.take_screenshot! url: 'http://google.com', output: '/tmp/google.png', sleep: 5
```

Besides the five custom options presented so far, it's possible to pass the same options accepted by
[Poltergeist's save screenshot method](https://github.com/teampoltergeist/poltergeist#taking-screenshots-with-some-extensions),
for example:

```rb
fetcher.take_screenshot! url: 'http://google.com', output: '/tmp/google.png', full: false, selector: '#myDiv .my-class p'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
