# Ruboty::HaikuWoYome

ハイクを詠め、カイシャクしてやる

## Caution!!!

This gem is work on Slack ONLY !!!!!!!!!!!!!!!!!!

## Require

Mecab
more infomation(https://github.com/r7kamura/ikku)

## Installation

Write this in your Ruboty Gemfile

```ruby
gem 'ruboty-haiku_wo_yome'
```

And then execute:

    $ bundle

## Configure

```
   SLACK_TOKEN_FOR_SEARCH        - Slack token for search (bot token can't use search api)
```

## Usage

```
@kinoppyd: ハイクを読め
すいません今日は早めに帰宅して
```

## LICENSE

WTFPL

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruboty-haiku_wo_yome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

