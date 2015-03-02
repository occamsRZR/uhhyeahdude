RailsAdmin.config do |config|
  
  Dir["#{Rails.root}/lib/rails_admin/*.rb"].each {|file| require file }

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  module RailsAdmin
    module Config
      module Actions
        class DownloadEpisode < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
        class CheckRSSFeed < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end
  
  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    check_rss_feed
    
    download_episode do
      only 'Episode'
    end
    
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
