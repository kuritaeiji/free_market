require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe('GET /users/:id') do
    context('ユーザーが存在する場合') do
      let(:user) { create(:user) }

      it('リクエストが成功すること') do
        get("/users/#{user.id}")
        expect(response.status).to eq(200)
      end

      it('ユーザー名が表示されていること') do
        get("/users/#{user.id}")
        expect(response.body).to include(user.nickname)
      end
    end

    context('ユーザーが存在しない場合') do
      it('エラーが発生する') do
        expect { get("/users/1") }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe('GET /users/new') do
    it('リクエストが成功すること') do
      get('/users/new')
      expect(response.status).to eq(200)
    end
  end

  describe('POST /users') do
    context('パラメーターが妥当な場合') do
      let!(:prefecture) { create(:prefecture) }

      it('ユーザーが登録されること') do
        expect { post('/users', params: { user: attributes_for(:user, :valid) }) }.to change(User, :count).by(+1)
      end

      it('リクエストが成功すること') do
        post('/users', params: { user: attributes_for(:user, :valid) })
        expect(response.status).to eq(302)
      end

      it('リダイレクトすること') do
        post('/users', params: { user: attributes_for(:user, :valid) })
        expect(response).to redirect_to(root_url)
      end
    end

    context('パラメーターが不正な場合') do
      let(:invalid_params) { { user: attributes_for(:user, :invalid) } }

      it('リクエストが成功すること') do
        post('/users', params: invalid_params)
        expect(response.status).to eq(200)
      end

      it('ユーザーが登録されないこと') do
        expect { post('/users', params: invalid_params) }.not_to change(User, :count)
      end

      it('エラーメッセージが表示されること') do
        post('/users', params: invalid_params)
        expect(response.body).to include('ニックネームを入力してください')
      end
    end
  end

  describe('GET /users/:id/edit') do
    context('ユーザーが存在する場合') do
      let(:user) { create(:user) }

      it('リクエストが成功すること') do
        get("/users/#{user.id}/edit")
        expect(response.status).to eq(200)
      end

      it('住所が表示されていること') do
        get("/users/#{user.id}/edit")
        expect(response.body).to include(user.address)
      end
    end

    context('ユーザーが存在しない場合') do
      it('エラーが発生すること') do
        expect { get('/users/1') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe('PUT /users/:id') do
    context('パラメーターが妥当な場合') do
      let(:user) { create(:user, nickname: 'eiji') }
      let!(:prefecture) { create(:prefecture) }

      it('リクエストが成功すること') do
        put("/users/#{user.id}", params: { user: attributes_for(:user, :valid, nickname: 'kurita') })
        expect(response.status).to eq(302)
      end

      it('ユーザーを更新できること') do
        expect { put("/users/#{user.id}", params: { user: attributes_for(:user, :valid, nickname: 'kurita') }) }.to change{ User.find(user.id).nickname }.from(user.nickname).to('kurita')
      end

      it('リダイレクトすること') do
        put("/users/#{user.id}", params: { user: attributes_for(:user, :valid, nickname: 'kurita') })
        expect(response).to redirect_to("/users/#{user.id}")
      end
    end

    context('パラメーターが不正な場合') do
      let(:user) { create(:user) }
      let(:invalid_params) { { user: attributes_for(:user, :invalid) } }

      it('リクエストが成功すること') do
        put("/users/#{user.id}", params: invalid_params)
        expect(response.status).to eq(200)
      end

      it('ユーザーが更新されないこと') do
        expect { put("/users/#{user.id}", params: invalid_params) }.not_to change{ User.find(user.id) }
      end

      it('エラーメッセージが表示されること') do
        put("/users/#{user.id}", params: invalid_params)
        expect(response.body).to include('ニックネームを入力してください')
      end
    end
  end

  describe('DELETE /users/:id') do
    context('ユーザーが存在する場合') do
      let!(:user) { create(:user) }

      it('リクエストが成功すること') do
        delete("/users/#{user.id}")
        expect(response.status).to eq(302)
      end

      it('ユーザーが削除されること') do
        expect { delete("/users/#{user.id}") }.to change(User, :count).by(-1)
      end

      it('ホーム画面にリダイレクトすること') do
        delete("/users/#{user.id}")
        expect(response).to redirect_to('/')
      end
    end

    context('ユーザーが存在しない場合') do
      it('エラーが発生する') do
        expect { delete('/users/1') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
