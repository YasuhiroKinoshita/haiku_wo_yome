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
