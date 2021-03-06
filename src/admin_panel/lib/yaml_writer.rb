#--
# WebROaR - Ruby Application Server - http://webroar.in/
# Copyright (C) 2009  Goonj LLC
#
# This file is part of WebROaR.
#
# WebROaR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# WebROaR is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with WebROaR.  If not, see <http://www.gnu.org/licenses/>.
#++

module YAMLConfig
  CONFIG = 1
  USER = 2
  SMTP = 3
  SENDMAIL = 4
end

class YAMLWriter
  
  class << self
    #This method is to write the data into the yaml file.
    #The method is used to write config.yml as well as user.yml file.  
    def write(hash, file_path, type)
      yaml_obj = YAML::dump(hash)
      file = File.open(file_path,"w")
      if type == YAMLConfig::CONFIG
        header_string = get_header()
        file.puts(header_string)
      end
      file.puts(yaml_obj)
      file.close
    end
  
    private
    #This method is to add instructions and example at the begin of the config.yml file.
    def get_header
      return "######################################################################################
#                             WebROaR Configuration file                               
######################################################################################

######################################################################################
# Configuration file has three YAML formatted components
# Order of components does not matter.
#   a) Server Specification
#        Elements:
#          1) Server Port(optional)(default port = 3000)
#          2) Minimum number of workers(optional)(default min_worker = 4)
#          3) Maximum number of workers(optional)(default max_worker = 8)
#          4) Logging level(optional)(default log_level = SEVERE)
#          5) SSL Specification(optional)
#             It defines SSL specification.
#             Parameters:
#               I) SSL Support(optional)(values must be 'enabled' or 'disabled'(default))
#              II) SSL Certificate File(optional)(Path to SSL certificate file. Default is empty)
#             III) SSL Key File(optional)(Path to SSL key file. Default is empty)
#              IV) SSL Port(optional)(Default port number 443) 
#          6) Access log(optional)(values must be 'enabled'(default) or 'disabled')
#        Order of the above elements does not matter.
#        Example:
#          Server Specification:
#            port: 3000
#            min_worker: 4
#            max_worker: 8
#            log_level: SEVERE
#            access_log: enabled
#            SSL Specification:
#              ssl_support: enabled
#              certificate_file: /home/smartuser/ca-cert.pem
#              key_file: /home/smartuser/ca-key.pem
#              ssl_port: 443
#                                     
#   b) Application Specification (optional)
#        Elements:
#          1) Application name(mandatory)
#          2) Application baseuri(optional)
#          3) Application path(mandatory)
#          4) Application type(mandatory)(example rails or rack)
#          5) Application environment(optional)(default environment = production)
#          6) Application analytics(mandatory)(values must be 'enabled' or 'disabled')
#          7) Minimum number of workers(optional)(default is 'Server Specification/min_worker')
#          8) Maximum number of workers(optional)(default is 'Server Specification/max_worker')
#          9) Logging level(optional)(default is 'Server Specification/log_level')
#         10) Run as user (mandatory)
#         11) Hostnames(optional)
#         12) Environment Variable(optional)
#             It defines list of environment variables which can be used in the deployed application. It take following parameter.
#             Value is key-value pair separated by equal sign('=') e.g. LOG_DIR=/var/log/webroar
#        Order of the above elements does not matter.
#        Base-uri 'admin-panel' is reserved for 'Admin Panel'.
#        Either host_names or baseuri(not both) must present to resolve HTTP request.
#        Hostnames can have multiple values, each separated by spaces.(e.g. host_names: server.com server.co.in)
#        Hostnames can be defined using wildcard(*), but wildcard can only be at start of name or at end of name (valid hostnames are (i) *.server.com (ii) www.server.* (iii) *.server.*).
#        Prefix Hostname with tilde(~), if wildcard is used in defining Hostname. e.g. (i) ~*.server.com  (ii) ~www.server.*  (iii) ~*.server.* 
#        Example with baseuri:
#          Application Specification:
#            - name: Mephisto
#              baseuri: /blog
#              path: /home/smartuser/work/rails_workspace/mephisto
#              type: rails
#              run_as_user: smartuser
#              analytics: enabled
#              environment: production
#              min_worker: 2
#              max_worker: 5
#              log_level: SEVERE
#              environment_variables: 
#                - LOG_DIR=/var/log/webroar
#                - TMP_DIR=/tmp
#        Example with host_names:
#          Application Specification:
#            - name: Mephisto
#              host_names: myblog.com ~*.myblog.com
#              path: /home/smartuser/work/rails_workspace/mephisto
#              type: rails
#              run_as_user: smartuser
#              analytics: enabled
#              environment: production
#              min_worker: 2
#              max_worker: 5
#              log_level: SEVERE
#              environment_variables: 
#                - set_env: LOG_DIR=/var/log/webroar
#                - set_env: TMP_DIR=/tmp
#
#  (c) Headers (optional)
#        It allows adding or changing the Expires and Cache-Control in the response headers for static assets (e.g. *.js, *.gif etc). 
#        Elements:
#          1) Expires header for all static assets (optional) (default is 'off')
#          2) Specific expires header for specific file types (optional)
#             Elements:
#                I) File Extensions(mandatory)
#               II) Expires value(mandatory) (No of seconds)
#        Possible value for expires is off or no. of seconds. 
#        Example:
#          Headers:
#            expires: 3600
#            expires_by_type:
#            - ext: png, jpg, gif
#              expires: 31536000
#
#  (d) Encoding (optional)
#        It allows (deflate) encoding of static assets.
#        Elements:
#          1) Regex value for supported Content-Type (optional) (default is 'javascript|css|text|xml')
#          2) Regex value for supported Used-Agent (optional) (default is '.*')
#          3) Range of Content-Length (optional)
#             Elements:
#                I) Lower limit of Content-Length (optional) (default is 10240 i.e. 10KB) 
#               II) Upper limit of Content-Length (optional) (default is 1048576 i.e. 1MB)
#        Example:
#          Encoding:
#            Content-Type: text|xml|javascript
#            User-Agent: .*
#            Size Limit:
#              lower_limit: 10240
#              upper_limit: 1048576
#
######################################################################################"
    end
  end
  
end #end YAMLWriter
