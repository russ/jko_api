# JkoApi

This is an API versioning gem for rails. Yes, there are a lot of really good and easy ones out there, but the issue with all of them is that when you make a version change, you're copying an entire folder of controllers, specs, and a bunch of routes over just for a single API change.

This gem lets you make a single change and reversion an API without copying over a billion files and specs.

## Props

99.999999999999% of this gem was written by [Justin Ko](https://github.com/justinko). Since he's lazy and won't make a gem from it, I'm doing it for him :stuck_out_tongue: That's why the gem is named after him.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jko_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jko_api

## Usage

In your `config/routes.rb`

```ruby
JkoApi.routes self do
  version 1 do
    # put base routes and routes for version 1 here
    resources :foos
    resources :bars
  end
  version 2 # no route changes, maybe just a controller change
  version 3 do
    resources :bars, only: [:index] # only changes :bars in version 3
  end
end  
```

Place your version 1 controller code in `app/controllers/api/v1`. Controllers should all inherit from `Api::ApplicationController`, or something that inherits from that.

```ruby
class Api::V1::BarsController < Api::ApplicationController
  def index
    # do stuff
  end
  def show
    # show stuff
  end
end
```

Any controllers that you need to alter will go into a new folder in `app/controllers/api/v2`. Notice in this one we inherit from the last version controller.

```ruby
class Api::V2::BarsController < Api::V1::BarsController
  def index
    # do different stuff
  end
  # no need to redefine show action because it didn't change
end
```

We can still do this though

```ruby
class Api::V3::BarsController < Api::ApplicationController
  def index
    # do different stuff
  end
end
```

You can test this all by booting up a simple rails app, then do `curl -H "Accept: application/vnd.api.v1+json" http://localhost:3000/bars`


## Contributing

1. Fork it ( https://github.com/[my-github-username]/jko_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
