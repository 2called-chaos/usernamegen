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

  def initialize opts = {}
    @opts = opts.reverse_merge({
      descriptions: "#{ROOT}/lib/usernamegen/descriptions.txt",
      things: "#{ROOT}/lib/usernamegen/things.txt",
      rng: ::SecureRandom.urlsafe_base64(128),
    })
    @descriptions = load_file @opts[:descriptions]
    @things = load_file @opts[:things]
  end

  def load_file file
    File.read(file).split("\n").map(&:strip).reject(&:blank?)
  end

  def one
    combination = [@descriptions.sample(1, random: @opts[:rng]), @things.sample(1, random: @opts[:rng])]

    if block_given?
      yield combination
    else
      combination.join(" ").titleize
    end
  end

  def all
    if block_given?
      @descriptions.product(@things).map{|combination| yield combination }
    else
      @descriptions.product(@things).map{|combination| combination.join(" ").titleize }
    end
  end

  def all_for_thing thing
    if block_given?
      @descriptions.product([thing]).map{|combination| yield combination }
    else
      @descriptions.product([thing]).map{|combination| combination.join(" ").titleize }
    end
  end

  def all_for_desc desc
    if block_given?
      [desc].product(@things).map{|combination| yield combination }
    else
      [desc].product(@things).map{|combination| combination.join(" ").titleize }
    end
  end
end
