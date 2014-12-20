require "minitest/autorun"
require "usernamegen"

class TestUsernamegen < Minitest::Test
  def test_random_factor
    100.times do # <-- just to make sure ;)
      t = Time.now.to_i
      assert_equal Usernamegen.one(rng: Random.new(t)), Usernamegen.one(rng: Random.new(t))
      refute_equal Usernamegen.one(rng: Random.new(t)), Usernamegen.one(rng: Random.new(t + 1))
    end
  end
end
