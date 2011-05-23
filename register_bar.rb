 require "rubygems"
require "win32/service"
   include Win32



   # Create a new service
   Service.create('some_service', nil,
      :service_type       => Service::WIN32_OWN_PROCESS,
      :description        => 'A custom service I wrote just for fun',
      :start_type         => Service::AUTO_START,
      :error_control      => Service::ERROR_NORMAL,
      :binary_path_name   => 'C:\RubySamples\bar.rb',
      :load_order_group   => 'Network',
      :dependencies       => ['W32Time','Schedule'],

      :display_name       => 'This is some service'
   )
Service.start("some_service")