class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      alert = t('shared.you_are_not_authorized_to_access_this_page')
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: }
      format.turbo_stream { flash.now.alert = alert }
    end
  end
end
