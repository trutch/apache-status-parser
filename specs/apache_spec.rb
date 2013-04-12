require 'minitest/autorun'

describe ApacheStatus do
  @apache_status = ApacheStatus.new

  it "should have a hash with all scoreboard values" do
    @apache_status.scoreboard.keys.count.must_be == 11
  end
end

class ApacheStatus
end

=begin
class TestMeme < MiniTest::Unit::TestCase
  def setup
    @meme = Meme.new
  end

  def test_that_kitty_can_eat
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  end

  def test_that_it_will_not_blend
    refute_match /^no/i, @meme.will_it_blend?
  end

  def test_that_will_be_skipped
    skip "test this later"
  end
end
=end
