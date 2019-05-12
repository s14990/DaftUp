require 'rails_helper'

RSpec.describe CartsController, type: :controller do
    subject(:cart) {Cart.create}
    it 'responds with 200' do
        get :show
        expect(response).to have_http_status(200)
    end

end
