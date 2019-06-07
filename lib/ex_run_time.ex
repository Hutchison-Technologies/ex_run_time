defmodule ExRunTime do
  @moduledoc """
  Tiny elixir library useful for examining the runtime environment.
  """

  @doc """
  Examines the system environment variables to determine whether or not the
  application is running in Kubernetes.

  Returns true or false.

  Uses `System.get_env()` by default but you can pass in your own map.

  ## Examples
      iex> ExRunTime.is_kubernetes?(%{"KUBERNETES_POD" => "some-pod"})
      true
      iex> ExRunTime.is_kubernetes?(%{})
      false
  """
  @spec is_kubernetes?(%{String.t() => String.t()}) :: boolean()
  def is_kubernetes?(env \\ System.get_env())

  def is_kubernetes?(env) when is_map(env),
    do: Enum.any?(env, fn {k, _v} -> k =~ "KUBERNETES_" end)

  def is_kubernetes?(_), do: false

  @doc """
  Examines the system environment variables to determine whether or not the
  application is running in test.

  Returns true or false.

  Uses `System.get_env()` by default but you can pass in your own map.

  ## Examples
      iex> ExRunTime.is_test?()
      false
      iex> ExRunTime.is_test?(%{})
      false
      iex> ExRunTime.is_test?(%{"MIX_ENV" => "test"})
      true
      iex> ExRunTime.is_test?(%{"MIX_ENV" => "prod"})
      false
  """
  @spec is_test?(%{String.t() => String.t()}) :: boolean()
  def is_test?(env \\ System.get_env())
  def is_test?(%{"MIX_ENV" => "test"}), do: true
  def is_test?(_), do: false

  @doc """
  Examines the system environment variables to determine whether or not the
  application is running in the production environment.

  Returns true or false.

  Uses `System.get_env()` by default but you can pass in your own map.

  ## Examples
      iex> ExRunTime.is_production_deploy?()
      false
      iex> ExRunTime.is_production_deploy?(%{})
      false
      iex> ExRunTime.is_production_deploy?(%{"DEPLOYED_ENV" => "test"})
      false
      iex> ExRunTime.is_production_deploy?(%{"DEPLOYED_ENV" => "prod"})
      true
  """
  @spec is_production_deploy?(%{String.t() => String.t()}) :: boolean()
  def is_production_deploy?(env \\ System.get_env())
  def is_production_deploy?(%{"DEPLOYED_ENV" => "prod"}), do: true
  def is_production_deploy?(_), do: false
end
