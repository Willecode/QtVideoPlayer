import QtQuick
import QtQuick.Controls.Fusion
RoundButton {
    implicitHeight: 40
    implicitWidth: 40
    icon.color: "white"
    icon.width: 20
    icon.height: icon.width
    property bool mirrorIcon: false
    transform: Rotation {
        angle: 180 * mirrorIcon
        origin.x: backBtn.width / 2
        origin.y: backBtn.height / 2
    }
}
