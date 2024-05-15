import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
    id: root
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width
    height: 100
    color:"transparent"
    property MediaPlayer mediaPlayer
    property AudioOutput audioOutput
    MouseArea{
        id: mouseHover
        hoverEnabled: true
        anchors.fill: parent
        onEntered: visibleAnim.start()
    }
    Rectangle{
        id: controlsPanel
        anchors.fill: parent
        border.color: "#000000"
        border.width: 2
        color: "#2e2f30"
        opacity: 0
        PropertyAnimation {
            id: visibleAnim
            target: controlsPanel
            property: "opacity"
            from: .5
            to: 0
            duration: 5000
            easing.type: Easing.InExpo
        }
        GridLayout{
            rows: 2
            columns: 3
            anchors.fill: parent
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
            Slider{
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
                    text: "<"
                }
                RoundButton {
                    implicitHeight: 55
                    implicitWidth: 55
                    id: playBtn
                    text: "S"
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        if (mediaPlayer.playing){
                            mediaPlayer.pause()
                            playBtn.text = "P"
                        }
                        else{
                            mediaPlayer.play()
                            playBtn.text = "S"
                        }
                    }
                }
                RoundButton {
                    Layout.row: 1
                    Layout.column: 2
                    implicitHeight: 40
                    implicitWidth: 40
                    id: nextBtn
                    text: ">"
                }
            }
            RoundButton {
                implicitHeight: 50
                implicitWidth: 50
                id: menuBtn
                text: "M"
                Layout.leftMargin: 20
                Layout.rightMargin: Layout.leftMargin
                Layout.alignment: Qt.AlignRight
                onClicked: {
                    fileDialog.open()
                }

                FileDialog {
                    id: fileDialog
                    title: "Please choose a file"
                    currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                    onAccepted: {
                        mediaPlayer.source = selectedFile
                    }
                }
            }

        }
    }
}
