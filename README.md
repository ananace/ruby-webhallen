# Webhallen

Just a simple gem to access the Webhallen online store API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webhallen'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install webhallen

## Usage

```ruby
require 'webhallen'

result = Webhallen.search Webhallen::Query.new.with_category(47).with_text('pulse')
# => { products: [...], totalProductCount: 4 }
result[:products].first.name
# => "SAPPHIRE PULSE Radeon RX 580 8G Dual OC"
result[:products].first.in_stock?
# => true

prod = Webhallen::Product.get_by_id 312784
# => #<Webhallen::Product ...>
prod.name
# => "SAPPHIRE PULSE Radeon RX 580 8G Dual OC"
prod.pretty_price
# => "2199.00 SEK"
```

## Contributing

Bug reports and pull requests are welcome [on GitHub](https://github.com/ananace/ruby-webhallen).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
