import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window

ApplicationWindow {

    QtObject {
        id: internal
        function logout() {
            var component = Qt.createComponent("../qml/login.qml");
            var win = component.createObject();
            visible = false;
            win.show();
        }
        function showDialog() {
            centeredDialog.title = qsTr("Confimation!")
            centeredDialog.text = qsTr("Are you sure you want to logout?")
            centeredDialog.visible = true
        }
        function stay() {
            return;
        }
    }

    property string textUsername: "User: "

    id: root
    title: qsTr("AppName")
    visible: true
    minimumHeight: 560
    minimumWidth: 420
    maximumHeight: 560
    maximumWidth: 420
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window
    Rectangle {
        color: "transparent"
        anchors.fill: parent
        width: parent.width
        height: parent.height
        clip: true
        Image {
            source: "../images/Background.png"
            anchors.fill: parent
            smooth: true
        }
        Rectangle {
            id: titleBar
            width: parent.width
            height: 67
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                property real lastMouseX: 0
                property real lastMouseY: 0
                onPressed: {
                    lastMouseX = mouseX
                    lastMouseY = mouseY
                }
                onMouseXChanged: root.x += (mouseX - lastMouseX)
                onMouseYChanged: root.y += (mouseY - lastMouseY)
            }

            Image {
                source: "../images/CloseBtn.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 40
                anchors.topMargin: 25
                anchors.right: parent.right
                width: 30
                height: 30
                Button {
                    width: parent.width
                    height: parent.height
                    onClicked: Qt.quit()
                    background: Rectangle {
                        color: "transparent"
                    }
                    HoverHandler {
                        acceptedDevices: PointerDevice.Mouse
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
        Text {
            id: welcomer
            text: textUsername
            anchors.top: titleBar.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 20
            anchors.topMargin: 45
            color: "#f3f3f3"
            font.family: "Akira Expanded"
        }

        Text {
            id: timeTxt
            opacity: 2
            text: "null"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pointSize: 30
            anchors.topMargin: 10
            anchors.top: welcomer.bottom
            font.family: "Akira Expanded"
        }
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: timeTxt.text = Qt.formatTime(new Date())
        }

        Image {
            id: logoutBtn
            source: "../images/LogOutBtn.png"
            anchors.top: timeTxt.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 230
            height: 120
            anchors.topMargin: 12
            Button {
                width: parent.width - 22
                height: parent.height - 22
                onClicked: internal.showDialog()
                background: Rectangle {
                    color: "transparent"
                }
                HoverHandler {
                    acceptedDevices: PointerDevice.Mouse
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    Dialog {
        id: centeredDialog
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        height: 140
        width: 300
        focus: true
        modal: true

        property alias text: messageText.text

        Label {
            id: messageText

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            anchors.fill: parent
        }
        onAccepted: internal.logout()
        onRejected: internal.stay()
        standardButtons: Dialog.Ok | Dialog.Cancel
    }
}