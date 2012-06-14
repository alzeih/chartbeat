# Chartbeat

A Ruby wrapper for the [Chartbeat API](http://api.chartbeat.com/)

## Installation

Add this line to your application's Gemfile:

    gem 'chartbeat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chartbeat

## Usage

```ruby
    c = Chartbeat::API.new
    c = Chartbeat::API.new apikey: 'yourkey', host: 'yourdomain.com'
    c = Chartbeat::API.new apikey: 'yourkey', host: 'yourdomain.com', since: (Time.now - 86400).to_i
```

real-time calls and options

```ruby
    c.histogram             keys: 'R,W,I', breaks: '1,5,10'
    c.pathsummary           keys: 'I,n,r', types: 'n,n,s'
    c.quickstats
    c.recent
    c.referrers
    c.summary               keys: 'I,n,r'
    c.toppages
    c.geo
```

historical calls and options

```ruby
    c.alerts                since: 1233739200
    c.snapshots             api: 'pages', timestamp: 1233739200
    c.stats
    c.data_series           type: 'summary', days: 1, minutes: 20
    c.day_data_series       type: 'paths', timestamp: 1233739200
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012 Al Shaw. See LICENSE for details.
