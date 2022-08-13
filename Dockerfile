### Pull latest bgpalerter container from nttgin docker hub
FROM nttgin/bgpalerter:latest
### Copy our own prefix.yml file and config file to the docker image
### When drone builds this image and pushes it to ECR, it will contain our files (not the defaults)
COPY bgpalerter/YOUR_ASN_PREFIX_LIST.yml /opt/bgpalerter/volume/YOUR_ASN_PREFIX_LIST.yml
COPY bgpalerter/config.yml /opt/bgpalerter/volume/config.yml
### Slack webhook should not be committed in code. This script replaces the slackwebhook in config.yml with a tf var
COPY bgpalerter/slack-token-replace.sh /opt/bgpalerter/volume/slack-token-replace.sh

### open port 8011 for status checks
EXPOSE 8011