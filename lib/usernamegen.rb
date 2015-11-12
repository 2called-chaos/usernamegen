require "usernamegen/version"
require "securerandom"
require "active_support"
require "active_support/core_ext"

class Usernamegen
  ROOT = File.expand_path("../..", __FILE__)

  def self.one(opts = {}, &block)
    new(opts).one(&block)
  end

  def self.all opts = {}
    new(opts).all
  end

  def self.all_for_thing thing, opts = {}
    new(opts).all_for_thing(thing)
  end

  def self.all_for_desc desc, opts = {}
    new(opts).all_for_desc(desc)
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

  def one(&block)
    username_arr = [@descriptions.sample(1, random: @opts[:rng]), @things.sample(1, random: @opts[:rng])]

    formatted = if block_given?
      yield username_arr
    else
      username_arr.join(" ").titleize
    end

    formatted
  end

  def all
    @descriptions.product(@things).map{|combination| combination.join(" ").titleize }
  end

  def all_for_thing thing
    @descriptions.product([thing]).map{|combination| combination.join(" ").titleize }
  end

  def all_for_desc desc
    [desc].product(@things).map{|combination| combination.join(" ").titleize }
  end
end
