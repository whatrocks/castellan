#!/bin/bash

# edit these to your liking
PODCAST_TITLE="Castellan - Frankenstein"
PODCAST_AUTHOR="Castellan"
CATEGORY="Technology"
GENERATOR="Castellan"
LINK="https://whatrocks.github.io/castellan/"
IMG="https://whatrocks.github.io/castellan/showart.jpg"

# automatic
CURRENT_DATE=$(date -R)
echo "current date is $CURRENT_DATE"

# order
EPS=(
  intro
  letter-1
  letter-2
  letter-3
  letter-4
  chapter-1
  chapter-2
  chapter-4
  chapter-3
  chapter-5
  chapter-6
  chapter-7
  chapter-8
  chapter-9
  chapter-10
  chapter-11
  chapter-12
  chapter-13
  chapter-14
  chapter-15
  chapter-16
  chapter-17
  chapter-18
  chapter-19
  chapter-20
  chapter-21
  chapter-22
  chapter-23
  chapter-24
  license
)

read -d '' feed << EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
  <channel>
    <title>$PODCAST_TITLE</title>
    <link>$LINK</link>
    <description>$PODCAST_TITLE ($CURRENT_DATE)</description>
    <category>$CATEGORY</category>
    <generator>$GENERATOR</generator>
    <language>en-us</language>
    <lastBuildDate>$CURRENT_DATE</lastBuildDate>
    <pubDate>$CURRENT_DATE</pubDate>
    <itunes:author>$PODCAST_AUTHOR</itunes:author>
    <itunes:subtitle>$PODCAST_TITLE</itunes:subtitle>
    <itunes:summary><![CDATA[$PODCAST_TITLE ($CURRENT_DATE)]]></itunes:summary>
    <itunes:image href="$IMG"/>
    <itunes:explicit>no</itunes:explicit>
    <itunes:category text="$CATEGORY"></itunes:category>
EOF

echo $feed

COUNT=1
for episode in ${EPS[@]}; do
  echo "processing $episode..."
  MP3_FILE="book/pieces/mp3/$episode.mp3"
  MP3_SIZE="$(wc -c <"$MP3_FILE")"
  UUID=$(uuidgen)
  NEXT_DATE=$(date -R)
  DURATION="$(ffprobe -show_entries stream=duration -of compact=p=0:nk=1 -v fatal $MP3_FILE)"
  read -d '' next << EOF
  <item>
      <guid>$UUID</guid>
      <title>$episode</title>
      <link>$LINK$MP3_FILE</link>
      <description>$PODCAST_TITLE: $episode</description>
      <pubDate>$NEXT_DATE</pubDate>
      <enclosure url="$LINK$MP3_FILE" length="$MP3_SIZE" type="audio/mpeg"></enclosure>
      <itunes:author>$PODCAST_AUTHOR</itunes:author>
      <itunes:subtitle>$episode</itunes:subtitle>
      <itunes:summary>Audio generated from the text of this chapter</itunes:summary>
      <itunes:image href="$IMG"></itunes:image>
      <itunes:duration>$DURATION</itunes:duration>
      <itunes:explicit>no</itunes:explicit>
      <itunes:order>$COUNT</itunes:order>
    </item>
EOF
  feed="${feed}${next}"
  COUNT=$((COUNT+1))
done


END="</channel></rss>"

echo $feed$END | tee rss.xml