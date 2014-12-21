# Usernamegen - a not so serious name generator

[![Gem Version](https://badge.fury.io/rb/usernamegen.svg)](http://badge.fury.io/rb/usernamegen)
[![Build Status](https://travis-ci.org/2called-chaos/usernamegen.svg?branch=master)](https://travis-ci.org/2called-chaos/usernamegen)

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

You can use the generator class like so:

    # load files and assembles list each time (yielding more than 1 million strings, cache them!)
    Usernamegen.all

    # same as #all but returns random entry
    Usernamegen.one


You can find an example ActiveRecord model + rake import tasks in the following gist.

  * [» ActiveRecord model example and rake import task](https://gist.github.com/2called-chaos/46705324d913e4f9cc6b)

## Testing

Just `bundle` and invoke `rake`.

## Contributing

1. Fork it ( http://github.com/2called-chaos/usernamegen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
