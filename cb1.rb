require 'colorize'

RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*) and (.*)' => 'I love %{c1} and %{c2} but I hate %{c3}',
              'I play the guitar' => 'I cannot play an instrument',
              'what are you' => 'I\'m a computer',
              'do you like (.*)' => 'I love %{c1}',
              'my favourite film is (.*)' => '%{c1} is my favourite too',
              'the sky is blue' => 'Yes it is' }

def say(message)
  puts "bot:   ".colorize(:red) + message
end

def wait_for_user
  print "user:  ".colorize(:green)
  gets.chomp
end

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample	
  /#{key}/ =~ input	
  response = RESPONSES[key]
  print @bot
  if response.nil? 
  	'sorry?'
  else response % { c1: $1, c2: $2, c3: $3}
  end
end

def add_response
	say ("what question would you like to add?")
	input = wait_for_user
	say ("what should the response be?")
	output = wait_for_user
	RESPONSES[input] = output
end

def save_file
  File.open("responses.csv", "w") do |file|
    RESPONSES.each do |key,value|
      responses_data = [key, value]
      csv_line = responses_data.join(",")
      file.puts csv_line
    end
  end
end

@bot = "bot:   ".colorize(:red)
say ("Talk to me! If you would like to add more expressions just type 'add', or type 'quit' to quit!")
say ("Hello, what's your name?")
name = wait_for_user
say ("Hello #{name}")
input = wait_for_user
while input != 'quit' do
  puts get_response(input)
  input = wait_for_user
  if input == 'add'
  	add_response
  	input = wait_for_user
  elsif input == 'save'
    save_file
    puts "saved"
    input == wait_for_user
  end
end



# add at least five more responses so that the bot has a bigger range of conversation
# add at least another two more responses that use regex capture groups - that's the %{c1} being replaced with whatever matched the brackets (.*) in the regular expression. In Ruby regex capture groups are stored in $1, $2 etc after a regex match takes place
# extend the bot so that there is a key word, e.g. "quit" that will end the session
# add a prompt in front of each sentence to indicate if either the person or the bot is talking
# make the bot and the person's chat different colours
# extend the bot so that it can handle more than two regular expression capture groups
# extend the bot so that the user can add new kinds of responses through the chat interaction
# extend the bot so that the set of responses is saved to a file and reloaded when the bot restarts

