class MembersController < ApplicationController

  before_filter do |c|
    @member_types = Member.member_type_for_select
  end

  # GET /teams
  # GET /teams.json
  def index
    @members = Member.all
    respond_to do |format|
      format.html
    end
  end

  # GET /member/new
  # GET /member/new.json
  def new
    @member = Member.new
    respond_to do |format|
      format.html
    end
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])
    respond_to do |format|
      if @member.save
        format.html { redirect_to members_url, notice: 'member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to members_url, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

end
