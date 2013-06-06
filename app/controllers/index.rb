enable :sessions

get '/' do
  erb :index                                                                                                         
end

get '/refresh' do
  Cell.all.map(&:destroy)
  redirect "/"
end

get '/check_victory' do
  if message = Cell.check_victory
    Cell.all.map(&:destroy)
  end
  p "#{message}"
end

post '/' do
  Cell.create(coordinate: params['coordinate'], player: params[:player])
  erb :index
end
