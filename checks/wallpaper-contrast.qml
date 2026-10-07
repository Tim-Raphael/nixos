import QtQuick
import Quickshell
import "."

ShellRoot {
    Window {
        visible: true
        width: 200
        height: 200

        BarContrast {
            id: sampler
            source: "contrast.svg"
            screenWidth: 200
            imageSize: 200
            imageX: 0
            imageY: 0
            barHeight: 30
            property bool moved: false

            onModeChanged: {
                if (!moved) {
                    if (mode !== "light") Qt.exit(1);
                    moved = true;
                    imageY = -100;
                } else {
                    if (mode !== "dark") Qt.exit(1);
                    console.log("Wallpaper sampler followed the visible top edge.");
                    Qt.quit();
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        onTriggered: {
            console.error("Wallpaper sampler timed out.");
            Qt.exit(1);
        }
    }
}
