class String
	def red
		"\033[31m#{self}\033[0m"
	end
end

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
                                		# selects key from the hash that matches the imput
  /#{key}/ =~ input
  													# creates a regex from the input
  response = RESPONSES[key]
  p "bot =>".red											# sets variable 'response' which equates to the value matching the key in the hash
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2}			# (if) response.nil? (than return) ? 'sorry?' (else): match you word($1) with regex in RESPONSES[key]value 
end


RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
              'I play the guitar' => 'I cannot play an instrument',
              'what are you' => 'I\'m a computer',
              'do you like (.*)' => 'I love %{c1}',
              'my favourite film is (.*)' => '%{c1} is my favourite too',
              'the sky is blue' => 'Yes it is' }


puts "Hello, what's your name?"
name = gets.chomp
puts "Hello #{name}"
name_prompt = name + '=>'

while(p name_prompt + input = gets.chomp) do
  exit if input == "quit" 
  puts get_response(input)
end


# p get_response("I love music")



# add at least five more responses so that the bot has a bigger range of conversation
# add at least another two more responses that use regex capture groups - that's the %{c1} being replaced with whatever matched the brackets (.*) in the regular expression. In Ruby regex capture groups are stored in $1, $2 etc after a regex match takes place
# extend the bot so that there is a key word, e.g. "quit" that will end the session
# add a prompt in front of each sentence to indicate if either the person or the bot is talking
# make the bot and the person's chat different colours
# extend the bot so that it can handle more than two regular expression capture groups
# extend the bot to that the user can add new kinds of responses through the chat interaction
# extend the bot so that the set of responses is saved to a file and reloaded when the bot restarts