module Ruboty
  module HaikuWoYome
    module Actions
      class Haiku < Ruboty::Actions::Base
        def call
          haiku = haiku_list.sample || '「アイエエエエ！？」'
          message.reply(haiku)
        end

        private
        
        def client
          @client ||= Slack.client(token: ENV['SLACK_TOKEN'])
        end

        def haiku_list
          haiku_nodes = user_public_messages_text.inject([]) do |acc, message|
            haiku = haiku_reviewer.search(message)
            acc + haiku
          end

          haiku_nodes.map do |haiku_node|
            haiku_node.phrases.join
          end
        end

        def user_public_messages_text
          user_public_messages.select { |m| m['type'] != 'group' }.map { |t| t['text'] }
        end

        def user_public_messages
          search_result = client.search_messages(query: user_name, count: 1000)
          return [] if search_result.nil?
          return [] if search_result['messages'].nil? 
          search_result['messages']['matches']
        end

        def user_name
          name = message[:user_name]
          name = name.gsub(':', '')
          name.start_with?('@') ? name : "@#{name}"
        end

        def haiku_reviewer
          @reviewer ||= Ikku::Reviewer.new
        end
      end
    end
  end
end
