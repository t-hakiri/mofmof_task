class JoinGroupsController < ApplicationController
  before_action :set_group, only: %i[create destroy]
  before_action :set_member, only: %i[create destroy]

  def create
    if @group.join_group_members.find_by(id: @member)
      redirect_to @group, notice: "#{@member.name}"+t('join_groups.create.participating')
    else
      @group.join_groups.create(member_id: @member.id)
      redirect_to @group, notice: "#{@member.name}"+t('join_groups.create.success')
    end
  end

  def destroy
    @join_group = JoinGroup.find_by(group_id: @group, member_id: @member)
    if @member.id == @join_group.member_id
      @join_group.destroy
      redirect_to @group, notice: "#{@member.name}"+t('join_groups.destroy.success')
    else
      redirect_to @group, notice: t('join_groups.destroy.error')
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
