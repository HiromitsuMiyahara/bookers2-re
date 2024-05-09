class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model] #ユーザーが選択した検索対象のモデル（"user" または "book"）を @model 変数に代入
    @content = params[:content] #ユーザーが入力した検索キーワードを @content 変数に代入
    @method = params[:method] #ユーザーが選択した検索方法（"perfect"、"forward"、"backward"、"partial"）を @method 変数に代入

    # 選択したモデルに応じて検索を実行
    if @model == "user"
      @records = User.search_for(@content, @method)
    else
      @records = Book.search_for(@content, @method)
    end
  end
end
