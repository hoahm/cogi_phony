# PhonyRails [![Build Status](https://travis-ci.org/hoahm/cogi_phony.svg?branch=master)](https://travis-ci.org/hoahm/cogi_phony) [![Coverage Status](https://coveralls.io/repos/github/hoahm/cogi_phony/badge.svg)](https://coveralls.io/github/hoahm/cogi_phony) [![GitHub issues](https://img.shields.io/github/issues/hoahm/cogi_phony.svg)](https://github.com/hoahm/cogi_phony/issues)

This gem provide you library to validate, parsing, format and normalize phone number, detect phone network in Vietnam.

It uses the super awesome Phony gem (https://github.com/floere/phony).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cogi_phony'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install cogi_phony
```

## Usage

### Validation

Check if a string is a valid phone number.

```ruby
CogiPhony.validate? '+14037089189' # => true
```


### Normalization

Normalize phone numer to international format.

```ruby
CogiPhony.normalize '+1 (403) 708-9189' # => '+14037089189'
```

### Formatting

Format formats phone numbers according to the predominant format of a country. 

```ruby
CogiPhony.format '+84933081090' # => +84 93 3081090
CogiPhony.format '+84933081090', format: 'global' # => '+84 93 3081090'
CogiPhony.format '+84933081090', format: 'vietnam' # => '093 3081090'
```

### Extract country code

Extract country code from phone number.

```ruby
CogiPhony.country_code_from_number '+84933081090' # => '84'
```


### Check if Vietnam mobile phone

Check if phone number is Vietnam mobile phone format

```ruby
CogiPhony.vn_mobile_phone? '+84933081090' # => true
```


### Phone provider

Return phone provider from phone number.

```ruby
CogiPhony.phone_to_provider '+84933081090' # => 'Mobifone'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Don't forget to add tests and run rspec before creating a pull request :)

See all contributors on https://github.com/hoahm/cogi_phony/graphs/contributors.
