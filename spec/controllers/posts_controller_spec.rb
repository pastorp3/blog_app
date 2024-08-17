require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:user_post) { create(:post, user: user) }
  let!(:another_post) { create(:post, user: another_user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all posts to @posts' do
      get :index
      expect(assigns(:posts)).to match_array([user_post, another_post])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Post to @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: attributes_for(:post) }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the posts index with a notice' do
        post :create, params: { post: attributes_for(:post) }
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq('Post was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new post' do
        expect {
          post :create, params: { post: attributes_for(:post, title: nil) }
        }.not_to change(Post, :count)
      end

      it 'redirects to the new post path with an alert' do
        post :create, params: { post: attributes_for(:post, title: nil) }
        expect(response).to redirect_to(new_post_path)
        expect(flash[:alert]).to include("Title can't be blank")
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested post to @post' do
      get :edit, params: { id: user_post.id }
      expect(assigns(:post)).to eq(user_post)
    end

    it 'renders the edit template' do
      get :edit, params: { id: user_post.id }
      expect(response).to render_template(:edit)
    end

    context 'when trying to edit another user\'s post' do
      it 'redirects to the posts index with an alert' do
        get :edit, params: { id: another_post.id }
        expect(response).to redirect_to(posts_path)
        expect(flash[:alert]).to eq('Not authorized!')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the post' do
        patch :update, params: { id: user_post.id, post: { title: 'New Title' } }
        user_post.reload
        expect(user_post.title).to eq('New Title')
      end

      it 'redirects to the posts index with a notice' do
        patch :update, params: { id: user_post.id, post: { title: 'New Title' } }
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq('Post was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the post' do
        patch :update, params: { id: user_post.id, post: { title: nil } }
        user_post.reload
        expect(user_post.title).not_to be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: user_post.id, post: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end

    context 'when trying to update another user\'s post' do
      it 'does not update the post and redirects with an alert' do
        patch :update, params: { id: another_post.id, post: { title: 'New Title' } }
        another_post.reload
        expect(another_post.title).not_to eq('New Title')
        expect(response).to redirect_to(posts_path)
        expect(flash[:alert]).to eq('Not authorized!')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the post' do
      expect {
        delete :destroy, params: { id: user_post.id }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts index with a notice' do
      delete :destroy, params: { id: user_post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eq('Post was successfully destroyed.')
    end

    context 'when trying to delete another user\'s post' do
      it 'does not delete the post and redirects with an alert' do
        expect {
          delete :destroy, params: { id: another_post.id }
        }.not_to change(Post, :count)
        expect(response).to redirect_to(posts_path)
        expect(flash[:alert]).to eq('Not authorized!')
      end
    end
  end
end
