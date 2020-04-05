defmodule ElixirTest do
  use Assertion
  import While
  import Html

  test "arithmetic operations" do
    assert 1 == 1
    assert 1 == 1
    assert 1 == 2
    assert 2 < 1
  end

  def test_markup(dependency) do
    markup do
      div(class: "row") do
        h1 do
          text do: "Some random title"
        end

        if dependency != nil do
          p do
            text do: "WHOA"
          end
        end

        for i <- 1..5 do
          p do
            text do: "#{dependency + i}. Just trying things out"
          end
        end
      end
    end
  end

  def test_while do
    pid = spawn(fn -> :timer.sleep(15000) end)
    while Process.alive?(pid) do
      IO.puts("WHOA")
      :timer.sleep(1000)
      if :rand.uniform(100) > 80, do: :break
    end
  end
end
