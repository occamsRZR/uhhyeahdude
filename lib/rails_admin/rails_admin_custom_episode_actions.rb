require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class DownloadEpisode < RailsAdmin::Config::Actions::Base
        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'fa fa-cloud-download'
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :controller do
          Proc.new do
            EpisodeDownloadWorker.perform_async(@object.slug)
            flash[:notice] = "Episode #{@object.number} was enqueued for download."
            redirect_to rails_admin.index_path('episode')
          end
        end
      end

      class CheckRSSFeed < RailsAdmin::Config::Actions::Base
        register_instance_option :collection do
          true
        end

        register_instance_option :link_icon do
          'fa fa-refresh'
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :controller do
          Proc.new do
            EpisodeDownloadWorker.perform_async(@object.slug)
            flash[:notice] = "Episode #{@object.number} was enqueued for download."
            redirect_to rails_admin.index_path('episode')
          end
        end
      end
    end
  end
end
