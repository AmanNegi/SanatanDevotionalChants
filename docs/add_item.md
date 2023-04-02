# Add Mantra/Aarti/Bhajan

1. Get `.mp3` file from anywhere or download video from youtube and extract the `.mp3` file, ensure to store the `source` from where you are downloading the file.
2. Upload the file to terabyte or GDrive and make it publicly available. (Ensure that the file remains there forever and if are not sure about it please provide the `.mp3` file and we will upload it to Terabyte or GDrive)
3. Go to `data/data.json` and add an item inside the `items` key. Item should contain the follwing fields:
```json
id: Ensure no other item has the same ID
title: Name of the item
singer: Singer/Singers of the item
source: **Important** Ensure to mention the source from where you get the .mp3 file
image: Get a generic image that matches the title and theme
audioUrl: The URL of the publically available `.mp3` file.
```
4. Once you add this to the `data.json` file, remember the `id` and go to `lyrics.json` and add an item to the `lyrics` array.
```json
id: The ID you provided in the `data.json` file
lyrics: Single line string containing `\n` to indicate next line
```

## Resources:
1. Convert Multi line lyrics to a single line with `\n` tags use: https://codepen.io/jsnelders/pen/qBByqQy.
2. Upload `.mp3` to TeraBox or GDrive. We can later migrate to a real storage server.