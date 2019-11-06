class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Делаем проверку
    if @user.save
      # Если удачно, отправляем пользователя на главную с помощью метода redirect_to
      # с сообщением
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @new_question = @user.questions.build
    @questions = @user.questions.to_a.select(&:persisted?)

  end

  private
  def user_params
  # берём объект params, потребуем у него иметь ключ
  # :user, у него с помощью метода permit разрешаем
  # набор инпутов. Ничего лишнего, кроме них, в пользователя не попадёт
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
