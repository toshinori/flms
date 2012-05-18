require 'spec_helper'
require 'shared_examples'

describe GameGoalsController do
  before (:each) do
    @valid_attributes = attributes_for(:game_goal_base)
    @valid_session = {}
  end

  describe "GET 'new'" do
    context 'when send valid params' do
      before do
        @game_team_id = create(:game_team_home).id
        create_list(:game_member_player, 3, {game_team_id: @game_team_id})
        @players = GameMember.find_all_by_game_team_id(@game_team_id)
        xhr :get, :new, {game_team_id: @game_team_id}, @valid_session
      end

      describe 'assings' do
        it { should assign_to(:game_goal).with_kind_of(GameGoal) }

        it { should assign_to(:game_team_id) }
        describe 'game_team_id' do
          subject { assigns(:game_team_id).to_i }
          it { should  == @game_team_id }
        end

        it { should assign_to(:players) }
        describe 'players' do
          subject { assigns(:players) }
          it { should == @players }
        end
      end

      it_behaves_like :valid_js_response, :new
    end
    context 'when set invalid params' do
      context 'game_team_id not exits' do
        before do
          xhr :get, :new, {game_team_id: GameTeam.maximum(:id) + 1}
        end
        it_behaves_like :redirected_to_page_not_found
      end
    end

  end

  describe "POST 'create'" do
    context 'when send valid params' do
      before do
        @send_params = attributes_for(:game_goal_base)
        @player = GameMember.find(@send_params[:game_member_id])
        @count = GameGoal.find_all_by_game_member_id(@player.id).size
        xhr :post, :create, { game_goal: @send_params, game_team_id: @player.team.id }, @valid_session
      end

      it 'record count 1 up' do
        goal_count = GameGoal.find_all_by_game_member_id(@player.id).size
        goal_count.should === (@count + 1)
      end

      it_behaves_like :valid_js_response, :create
    end

    context 'when send invalid params' do

      before do
        @send_params = attributes_for(:game_goal_base)
        @player = GameMember.find(@send_params[:game_member_id])
        @game_team_id = @player.team.id
        create_list(:game_member_player, 3, {game_team_id: @game_team_id})
        @players = GameMember.find_all_by_game_team_id(@game_team_id)
        @send_params[:game_member_id] = nil
        xhr :post, :create, { game_goal: @send_params, game_team_id: @game_team_id }, @valid_session
      end

      describe 'assigns' do
        it { should assign_to(:game_goal).with_kind_of(GameGoal) }

        it { should assign_to(:game_team_id) }
        describe :game_team_id do
          subject { assigns(:game_team_id).to_i }
          it { should === @game_team_id }
        end

        it { should assign_to(:players) }
        describe :players do
          subject { assigns(:players) }
          it { should ===  @players }
        end
      end

      it_behaves_like :valid_js_response, :new
    end

  end
  describe "DELETE 'destroy'" do
    context 'when send valid params' do
      before do
        @target = create(:game_goal_base)
        @count = GameGoal.count
        xhr :delete, :destroy, {id: @target.id}, @valid_session
      end

      it_behaves_like :valid_js_response, :destroy

      it "record count 1 down" do
        GameGoal.count.should == (@count - 1)
      end
    end

    context 'when send invalid params' do
      before do
        xhr :delete, :destroy, {id: (GameGoal.maximum(:id).to_i + 1)}, @valid_session
      end
      describe 'reponse' do
        context 'id not exits' do
          it_behaves_like :redirected_to_page_not_found
        end
      end

    end
  end
end
