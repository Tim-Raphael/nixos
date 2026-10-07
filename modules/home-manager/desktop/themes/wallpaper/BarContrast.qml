import QtQuick
import "Contrast.js" as Contrast

Canvas {
    id: sampler
    required property url source
    required property real screenWidth
    required property real imageSize
    required property real imageX
    required property real imageY
    required property real barHeight
    property string mode: ""

    width: 128
    height: 4
    opacity: 0
    contextType: "2d"

    function sample() {
        if (!available || !isImageLoaded(source) || screenWidth <= 0 || imageSize <= 0 || barHeight <= 0) return;
        const context = getContext("2d");
        context.reset();
        context.fillStyle = "#f5f2ef";
        context.fillRect(0, 0, width, height);
        context.drawImage(source, imageX * width / screenWidth, imageY * height / barHeight,
                          imageSize * width / screenWidth, imageSize * height / barHeight);
        mode = Contrast.modeForPixels(context.getImageData(0, 0, width, height).data, mode);
    }

    Component.onCompleted: loadImage(source, Qt.size(512, 512))
    onImageLoaded: sample()
    onAvailableChanged: update.start()
    onScreenWidthChanged: update.start()
    onImageSizeChanged: update.start()
    onImageXChanged: update.start()
    onImageYChanged: update.start()
    onBarHeightChanged: update.start()
    onSourceChanged: loadImage(source, Qt.size(512, 512))

    Timer {
        id: update
        interval: 100
        onTriggered: sampler.sample()
    }
}
