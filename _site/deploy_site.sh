echo 'Building Jekyll Assets'
jekyll build
echo 'Sourcing .env file'
source .env
echo 'Publishing to s3'
s3_website push
