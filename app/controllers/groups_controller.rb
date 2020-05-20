class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :set_organizer]
  before_action :check_organizer, only: [:show, :set_organizer]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    group_member_ids = @group.join_groups.map {|x| x.member_id}
    @not_belong_members = Member.all.where.not(id: group_member_ids)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_organizer
    @group_members = @group.join_group_members
    next_organizer_id = @group_members.random

    if @group_members.count <= 1 && @organizer_id == next_organizer_id
      redirect_to @group, notice: t('groups.set_organizer.not_enough_members') and return
    elsif @organizer_id.present?
      while @organizer_id == next_organizer_id
        next_organizer_id = @group_members.random
      end
      @group.join_groups.find_by(member_id: @organizer_id ).update(organizer: false)
    end
    @group.join_groups.find_by(member_id: next_organizer_id ).update(organizer: true)
    redirect_to @group, notice: t('groups.set_organizer.success') and return
  end

  def check_organizer
    if @group.join_groups.find_by(organizer: true).present?
      @organizer_id = @group.join_groups.organizer_id
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
