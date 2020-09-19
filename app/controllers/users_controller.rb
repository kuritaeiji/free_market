class UsersController < ApplicationController
  before_action(:set_user, only: [:show, :edit, :update, :destroy])
  before_action(:set_prefectures, only: [:new, :create, :edit, :update])

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    binding.pry
    if @user.save
      flash[:success] = '認証メールを送信しました。'
      redirect_to(root_url)
    else
      render('new')
    end
  end

  def edit
  end

  def update
    if @user.update(update_user_params)
      flash[:success] = 'ユーザー情報を更新しました。'
      redirect_to(@user)
    else
      render('edit')
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to(root_url)
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :image,
        :nickname, :family_name, :first_name, :postal_code, :prefecture_id, :address)
    end

    def update_user_params
      params.require(:user).permit(:image, :nickname, :family_name, :first_name, :postal_code, :prefecture_id, :address)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_prefectures
      @prefectures = Prefecture.all
    end
end
