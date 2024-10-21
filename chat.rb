require "openai"
require "dotenv/load"


#bu hello kismini da loop'a koymak istemis
puts "Hello! How can I help you today?"
puts "-" * 50
client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
message_list = [
    {
        "role" => "system",
        "content" => "You are a helpful assistant."
    }
  ]

#cozumde bunu "" olarak initialize ediyor, sonra while loopta hello ve input alip sonra if bye degilse o zaman calistiriyor 
user_input = gets.chomp

while user_input != "bye"
  # Prepare an Array of previous messages


  message_list.push({ 
    "role" => "user",
    "content" => user_input
  })

  # Call the API to get the next message from GPT
  api_response = client.chat(
  parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
  }
  )

  next_message = api_response.fetch("choices").at(0).fetch("message")
  message_list.push(next_message)
  puts next_message.fetch("content")
  puts "-" * 50
  
  user_input = gets.chomp

end
