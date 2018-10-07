defmodule Benchmark do

  def run do
    Benchee.run(
      %{
        "Bloomex.prohibited?"    => fn -> PasswordBloomex.prohibited?("austin") end
      }
    )
  end
end
