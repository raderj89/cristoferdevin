class Admin::OrdersController < Admin::ApplicationController
  inherit_resources
  before_action :require_admin_signin!
  layout "admin"
end