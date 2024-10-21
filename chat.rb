require "openai"
require "dotenv/load"



puts "Hello! How can I help you today?"
puts "-" * 50
client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
message_list = [
    {
        "role" => "system",
        "content" => "You are a helpful assistant who talks like Severus Snape."
    }
  ]

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

  user_input = gets.chomp

end





message_list.push({
    "role" => "user",
    "content" => "And how about shawarma?"
  })

  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
  
pp api_response.fetch("choices").at(0).fetch("message")

puts "-" * 50
