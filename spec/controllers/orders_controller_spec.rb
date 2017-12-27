require 'rails_helper'

describe OrdersController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      cart = FactoryBot.create(:cart)
      cart.line_items=FactoryBot.create(:line_item)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'renders the :new template' do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      post :create, order: { name: 'qwee', address: 'wqeqwe', email: '12@12.com', pay_type: 'Check' }
      expect(Order.count).to eq(1)
    end
  end

  it { expect  route(:put, '/orders/1').to(action: :update, id: 1) }
  it { expect  route(:delete, '/orders/1').to(action: :destroy, id: 1) }

  describe 'DELETE #destroy' do
    it "deletes the cart" do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      cart = FactoryBot.create(:order)
      delete :destroy, { id: cart.id }
      expect(session[:cart_id]).to eq nil
    end
  end

  describe '#update' do
    it 'responds to PUT' do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id
      order = FactoryBot.create(:order)
      put :update, order: { name: order.name, address: order.address, email: order.email, pay_type:order.pay_type }, id: order.id
      expect(flash[:notice]).to match(/^Order was successfully updated/)
    end
  end

end


