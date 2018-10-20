## To Run this Recipe:

# install_filebeat 

## Custom CHEF JSON To Pass:

# {"application": "application_name"}


Replace application_name with your application or prosecutor template name.
For example if you set "reveal" then prosecutor template that would be taken is template/default/conf.d/reveal.yml.


## To Contribute

1. Copy templates/default/conf.d/application.yml.sample and rename it as your application_name.yml.
2. Provide your application log file path tagged with application and log type.