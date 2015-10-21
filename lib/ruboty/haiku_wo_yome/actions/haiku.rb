module Ruboty
  module HaikuWoYome
    module Actions
      class Haiku < Ruboty::Actions::Base
        def call(options = {type: :haiku})
          list = case options[:type]
                 when :tanka
                   tanka_list
                 else
                   haiku_list
                 end
          haiku = list.sample || '「アイエエエエ！？」'
          message.reply(haiku)
        end

        private
        
        def client
          @client ||= Slack.client(token: ENV['SLACK_TOKEN_FOR_SEARCH'])
        end

        def haiku_list
          user_public_messages_text.inject([]) do |acc, message|
            haiku_reviewer.search(message).each do |node|
              acc << node.phrases.join
            end
            acc
          end
        end

        def tanka_list
          kaminoku_nodes = user_public_messages_text.inject([]) do |acc, message|
            haiku_reviewer.search(message).each do |node|
              acc << node.phrases.join
            end
            acc
          end

          reset!
          shimonoku_nodes = user_public_messages_text.inject([]) do |acc, message|
            haiku_reviewer(rule: [7, 7]).search(message).each do |node|
              acc << node.phrases.join
            end
            acc
          end

          return [] if shimonoku_nodes.empty?

          kaminoku_nodes.map do |kaminoku|
            "#{kaminoku}  #{shimonoku_nodes.sample}"
          end
        end

        def user_public_messages_text
          @public_messages ||= user_public_messages.select { |m| m['type'] != 'group' }.map { |t| t['text'] }
        end

        def user_public_messages
          query = nil
          begin
            query = "from:#{user_name}"
          rescue
            query = search_word
          end
          puts query
          search_result = client.search_messages(query: query, count: 1000)
          return [] if search_result.nil?
          return [] if search_result['messages'].nil? 
          search_result['messages']['matches']
        end

        def user_name
          name = message[:user_name]
          name = name.gsub(':', '')
          name.start_with?('@') ? name : "@#{name}"
        end

        def search_word
          message[:search_word]
        end

        def haiku_reviewer(options = {})
          rule = options[:rule] || [5, 7, 5]
          @reviewer ||= Ikku::Reviewer.new(rule: rule)
        end

        def reset!
          @reviewer = nil
        end
      end
    end
  end
end
