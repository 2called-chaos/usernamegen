require "minitest/autorun"
require "usernamegen"

class TestUsernamegen < Minitest::Test
  def test_random_factor
    10.times do # <-- just to make sure ;)
      t = Time.now.to_i
      assert_equal Usernamegen.one(rng: Random.new(t)), Usernamegen.one(rng: Random.new(t))
      refute_equal Usernamegen.one(rng: Random.new(t)), Usernamegen.one(rng: Random.new(t + 1))
    end
  end

  def test_default_format
    assert_match /^([A-Z][a-z]*((\s)))+[A-Z][a-z]*$/, Usernamegen.one
  end

  def test_custom_format
    username = Usernamegen.one { |username| username.join("-").downcase }
    assert_match /^([a-z]*((-)))+[a-z]*$/, username
  end

  def test_amount_of_names
    # don't forget to update README as well!
    assert_equal Usernamegen.all.count, 1_367_631
  end
end
