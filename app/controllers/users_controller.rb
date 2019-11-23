class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]

  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены'  if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены'  if current_user.present?
    @user = User.new(user_params)

    # Делаем проверку
    if @user.save
      # Если удачно, отправляем пользователя на главную с помощью метода redirect_to
      # с сообщением
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def destroy
    # session[:user_id] = nil
    @user.destroy
    reset_session
    redirect_to root_url, notice: 'Пользователь удален'
  end

  def edit

  end

  def update

    # Делаем проверку
    if @user.update(user_params)
      # Если удачно, отправляем пользователя на главную с помощью метода redirect_to
      # с сообщением
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    # берём вопросы у найденного юзера
    @questions = @user.questions.order(created_at: :desc)

    # Для формы нового вопроса создаём заготовку, вызывая build у результата вызова метода @user.questions.
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    # защищаем от повторной инициализации с помощью ||=
    @user ||= User.find params[:id]
  end

  def user_params
  # берём объект params, потребуем у него иметь ключ
  # :user, у него с помощью метода permit разрешаем
  # набор инпутов. Ничего лишнего, кроме них, в пользователя не попадёт
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
