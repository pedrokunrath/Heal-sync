class AdminApplicationController < ApplicationController
  before_action :authenticate_user!
end
