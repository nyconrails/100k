class VersionsController < ApplicationController

  before_filter :authenticate_admin_user!

  def revert
    @version = Version.find(params[:id])
    if @version.reify
      @version.reify.save!
      msg = "This item has been reverted to the selected version."
    else
      msg = "This item could not be reverted due to a system error."
    end
    redirect_to :back, :notice => msg
  end

end
