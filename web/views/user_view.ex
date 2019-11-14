defmodule SimpleApp.UserView do
	use SimpleApp.Web, :view

	 def render("user_error.json", %{error: error}) do
    %{
      reason: error      
    }
  end

  def render("user_errors.json", %{errors: errors}) do
  	%{errors: render_many(errors, __MODULE__, "user_error.json", as: :error),}
  end
end