class MediaController < ApplicationController
  def index
    @media = ActiveStorage::Attachment.order(created_at: :desc)
                                      .page(params[:page])
  end
end
