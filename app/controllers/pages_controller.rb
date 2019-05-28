class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    @no_navbar = true
  end
end
