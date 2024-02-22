class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  private
  # アクティブであるかを判断するメソッド
    def customer_state
       # 【処理内容1】 入力されたemailからアカウントを1件取得
      customer = Customer.find_by(email: params[:customer][:email])
       # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
      return if customer.nil?
       # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
      return unless customer.valid_password?(params[:customer][:password])
       # 【処理内容4】 アクティブでない会員に対する処理
      unless customer.active?
       # アカウントが無効な場合にログインを拒否し、エラーメッセージを表示
        flash[:alert] = "ログインに失敗しました"
        redirect_to new_customer_session_path and return
      end
    end
end
