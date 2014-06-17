# Doberman

Doberman is your favorite watchdog timer. It makes sure your code is still alive, barking out loud if there's silence for too long.

[![Build Status](https://travis-ci.org/mateusdelbianco/doberman.png)](https://travis-ci.org/mateusdelbianco/doberman)
[![Code Climate](https://codeclimate.com/github/mateusdelbianco/doberman.png)](https://codeclimate.com/github/mateusdelbianco/doberman)
[![Coverage Status](https://coveralls.io/repos/mateusdelbianco/doberman/badge.png?branch=master)](https://coveralls.io/r/mateusdelbianco/doberman?branch=master)

## Installation

Add this line to your application's Gemfile:

    gem 'doberman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doberman

## Usage

```ruby
begin
  watchdog = Doberman::WatchDog.new(:timeout => 3)
  watchdog.start
  sleep 2
  watchdog.ping
  sleep 2
  watchdog.ping
  sleep 2
  watchdog.stop
  puts "yay! no barking!"
rescue Doberman::WatchDog::Timeout => e
  puts "woof woof!"
end
# => yay! no barking!
```

```ruby
begin
  watchdog = Doberman::WatchDog.new(:timeout => 3)
  watchdog.start
  watchdog.ping
  sleep 4
  watchdog.stop
  puts "yay! no barking!"
rescue Doberman::WatchDog::Timeout => e
  puts "woof woof!"
end
# => woof woof!
```

## Contributing

1. Fork it ( http://github.com/mateusdelbianco/doberman/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
