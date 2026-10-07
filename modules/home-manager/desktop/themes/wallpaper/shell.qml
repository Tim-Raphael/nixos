import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "Position.js" as Position
import "Contrast.js" as Contrast

ShellRoot {
    id: root
    property var state: Position.emptyState()
    property var modes: ({})

    function updateMode(output, mode) {
        if (!mode || modes[output] === mode) return;
        modes[output] = mode;
        contrastStyle.setText(Contrast.stylesheet(modes));
    }

    function removeOutput(output) {
        delete modes[output];
        contrastStyle.setText(Contrast.stylesheet(modes));
    }

    FileView {
        id: contrastStyle
        path: Quickshell.env("WALLPAPER_CONTRAST_CSS")
        preload: false
        atomicWrites: true
    }

    Socket {
        id: events
        path: Quickshell.env("NIRI_SOCKET")
        connected: true
        onConnectedChanged: {
            if (connected) {
                root.state = Position.emptyState();
                write('"EventStream"\n');
                flush();
            }
        }
        parser: SplitParser {
            onRead: data => {
                try {
                    root.state = Position.applyEvent(root.state, JSON.parse(data));
                } catch (error) {
                    console.warn("Invalid Niri wallpaper event", error);
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: !events.connected
        repeat: true
        onTriggered: events.connected = true
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: background
            required property var modelData
            screen: modelData
            anchors { top: true; bottom: true; left: true; right: true }
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: "spatial-wallpaper"
            color: "#f5f2ef"
            mask: Region {}

            readonly property var offset: Position.offset(root.state, screen.name, width, height)
            Component.onDestruction: root.removeOutput(modelData.name)

            Item {
                anchors.fill: parent
                clip: true

                Image {
                    id: wallpaper
                    source: Quickshell.env("WALLPAPER_IMAGE")
                    width: Math.max(background.width, background.height) * 1.12
                    height: width
                    sourceSize: Qt.size(Math.ceil(width * background.screen.devicePixelRatio),
                                        Math.ceil(height * background.screen.devicePixelRatio))
                    x: (background.width - width) / 2 + background.offset.x
                    y: (background.height - height) / 2 + background.offset.y
                    asynchronous: true
                    mipmap: true
                    fillMode: Image.PreserveAspectCrop

                    Behavior on x { NumberAnimation { duration: 240; easing.type: Easing.OutCubic } }
                    Behavior on y { NumberAnimation { duration: 320; easing.type: Easing.OutCubic } }
                }

                BarContrast {
                    source: wallpaper.source
                    screenWidth: background.width
                    imageSize: wallpaper.width
                    imageX: wallpaper.x
                    imageY: wallpaper.y
                    barHeight: Number(Quickshell.env("WAYBAR_HEIGHT"))
                    onModeChanged: root.updateMode(background.screen.name, mode)
                }
            }
        }
    }
}
