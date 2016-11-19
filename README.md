# CQRS

The goal of this is to experiment with Elixir to build
a small program following the CQRS architecture.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `cqrs` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:cqrs, "~> 0.1.0"}]
    end
    ```

  2. Ensure `cqrs` is started before your application:

    ```elixir
    def application do
      [applications: [:cqrs]]
    end
    ```
