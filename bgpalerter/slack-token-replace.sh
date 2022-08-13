### This script is whats started on the docker container. First we replace the slackwebhook then start bgpalerter service
### Call SLACK_API_TOKEN from tf env variable which is stored in AWS Param Store
ESCAPED_REPLACE=$(printf '%s\n' "$SLACK_API_TOKEN" | sed -e 's/[\/&]/\\&/g')
/bin/sed -i "s/slacktokentobereplaced/$ESCAPED_REPLACE/g" /opt/bgpalerter/volume/config.yml
/bin/cat /opt/bgpalerter/volume/config.yml
/usr/local/bin/npm run serve -- --d /opt/bgpalerter/volume/