import QtQuick
import QtMultimedia
import QtQuick.Controls.Fusion
import VideoPlayer //MediaPlayerExtended

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Media Player")
    color: "black"
    MediaPlayerExtended {
        id: mediaPlayer
        audioOutput: audioOutput
        videoOutput: videoOutput
    }
    VideoOutput {
        id: videoOutput
        z: 1
        anchors.fill: parent
        PlayerControls {
            z: 2
            mediaPlayer: mediaPlayer
            audioOutput: audioOutput
        }
    }
    AudioOutput {
        id: audioOutput
    }
    MouseArea {
        anchors.fill: parent
        onPressed: mediaPlayer.play()
    }
    Text {
        text: "No video to play"
        color: "white"
        anchors.centerIn: parent
    }
}
