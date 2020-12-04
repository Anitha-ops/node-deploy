## Script to generate a JSON file which the healthcheck endpoint can retrieve

# get the short version of the hash of the last commit
commit=$(git rev-parse --short HEAD)

# get the last commit time and format
lastCommitTime=$(git log -1 --date=local --pretty=format:%cd)
relativeTime=$(git log -1 --date=local --pretty=format:%cr)

# store in a json structure and write to a file, the graphQL resolver for "Version" will access this file
json=$(printf '{
"commit": "%s",
"lastCommitTime": "%s",
"relativeTime": "%s"
}' "$commit" "$lastCommitTime" "$relativeTime")

printf "$json" > '../../version.json'

