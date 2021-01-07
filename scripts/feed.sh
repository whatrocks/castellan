#!/bin/bash

# edit these to your liking
PODCAST_TITLE="Castellan - Frankenstein"
PODCAST_AUTHOR="Castellan"
CATEGORY="Technology"
GENERATOR="Castellan"
LINK="https://whatrocks.github.io/castellan/"
IMG="https://whatrocks.github.io/castellan/frankenstein.png"

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

BEGIN="""<?xml version="1.0" encoding="UTF-8"?>
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
    <image>
      <url>$IMAGE</url>
      <title>$PODCAST_TITLE</title>
      <link>$LINK</link>
    </image>
    <itunes:author>$PODCAST_AUTHOR</itunes:author>
    <itunes:subtitle>$PODCAST_TITLE</itunes:subtitle>
    <itunes:summary><![CDATA[$PODCAST_TITLE ($CURRENT_DATE)]]></itunes:summary>
    <itunes:image href="$IMAGE"></itunes:image>
    <itunes:explicit>no</itunes:explicit>
    <itunes:category text="$CATEGORY"></itunes:category>
"""
COUNT=1
for episode in ${EPS[@]}; do
  echo "processing $episode..."
  MP3_FILE="book/pieces/mp3/$episode.mp3"
  MP3_SIZE="$(wc -c <"$MP3_FILE")"
  UUID=($uuidgen)
  DURATION="$(ffprobe -show_entries stream=duration -of compact=p=0:nk=1 -v fatal $MP3_FILE)"
  NEXT="""
  <item>
      <guid>$UUID</guid>
      <title>$episode</title>
      <link>$LINK$MP3_FILE</link>
      <description>$PODCAST_TITLE: $episode</description>
      <pubDate>$CURRENT_DATE</pubDate>
      <enclosure url="$LINK$MP3_FILE" length="$MP3_SIZE" type="audio/mpeg"></enclosure>
      <itunes:author>$PODCAST_AUTHOR</itunes:author>
      <itunes:subtitle>$episode</itunes:subtitle>
      <itunes:summary>Audio generated from the text of this chapter</itunes:summary>
      <itunes:image href="$IMAGE"></itunes:image>
      <itunes:duration>$DURATION</itunes:duration>
      <itunes:explicit>no</itunes:explicit>
      <itunes:order>$COUNT</itunes:order>
    </item>
"""
  BEGIN="${BEGIN}${NEXT}"
  COUNT=$((COUNT+1))
done


END="""
  </channel>
</rss>
"""

echo $BEGIN$END

#     
#     <item>
#       <guid>a1zDuOPkMSw</guid>
#       <title>Hamming, &#34;You and Your Research&#34; (June 6, 1995)</title>
#       <link>https://youtube.com/watch?v=a1zDuOPkMSw</link>
#       <description>Intro: I have given a talk with this title many times, and it turns out from discussions after the talk I could have just as well have called it &#34;You and Your Engineering Career,&#34; or even &#34;You and Your Career.&#34; But I left the word &#34;Research&#34; in the title because that is what I have most studied. From the previous chapters you have an adequate background for how I made the study, and I need not mention again the names of the famous people I have studied closely. The earlier chapters are, in sense, just a great expansion, with much more detail, of the original talk. This chapter is, in a sense, a summary of the previous chapters.&#xA;&#xA;&#xA;&#xA;The Art of Doing Science and Engineering: Learning to Learn&#34; was the capstone course by Dr. Richard W. Hamming (1915-1998) for graduate students at the Naval Postgraduate School (NPS) in Monterey California. &#xA;&#xA;This course is intended to instill a &#34;style of thinking&#34; that will enhance one&#39;s ability to function as a problem solver of complex technical issues. With respect, students sometimes called the course &#34;Hamming on Hamming&#34; because he relates many research collaborations, discoveries, inventions and achievements of his own. This collection of stories and carefully distilled insights relates how those discoveries came about. Most importantly, these presentations provide objective analysis about the thought processes and reasoning that took place as Dr. Hamming, his associates and other major thinkers, in computer science and electronics, progressed through the grand challenges of science and engineering in the twentieth century.</description>
#       <pubDate>Wed, 06 Jan 2021 05:50:07 +0000</pubDate>
#       <enclosure url="https://rockswhat.github.io/listener/listen_laterz/a1zDuOPkMSw.mp3" length="25044093" type="audio/mpeg"></enclosure>
#       <itunes:author>$PODCAST_TITLE</itunes:author>
#       <itunes:subtitle>Hamming, &#34;You and Your Research&#34; (June 6, 1995)</itunes:subtitle>
#       <itunes:summary><![CDATA[Intro: I have given a talk with this title many times, and it turns out from discussions after the talk I could have just as well have called it "You and Your Engineering Career," or even "You and Your Career." But I left the word "Research" in the title because that is what I have most studied. From the previous chapters you have an adequate background for how I made the study, and I need not mention again the names of the famous people I have studied closely. The earlier chapters are, in sense, just a great expansion, with much more detail, of the original talk. This chapter is, in a sense, a summary of the previous chapters.
# The Art of Doing Science and Engineering: Learning to Learn" was the capstone course by Dr. Richard W. Hamming (1915-1998) for graduate students at the Naval Postgraduate School (NPS) in Monterey California. 
# This course is intended to instill a "style of thinking" that will enhance one's ability to function as a problem solver of complex technical issues. With respect, students sometimes called the course "Hamming on Hamming" because he relates many research collaborations, discoveries, inventions and achievements of his own. This collection of stories and carefully distilled insights relates how those discoveries came about. Most importantly, these presentations provide objective analysis about the thought processes and reasoning that took place as Dr. Hamming, his associates and other major thinkers, in computer science and electronics, progressed through the grand challenges of science and engineering in the twentieth century.]]></itunes:summary>
#       <itunes:image href="https://i.ytimg.com/vi/a1zDuOPkMSw/default.jpg"></itunes:image>
#       <itunes:duration>44:03</itunes:duration>
#       <itunes:explicit>no</itunes:explicit>
#       <itunes:order>3</itunes:order>
#     </item>