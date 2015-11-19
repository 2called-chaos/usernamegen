require "usernamegen/version"
require "securerandom"
require "active_support"
require "active_support/core_ext"

class Usernamegen
  ROOT = File.expand_path("../..", __FILE__)

  def self.one(opts = {}, &block)
    new(opts).one(&block)
  end

  def self.all(opts = {}, &block)
    new(opts).all(&block)
  end

  def self.all_for_thing(thing, opts = {}, &block)
    new(opts).all_for_thing(thing, &block)
  end

  def self.all_for_desc(desc, opts = {}, &block)
    new(opts).all_for_desc(desc, &block)
  end

  def initialize opts = {}, &block
    @opts = opts.reverse_merge({
      descriptions: "#{ROOT}/lib/usernamegen/descriptions.txt",
      things: "#{ROOT}/lib/usernamegen/things.txt",
      rng: ::SecureRandom.urlsafe_base64(128),
      format: block || ->(combination){ combination.join(" ").titleize },
    })
    @descriptions = load_file @opts[:descriptions]
    @things = load_file @opts[:things]
  end

  def load_file file
    File.read(file).split("\n").map(&:strip).reject(&:blank?)
  end

  def one &block
    combination = [@descriptions.sample(1, random: @opts[:rng]), @things.sample(1, random: @opts[:rng])]
    (block || @opts[:format]).call(combination)
  end

  def all &block
    @descriptions.product(@things).map(&(block || @opts[:format]))
  end

  def all_for_thing thing, &block
    @descriptions.product([thing]).map(&(block || @opts[:format]))
  end

  def all_for_desc desc, &block
    [desc].product(@things).map(&(block || @opts[:format]))
  end
end
