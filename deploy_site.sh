echo 'Building Jekyll Assets'
bundle exec jekyll build
echo 'Sourcing .env file'
source .env
echo 'Publishing to s3'
bundle exec s3_website push --verbose
