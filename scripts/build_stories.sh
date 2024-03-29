#!/usr/bin/sh
#
# Build all stories

OUTPUT_DIRECTORY=public
STORIES_DIRECTORY=stories
INDEX_HTML='<!DOCTYPE html>
<html>
<head>
  <title>Directory of stories</title>
</head>
<body>
<ul>'

mkdir -p $OUTPUT_DIRECTORY
find $OUTPUT_DIRECTORY -type f -exec rm {} +

for STORY_FILENAME in `ls "$STORIES_DIRECTORY"`; do
  STORY_ID=`echo "$STORY_FILENAME" | cut -d. -f1`
  STORY_FILE="$STORIES_DIRECTORY/$STORY_FILENAME"
  STORY_TITLE=`sed -n '/:: StoryTitle/{n;p;}' "$STORY_FILE"`

  scripts/run_tweego.sh -o "$OUTPUT_DIRECTORY/$STORY_ID.html" "$STORY_FILE"

  INDEX_HTML="$INDEX_HTML
    <li><a href='./$STORY_ID.html'>$STORY_TITLE</a></li>"
done

INDEX_HTML="$INDEX_HTML
</ul>
</body>
</html>"

echo "$INDEX_HTML" > "$OUTPUT_DIRECTORY/index.html"
