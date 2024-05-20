import QtQuick
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Fusion

Rectangle {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.fill: parent
    color:"transparent"
    property MediaPlayerExtended mediaPlayer
    property AudioOutput audioOutput
    MouseArea {
        id: mouseHover
        hoverEnabled: true
        anchors.fill: parent
        onPositionChanged: visibleAnim.restart()
    }
    Rectangle {
        id: controlsPanel
        anchors.bottom: parent.bottom
        width: parent.width
        height: 100
        border.color: "#000000"
        border.width: 2
        color: "#2e2f30"
        opacity: 0
        PropertyAnimation {
            id: visibleAnim
            target: controlsPanel
            property: "opacity"
            from: 1
            to: 0
            duration: 2000
            easing.type: Easing.InExpo
        }
        GridLayout {
            rows: 2
            columns: 3
            anchors.fill: parent
            uniformCellWidths: true
            Slider{
                id: videoScrub
                Layout.row: 0
                Layout.columnSpan: 3
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
                Layout.leftMargin: 20
                Layout.rightMargin: Layout.leftMargin
                from: 0
                value: mediaPlayer.position
                to: mediaPlayer.duration
                Timer {
                    interval: 100; running: true; repeat: true
                    onTriggered: videoScrub.value = mediaPlayer.position
                }
                onMoved: {
                    mediaPlayer.position = videoScrub.value
                }
            }
            Slider {
                id: volumeSlider
                Layout.row: 1
                Layout.column: 0
                Layout.leftMargin: 20
                Layout.alignment: Qt.AlignLeft
                from: 0
                to: 1
                value: 1
                onMoved: audioOutput.volume = volumeSlider.value
            }
            RowLayout {
                Layout.row: 1
                Layout.column: 1
                Layout.alignment: Qt.AlignCenter
                spacing: 2
                RoundButton {
                    implicitHeight: 40
                    implicitWidth: 40
                    Layout.alignment: Qt.AlignCenter
                    id: backBtn
                    icon.source: "assets/next.svg"
                    icon.color: "white"
                    icon.width: 20
                    icon.height: icon.width
                    transform: Rotation {
                        angle: 180
                        origin.x: backBtn.width / 2
                        origin.y: backBtn.height / 2
                    }
                    onClicked : mediaPlayer.setPosition(0)
                }
                RoundButton {
                    id: playBtn
                    implicitHeight: 55
                    implicitWidth: 55
                    icon.source: "assets/pause.svg"
                    icon.color: "white"
                    icon.width: 30
                    icon.height: icon.width
                    Layout.alignment: Qt.AlignCenter
                    Connections {
                        target: mediaPlayer
                        function onPlayingChanged() {
                            switch (mediaPlayer.playbackState) {
                            case MediaPlayer.PlayingState:
                                playBtn.icon.source = "assets/pause.svg"
                                break
                            case MediaPlayer.PausedState:
                                playBtn.icon.source = "assets/play.svg"
                                break
                            case MediaPlayer.StoppedState:
                                playBtn.icon.source = "assets/play.svg"
                                break
                            }

                        }
                    }
                    onClicked: {
                        if (mediaPlayer.playing){
                            mediaPlayer.pause()
                        }
                        else{
                            mediaPlayer.play()
                        }
                    }
                }
                RoundButton {
                    id: nextBtn
                    Layout.row: 1
                    Layout.column: 2
                    implicitHeight: 40
                    implicitWidth: 40
                    icon.source: "assets/next.svg"
                    icon.color: "white"
                    icon.width: 20
                    icon.height: icon.width
                    onClicked : mediaPlayer.setPosition(mediaPlayer.duration)
                }
            }
            RowLayout {
                Layout.leftMargin: 20
                Layout.rightMargin: Layout.leftMargin
                Layout.alignment: Qt.AlignRight
                RoundButton {
                    id: menuBtn
                    implicitHeight: 50
                    implicitWidth: 50
                    icon.source: "assets/menu.svg"
                    icon.color: "white"
                    icon.width: 30
                    icon.height: icon.width
                    onClicked: {
                        generalMenu.open()
                    }
                    Menu {
                        id: generalMenu
                        y: height *(-1)
                        MenuItem {
                            text: "Choose Video"
                            onClicked: fileDialog.open()
                        }
                        MenuItem {
                            text: "Save Screenshot"
                            onClicked: mediaPlayer.saveScreenshot()
                        }
                    }
                    FileDialog {
                        id: fileDialog
                        title: "Please choose a file"
                        onAccepted: {
                            mediaPlayer.source = selectedFile
                            playBtn.clicked()
                        }
                    }
                }
                RoundButton {
                    id: speedBtn
                    implicitHeight: 50
                    implicitWidth: 50
                    icon.source: "assets/speed.svg"
                    icon.color: "white"
                    icon.width: 30
                    icon.height: icon.width
                    onClicked: {
                        speedMenu.open()
                    }
                    Menu {
                        id: speedMenu
                        y: height * (-1)
                        MenuItem {
                            text: "2"
                            onClicked: mediaPlayer.setPlaybackRate(2)
                        }
                        MenuItem {
                            text: "1.75"
                            onClicked: mediaPlayer.setPlaybackRate(1.75)
                        }
                        MenuItem {
                            text: "1.5"
                            onClicked: mediaPlayer.setPlaybackRate(1.5)
                        }
                        MenuItem {
                            text: "1.25"
                            onClicked: mediaPlayer.setPlaybackRate(1.25)
                        }
                        MenuItem {
                            text: "1"
                            onClicked: mediaPlayer.setPlaybackRate(1)
                        }
                        MenuItem {
                            text: "0.75"
                            onClicked: mediaPlayer.setPlaybackRate(.75)
                        }
                        MenuItem {
                            text: "0.5"
                            onClicked: mediaPlayer.setPlaybackRate(.5)
                        }
                        MenuItem {
                            text: "0.25"
                            onClicked: mediaPlayer.setPlaybackRate(.25)
                        }
                    }
                }
            }
        }
    }
}
