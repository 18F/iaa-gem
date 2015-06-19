# IAA

## Installation

Dependencies (other than standard Ruby/bundler):

- `pdftk`. Get it [here](https://www.pdflabs.com/tools/pdftk-server/).

Add this line to your application's Gemfile:

```ruby
gem 'iaa', github: '18F/iaa'
```

And then execute:

```sh
$ bundle
```

## Usage

### Open and read an existing IAA Form 7600A

```ruby
form = IAA::Form7600A.new(pdf_path: 'path/to/7600A.pdf')
form.start_date #=> "05-20-2015"
form.end_date #> "06-20-2015"
# ... etc
```

### Edit and save an IAA Form 7600A

```ruby
form.start_date = "05-21-2015"
form.save('/path/to/save/destination.pdf')
```

### Start from a blank IAA Form 7600A

```ruby
form2 = IAA::Form7600A.new
form2.start_date = "07-07-2016"
form2.save('/path/to/save/destination2.pdf')
```

See `lib/iaa.rb` for all getter and setter methods.

### mappings.json

This repo provides a JSON file (`lib/mappings/7600A.json`) of all form fields including their types and possible values (e.g. for radio buttons and checkboxes). This could be used map objects in other languages to the IAA Form 7600A.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/18F/iaa.

