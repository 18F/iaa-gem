[![Build Status](https://travis-ci.org/18F/iaa-gem.svg)](https://travis-ci.org/18F/iaa-gem)

# IAA

## Installation

Dependencies (other than standard Ruby/bundler):

- `pdftk`. Get it [here](https://www.pdflabs.com/tools/pdftk-server/).

Add this line to your application's Gemfile:

```ruby
gem 'iaa', github: '18F/iaa-gem'
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

See `lib/form_7600a.rb` and `lib/form_7600b` for all getter and setter methods.

### mappings.json

This repo provides a JSON file for each form (`lib/mappings/7600A.json` and `lib/mappings/7600B.json`) of all form fields including their types and possible values (e.g. for radio buttons and checkboxes). This could be used to map objects in other languages to the IAA Form 7600A.

## Docker Compose Usage

1. Make sure that [Docker Compose](https://docs.docker.com/compose/install/) is installed.
2. Navigate to iaa-gem directory and run `docker-compose build`. 
3. Run `docker-compose run iaa`.

## Caveats

Currently, the following fields cannot be set:

### Form 7600A

- gt_and_c_number
- general_explanation_overhead_fees_and_charges
- number_of_days_this_iaa_may_be_terminated

### Form 7600B

- gt_and_c_number
- requesting_agency_a
- servicing_agency_a
- overhead_fees_and_charges

See https://github.com/18F/iaa-gem/issues/6.

## Development

After checking out the repo, run `gem install bundler && bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/18F/iaa-gem.
