# Current

## youtube-dl.rb
This is a fork of the gem https://github.com/layer8x/youtube-dl.rb. That gem was stale and outdated so we modified it.

`Changes from legacy gem.`

1. Replaced old binary with a new one from https://github.com/yt-dlp/yt-dlp
    * yt-dlp is a better more maintained and optimized version of youtube-dl. It is about 200x faster when pulling videos and has better options than the original software.
    
2. Modified the gem siginificantly to remove old code and no longer needed dependency gems.

3. Updated the way you call the gem instead of calling the URL and then the options, just simply use the command you would like to run with yt-dlp. Please reference the yt-dlp github for exact documentation.
    * Example code:
    ```Ruby
    YoutubeDL.download cmd: "--get-duration #{url}"
    YoutubeDL.download cmd: "-f 251/250/249 -o - #{url}"
    ```
4. Overhauled existing gem to use native ruby methods and overall more understandable cleaner code. There is still some legacy code laying around sadly didn't have time to completely trim it down. As such I left the rest of the README intact for future reference if needed.

.

.

.

.

.
# Legacy
# youtube-dl.rb

Ruby wrapper for [youtube-dl](http://rg3.github.io/youtube-dl/).

## Gem::InstallError: activesupport requires Ruby version >= 2.2.2.

This gem indirectly depends on ActiveSupport, but ActiveSupport 5 (the latest version) requires Ruby version >= 2.2.2. If you are using a version older than this, add this line to your `Gemfile`:

```
gem 'activesupport', '< 5.0'
```

## Install the gem

**IMPORTANT NOTE:** The [`youtube_dl`](https://github.com/ystomar-work/youtube_dl) gem and the [`ruby-youtube-dl`](https://github.com/bnmrrs/ruby-youtube-dl) gem will [cause a conflict](https://github.com/layer8x/youtube-dl.rb/issues/24) with this gem. Please `gem uninstall` those gems before using this one.

Add this line to your application's Gemfile:

```ruby
gem 'youtube-dl.rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youtube-dl.rb

## Install youtube-dl
This gem ships with the latest (working) version of youtube-dl built-in, so you don't have to install youtube-dl at all! Unless you want to.

Some features of youtube-dl require ffmpeg or avconf to be installed.  Normally these are available for installation from your distribution's repositories.

## Usage

Pretty simple.

```ruby
YoutubeDL.download "https://www.youtube.com/watch?v=gvdf5n-zI14", output: 'some_file.mp4'
```

All options available to youtube-dl can be passed to the options hash

```ruby
options = {
  username: 'someone',
  password: 'password1',
  rate_limit: '50K',
  format: :worst,
  continue: false
}

YoutubeDL.download "https://www.youtube.com/watch?v=gvdf5n-zI14", options
```

Options passed as `options = {option: true}` or `options = {option: false}` are passed to youtube-dl as `--option` or `--no-option`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Pass test suite (`rake test`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

Remember: commit now, commit often.
