class Admin::FaqsController < ApplicationController
  inherit_resources
  layout "admin"

  private 

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end