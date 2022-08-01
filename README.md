# Usernamegen - a not so serious name generator

[![Gem Version](https://badge.fury.io/rb/usernamegen.svg)](http://badge.fury.io/rb/usernamegen)
[![Build Status](https://github.com/2called-chaos/usernamegen/actions/workflows/spec.yml/badge.svg)](https://github.com/2called-chaos/usernamegen/actions/workflows/spec.yml)

We thought our users should be able to comment even when they haven't choose a username yet.
To make it easier to follow conversations we didn't want to show "anonymous" or some boring incrementing name á la "guest 1234".

This gem uses two lists (descriptive words and nouns) and multiplies them with each and another resulting in a list of mostly meaningful and often silly name combinations.

**The current list generates at least 1,367,631 unique usernames**. Please help increasing the size by providing more words.

## Example names

  * Delicate Puppy
  * Mysterious Wheatley
  * Tough Goldfish
  * Chemical Rabbit
  * [surprise me](https://de.gamesplanet.com/namegen)


## Installation

Requires Ruby >= 1.9.3

Simple as:

    $ gem install usernamegen

Or list in your Gemfile

    gem 'usernamegen'


## Usage

You can use the generator class like so (also see Caching/Benchmark):

```ruby
# Assembles whole list each time (yielding more than 1 million strings, cache them!)
Usernamegen.all

# Samples one item from both lists and assembles them (fast)
Usernamegen.one

# Uses multiple `#one` calls to give you an array of names without having to take a subset of `#all`.
# You may get duplicate names! This is just a shorthand as simple as `AMOUNT.times.map{ one }`.
Usernamegen.some(10)

# Assembles a list for a given thing (huge result set)
Usernamegen.all_for_thing("thing")

# Assembles a list for a given description (huge result set)
Usernamegen.all_for_desc("description")
```

Initiating the class will instantly load the two text files into memory (as array). You can also use the instance approach if you have multiple calls to the generator.

```ruby
generator = Usernamegen.new(opts = {}, &formatter)
generator.one
generator.all_for_thing
```

## Custom format

You can return usernames in your custom format at all methods. Just pass a block, e.g.:

```ruby
Usernamegen.one { |combination| combination.join("-").downcase }
=> "able-action"
```

If you use the instance approach you may also want to redefine the default format.

```ruby
generator = Usernamegen.new format: ->(combination){ combination.join("-").downcase }

# or sugar version
generator = Usernamegen.new { |combination| combination.join("-").downcase }

generator.one
=> "malicious-expert"
```


## Options

The generator class has a few options but except for the format option there is little reason for you to change them.

```ruby
Usernamegen.new({
  # The default format (note that passing a block to #new will overwrite the hash option)
  format: ->(combination){ combination.join(" ").titleize },

  # This option only exists for testing
  rng: ::SecureRandom.urlsafe_base64(128),

  # You could point to different word lists here
  descriptions: "#{ROOT}/lib/usernamegen/descriptions.txt",
  things: "#{ROOT}/lib/usernamegen/things.txt",
})
```


## Caching / Benchmark

While the `#one` and `#some` methods are quite fast it's still advised to import the combinations to your database in a batch fashion opposed to generate single names on the fly.

We suggest a separate _Codename_ model and assign a free name to a user when he needs one (usually upon registration or first post). You can find an example ActiveRecord model + rake import tasks in the following gist.

  * [» Benchmarks](https://gist.github.com/2called-chaos/a0ea619fdc7ef245719d)
  * [» ActiveRecord model example and rake import task](https://gist.github.com/2called-chaos/46705324d913e4f9cc6b)


## Testing

Just `bundle` and invoke `rake`.

## Contributing

1. Fork it ( http://github.com/2called-chaos/usernamegen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
