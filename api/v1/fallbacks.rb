not_found do
  { error: 'These are uncharted waters...'}.to_json
end

error do
  { error: 'Whoops! Something wierd happened'}.to_json
end
