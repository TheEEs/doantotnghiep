require 'rails_helper'

RSpec.describe "Exports", type: :request do
  describe "GET /export" do
    it "returns http success" do
      get "/export/export"
      expect(response).to have_http_status(:success)
    end
  end
end
