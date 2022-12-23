class SchedulesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @schedules = Schedule.all.order(sort_column + ' ' + sort_direction)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash[:notice] = "スケジュール#{@schedule.id}を新規登録しました"
      redirect_to :schedules
    else
      render "new"
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] = "スケジュール#{@schedule.id}を更新しました"
      redirect_to :schedules
    else
      render "edit"
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to :schedules
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_date, :end_date, :all_day, :memo)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Schedule.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
end
