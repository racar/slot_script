
require 'test/unit'
require './slot_script.rb'

class SlotScriptTest < Test::Unit::TestCase
  def test_repetitions
    assert_equal 3, SlotScript.repetitions(["J","J","J","Q","A"])
    assert_equal 2, SlotScript.repetitions(["J","J","A","Q","A"])
    assert_equal 4, SlotScript.repetitions(["J","J","A","J","J"])
  end

  def test_game_score
    h = {"J J J Q A" => 3}
    assert_equal h, SlotScript.new.game_score(["J","J","J","Q","A"])
    h = {"J J A J J" => 4}
    assert_equal h, SlotScript.new.game_score(["J","J","A","J","J"])
    assert_equal nil, SlotScript.new.game_score(["J","J","A","Q","A"])
  end

  def test_get_paylines
    expect = [{"J J J Q K"=>3}, {"J J J monkey K"=>3}]
    assert_equal expect, SlotScript.new.get_paylines(["J", "J", "J", "Q", "K", "cat", "J", "Q", "monkey", "bird", "bird", "bird", "J", "Q", "A"])
  end

  def test_total_win
    assert_equal 0, SlotScript.new.total_win([{"J J Q Q K"=>2}, {"J J Q monkey K"=>2}])
    assert_equal 40, SlotScript.new.total_win([{"J J J Q K"=>3}, {"J J J monkey K"=>3}])
    assert_equal 220, SlotScript.new.total_win([{"J J J J K"=>4}, {"J J J monkey K"=>3}])
    assert_equal 1020, SlotScript.new.total_win([{"J J J J J"=>5}, {"J J J monkey K"=>3}])
  end
end
