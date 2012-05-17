# http://ar156.dip.jp/tiempo/publish/52

class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception,
    :with => :render_500 unless Rails.env == 'development'

  rescue_from ActionController::RoutingError,
    ActiveRecord::RecordNotFound,
    :with => :render_404 unless Rails.env == 'development'

  def render_404(exception = nil)
    if exception
      logger.info "Redirect 404 with exception: #{exception.message}"
    end
    redirect_to Constants.path.not_found
  end

  def render_500(exception = nil)
    if exception
      logger.info "Redirect 500 with exception: #{exception.message}"
    end
    redirect_to Constants.path.server_error
  end
end

