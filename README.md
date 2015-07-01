[![Build Status](https://travis-ci.org/18F/iaa-gem.svg)](https://travis-ci.org/18F/iaa-gem)

# IAA

## Installation

Dependencies (other than standard Ruby/bundler):

- `pdftk`. Get it [here](https://www.pdflabs.com/tools/pdftk-server/).

Add this line to your application's Gemfile:

```ruby
gem 'iaa'
```

To use the latest and greatest:

```ruby
gem 'iaa', github: '18F/iaa-gem', branch: 'master'
```

And then execute:

```sh
$ bundle
```

## Usage

This gem makes available two classes, `IAA::Form7600A` and `IAA::Form7600B`.

### Open and read an existing IAA Form 7600A or 7600B

```ruby
form = IAA::Form7600A.new(pdf_path: 'path/to/7600A.pdf')
form.start_date #=> "05-20-2015"
form.end_date #> "06-20-2015"
# ... etc
```

### Edit and save an IAA Form 7600A or 7600B

```ruby
form.start_date = "05-21-2015"
form.save('/path/to/save/destination')
```

Note: the default directory to save is the "tmp" directory within the iaa-gem directory.

### Start from a blank IAA Form 7600A or 7600B

```ruby
form2 = IAA::Form7600A.new
form2.start_date = "07-07-2016"
form.save('/path/to/save/destination')
```

See `lib/mappings/7600A.json` and `lib/mappings/7600A.json` for all getter and setter methods. The field in these files called `"attribute_name"` corresponds to all getter and setter method names. For example in `lib/mappings/7600A.json`, we have:

```json
// ...
  {
    "name": "Start Date",
    "attribute_name": "start_date",
    "options": null,
    "type": "Text",
    "value": "FILL IN"
  },
// ...
```

This means instances of `IAA::Form7600A` have the methdods `#start_date` and `#start_date=`. All of the methods are created during `::initialize` through some metaprogramming. Think of the JSON files in the `mappings` folder as the canonical source of method names.

You could also use these JSON files to create IAA form fillers in other languages.

### PDFs

The PDFs in `lib/pdfs` have been modified somewhat from their originals. Visually, nothing has changed, but a few of the underlying form field names have been changed. For example, one field, "GT & C #" caused a lot of trouble because of that pesky ampersand. So, the field value in the PDF was changed to "gt_and_c_number".

### API Server

This gem includes an API server! It's just a small, mountable Sinatra application.

To set up, just mount the server inside of a Rails app, for example--or just run it standalone:

Create a `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'iaa'
gem 'thin'
```

Run `bundle`.

Create a `config.ru`:

```ruby
require 'bundler/setup'
require 'iaa'

run Rack::URLMap.new(
  '/iaa' => IAA::Server
)
```

And run with:

```sh
$ bundle exec thin start
```

#### POST /7600a

POST some JSON of keys and values that match the attributes in `lib/mappings/7600a.json` and get back a PDF response.

## Docker Compose Usage

1. Make sure that [Docker Compose](https://docs.docker.com/compose/install/) is installed.
2. Navigate to iaa-gem directory and run `docker-compose build`.
3. Run `docker-compose run iaa`.



## Development

After checking out the repo, run `gem install bundler && bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/18F/iaa-gem.

