defmodule ExRunTimeTest do
  use ExUnit.Case
  doctest ExRunTime

  describe "is_kubernetes?" do
    test "returns false when environment contains no KUBERNETES_ vars" do
      refute ExRunTime.is_kubernetes?(%{"SOME_VAR" => "VAL"})
    end

    test "returns true when environment contains KUBERNETES_ vars" do
      assert ExRunTime.is_kubernetes?(%{"KUBERNETES_" => "VAL"})
    end
  end

  describe "is_test?" do
    test "returns false when MIX_ENV is not set" do
      refute ExRunTime.is_test?(%{})
    end

    test "returns false when MIX_ENV is not test" do
      refute ExRunTime.is_test?(%{"MIX_ENV" => "dev"})
    end

    test "returns true when MIX_ENV is test" do
      assert ExRunTime.is_test?(%{"MIX_ENV" => "test"})
    end
  end

  describe "is_production_deploy?" do
    test "returns false when DEPLOYED_ENV is not set" do
      refute ExRunTime.is_production_deploy?(%{})
    end

    test "returns false when DEPLOYED_ENV is not prod" do
      refute ExRunTime.is_production_deploy?(%{"DEPLOYED_ENV" => "dev"})
    end

    test "returns true when DEPLOYED_ENV is prod" do
      assert ExRunTime.is_production_deploy?(%{"DEPLOYED_ENV" => "prod"})
    end
  end
end
