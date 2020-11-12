# frozen_string_literal: true

class PostcodeController < ApplicationController
  def index; end

  def check
    @result = if ServiceAreaCheckerService.new(params[:postcode]).allowed?
                { success: true, text: 'This postcode is within our service area' }
              else
                { success: false, text: 'This postcode is NOT within our service area' }
              end
  rescue PostcodeService::ApiUnavailableError => e
    @result = { success: false, text: e.message }
  rescue PostcodeService::InvalidPostcodeError => e
    @result = { success: false, text: e.message }
  ensure
    render 'index'
  end
end
