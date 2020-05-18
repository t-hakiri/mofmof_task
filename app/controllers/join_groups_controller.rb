class JoinGroupsController < ApplicationController
  before_action :set_group, only: :create
  before_action :set_member, only: :create

  def create
    if @group.join_group_members.find_by(id: @member)
      flash[:warning] = "#{@member.name}さんは参加済です"
      redirect_to @group
    else
      @group.join_groups.create(member_id: @member.id)
      flash[:warning] = "#{@member.name}さんがグループへ加入しました"
      redirect_to @group
    end
  end

  def destroy
    @join_group = JoinGroup.find(params[:id])
    if current_member.id == @join_group.member_id
      @join_group.destroy
      flash[:success] = 'グループを脱退しました。'
      redirect_to groups_path
    else
      flash[:danger] = '不正な値が入力されました。'
      redirect_to groups_path
    end
  end
  
  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end

  def group_params
    params.require(:join_group).permit(:group_id)
  end
end
