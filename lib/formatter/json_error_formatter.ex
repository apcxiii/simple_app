defmodule SimpleApp.JsonErrorFormatter do
  def format(errors) do
    Enum.map(errors, fn %ExJsonSchema.Validator.Error{error: error, path: path} ->
      "#{error} => #{path}"
    end)
  end
end
