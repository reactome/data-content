[<img src=https://user-images.githubusercontent.com/6883670/31999264-976dfb86-b98a-11e7-9432-0316345a72ea.png height=75 />](https://reactome.org)

# Reactome Data Content - Generate Sprite Images

This image folder exists in order to be able to create a new sprite sheet from all the available images.

### How to generate new Spritesheet.png in case images are added or updated ?

1. Add the new images in the folder sprite/images
2. Go to https://spritegen.website-performance.org/
3. Click clear before import new images
4. Click Open and select sprite/images > Select ALL images
5. In the settings panel select the following options:
     * Layout:       Horinzontal
     * CSS/Less:     CSS
     * Style Prefix: sprite
     * Padding:      5px
6. Click Downloads
7. Click Spritesheet and Stylesheet
8. Get the spritesheet.png and move it to ```webapp/resources/css/images```
9. Open the entire stylesheet.css, copy its content but .sprite block.
    ```
    .sprite {
        background: url(../images/spritesheet.png) no-repeat;
        display: inline-block;
    }
    ```

10. Paste the content in ```webapp/resources/css/sprite.css``` after ```/** PASTE NEW CSS HERE **/```


PS. Do not delete the following classes styles.

```
.sprite {
  background: url(../images/spritesheet.png) no-repeat;
  display: inline-block;
}

.sprite-resize {
  zoom: .75;
  -moz-transform: scale(.75);
}

.sprite-resize-small {
  zoom: .6;
  -moz-transform: scale(.6);
}

.sprite-position {
  vertical-align: middle;
  padding: 2px;
}
```