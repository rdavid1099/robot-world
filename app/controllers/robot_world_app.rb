class RobotWorldApp < Sinatra::Base

  get '/' do
    average_age = robot_world.average_age
    num_robots_created_this_year = robot_world.created_this_year.length

    erb :dashboard,
    :locals => {:average_age => average_age,
                :robots_created_this_year => num_robots_created_this_year}
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  get '/robots/new' do
    @states = SelectOptions.state_options
    @months = SelectOptions.month_options
    @days = SelectOptions.day_options
    @error = false
    erb :new
  end

  post '/robots' do
    if robot_world.valid_date?(params[:robo]) && robot_world.is_devil?(params[:robo])
      robot_world.create_robot_devil
      redirect '/robots'
    elsif robot_world.valid_date?(params[:robo])
      robot_world.add_robot(params[:robo])
      redirect '/robots'
    else
      redirect '/robots/new/date-error'
    end
  end

  get '/robots/:id' do
    @robot = robot_world.find_robot(params[:id])
    erb :show
  end

  get '/robots/:id/edit' do
    @robot = robot_world.find_robot(params[:id])
    @states = SelectOptions.state_options
    @months = SelectOptions.month_options
    @days = SelectOptions.day_options
    @error = false
    erb :edit
  end

  get '/robots/:id/edit/date-error' do
    @robot = robot_world.find_robot(params[:id])
    @states = SelectOptions.state_options
    @months = SelectOptions.month_options
    @days = SelectOptions.day_options
    @error = true
    erb :edit
  end

  put '/robots/:id' do
    if robot_world.valid_date?(params[:robo])
      robot_world.change_robot_information(params[:id], params[:robo])
      redirect "/robots/#{params[:id]}"
    else
      redirect "/robots/#{params[:id]}/edit/date-error"
    end
  end

  delete '/robots/:id' do
    robot_world.terminate_robot(params[:id])
    redirect '/robots'
  end

  get '/robots/new/date-error' do
    @states = SelectOptions.state_options
    @months = SelectOptions.month_options
    @days = SelectOptions.day_options
    @error = true
    erb :new
  end

  def robot_world
    if ENV['RACK_ENV'] == "test"
      database = SQLite3::Database.new('db/robot_world_test.db')
    else
      database = SQLite3::Database.new('db/robot_world_development.db')
    end
    database.results_as_hash = true
    @robot_world ||= RobotWorld.new(database)
  end
end
