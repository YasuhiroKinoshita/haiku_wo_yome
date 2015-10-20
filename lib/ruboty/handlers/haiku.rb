require 'ruboty/haiku_wo_yome/actions/haiku'

module Ruboty
  module Handlers
    class Haiku < Ruboty::Handlers::Base
      env 'SLACK_TOKEN_FOR_SEARCH', "Slack token for search api (important: bot user can't call search api! require human api key"

      on('(?<user_name>.+) ハイクを詠め', name: :haiku_wo_yome, description: 'カイシャクしてやる', all: true)
      on('(?<user_name>.+) タンカを詠め', name: :tanka_wo_yome, description: 'カイシャクしてやる', all: true)

      def haiku_wo_yome(message)
        Ruboty::HaikuWoYome::Actions::Haiku.new(message).call
      end

      def tanka_wo_yome(message)
        Ruboty::HaikuWoYome::Actions::Haiku.new(message).call(type: :tanka)
      end
    end
  end
end
