class RelationshipsController < ApplicationController
  before_action :authenticate_user! #ログインしていない場合はログイン画面へリダイレクト
  def create
    user = User.find(params[:user_id]) #フォロー対象のユーザー特定
    current_user.follow(user) #現在のログインユーザーがそのユーザーをフォロー
    redirect_to request.referer #リダイレクト先を元のページに戻す
  end
  
  def destroy
    user = User.find(params[:user_id]) #フォロー解除対象のユーザーを特定
    current_user.unfollow(user) #現在のログインユーザーががそのユーザーのフォローを解除
    redirect_to  request.referer #リダイレクト先を元のページに戻す
  end
  
  def followings #特定のユーザーがフォローしているユーザーの一覧を表示するためのアクション
    user = User.find(params[:user_id]) #対象のユーザーを特定
    @users = user.followings #そのユーザーがフォローしているユーザー（user.followings）を@usersに代入
  end
  
  def followers #特定のユーザーをフォローしているユーザーの一覧を表示するためのアクション
    user = User.find(params[:user_id]) #対象のユーザーを特定
    @users = user.followers #そのユーザーをフォローしているユーザー（user.followers）を@usersに代入
  end
end
