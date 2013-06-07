enable :sessions


get '/' do
  erb :index, :locals => {cells: Cell.all }
end

get '/refresh' do
  Cell.destroy_all
  redirect "/"
end

get '/check_victory' do
  if message = Cell.check_victory
    Cell.destroy_all
  end
  p "#{message}"
end

post '/' do
  Cell.create(coordinate: params['coordinate'], player: params[:player])
  erb :index
end
