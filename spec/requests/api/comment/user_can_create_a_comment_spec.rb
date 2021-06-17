RSpec.describe 'POST /api/articles/:id/comments', type: :request do
  let(:article) { create(:article) }
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'successfully as a user' do
    before do
      post "/api/articles/#{article.id}/comments", params: {
        body: 'User\'s comment body'
      }, headers: auth_headers
    end

    it 'is expected to respond with status 201' do
      expect(response).to have_http_status 201
    end

    it 'is expected to respond with success message' do
      expect(response_json['message']).to eq 'Your comment has been created'
    end

    it 'is expected to create a comment' do
      expect(Comment.last['body']).to eq 'User\'s comment body'
    end
  end

  describe 'unsuccessfully with no auth headers' do
    before do
      post "/api/articles/#{article.id}/comments", params: {
        body: 'Visitors\'s comment body'
      }
    end

    it 'is expected to respond with status 401' do
      expect(response).to have_http_status 401
    end

    it 'is expected to respond with success message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'unsuccessfully with empty body' do
    before do
      post "/api/articles/#{article.id}/comments", params: {
        body: ''
      }
    end

    it 'is expected to respond with status 422' do
      expect(response).to have_http_status 422
    end

    it 'is expected to respond with success message' do
      expect(response['error_message']).to eq 'Comment can not be empty'
    end
  end
end
