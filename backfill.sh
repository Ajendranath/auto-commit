#!/bin/bash

# GitHub Contribution Graph Backfiller
# Run this ONCE locally inside your auto-commit repo
# It creates 1-4 commits per day for the past 365 days

git config user.email "ajendratripathi8@gmail.com"
git config user.name "Ajendranath"

START_DATE=$(date -d "365 days ago" +%Y-%m-%d)
END_DATE=$(date -d "yesterday" +%Y-%m-%d)

current="$START_DATE"

while [[ "$current" < "$END_DATE" || "$current" == "$END_DATE" ]]; do

  # Random number of commits per day (1 to 4) for natural look
  num_commits=$(( RANDOM % 4 + 1 ))

  for (( i=1; i<=num_commits; i++ )); do
    # Random hour between 9am and 11pm
    hour=$(( RANDOM % 14 + 9 ))
    minute=$(( RANDOM % 60 ))
    second=$(( RANDOM % 60 ))

    COMMIT_DATE="${current}T$(printf '%02d' $hour):$(printf '%02d' $minute):$(printf '%02d' $second)"

    echo "activity on $COMMIT_DATE" >> activity.log

    git add activity.log

    GIT_AUTHOR_DATE="$COMMIT_DATE" \
    GIT_COMMITTER_DATE="$COMMIT_DATE" \
    git commit --date="$COMMIT_DATE" -m "chore: daily log update" --quiet

  done

  # Move to next day
  current=$(date -d "$current + 1 day" +%Y-%m-%d)

done

echo ""
echo "Done! Now run: git push"
echo "Your graph will go green within a few minutes."