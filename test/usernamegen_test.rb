require "minitest/autorun"
require "usernamegen"

class TestUsernamegen < Minitest::Test

  def test_one
    assert_equal "Aquamarine Monkey", Usernamegen.one(rng: Random.new(1))
  end

end
