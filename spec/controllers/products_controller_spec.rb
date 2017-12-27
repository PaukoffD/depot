require 'rails_helper'

describe ProductsController, type: :controller do

  before {
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'renders the :new template' do
      post :create, product: { title: 'book21212121', description: 'book', image_url: '12.jpg', price: 333.33 }
      expect(Product.count).to eq(1)
    end
  end

  it { expect  route(:put, '/products/1').to(action: :update, id: 1) }
  it { expect  route(:delete, '/products/1').to(action: :destroy, id: 1) }

  describe 'DELETE #destroy' do
    it "deletes the cart" do
      product = FactoryBot.create(:product)
      delete :destroy,  { id: product.id }
      expect(flash[:notice]).to match(/^Product was successfully destroyed/)
    end
  end

  describe '#update' do
    it "responds to PUT" do
      product = FactoryBot.create(:product)
      put :update, product: { title: 'book21212121', description: 'book', image_url: '12.jpg', price: 333.33 },  id: product.id
      expect(flash[:notice]).to match(/^Product was successfully updated/)
    end
  end

end


