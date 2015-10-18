require 'ruboty/haiku_wo_yome/actions/haiku'

module Ruboty
  module Handlers
    class Haiku < Ruboty::Handlers::Base
      env 'SLACK_TOKEN', 'Slack token'

      on('(?<user_name>.+) ハイクを詠め', name: :haiku_wo_yome, description: 'カイシャクしてやる', all: true)

      def haiku_wo_yome(message)
        Ruboty::HaikuWoYome::Actions::Haiku.new(message).call
      end
    end
  end
end
