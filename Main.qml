import QtQuick
import QtMultimedia
import VideoPlayer //MediaPlayerExtended
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Media Player")
    color: "black"
    MediaPlayerExtended {
        id: mediaPlayer
        source: "C:/Users/wille/Downloads/cat.mp4"
        audioOutput: audioOutput
        videoOutput: videoOutput
    }
    VideoOutput {
        z: 1
        id: videoOutput
        anchors.fill: parent
        PlayerControls {
            z: 100
            // anchors.bottom: videoOutput.bottom
            mediaPlayer: mediaPlayer
            audioOutput: audioOutput
        }
    AudioOutput{
        id: audioOutput
    }
    }
    MouseArea {
        anchors.fill: parent
        onPressed: mediaPlayer.play()
    }
    Component.onCompleted: {
        mediaPlayer.play()
    }
}
