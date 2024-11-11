class PwaController < ApplicationController
  def manifest
    respond_to do |format|
      format.json { render template: "pwa/manifest" }
    end
  end
end