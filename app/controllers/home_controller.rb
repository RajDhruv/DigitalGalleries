class HomeController < ApplicationController
before_action :authenticate_user!, except:[:index]
  def index
  	@users=User.get_all_users
  end
  def index2
  end
end
