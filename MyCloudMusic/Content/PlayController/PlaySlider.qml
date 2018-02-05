/*
  歌曲播放进度条和音量调节器滑块
  */
import QtQuick 2.9
import QtQuick.Controls 2.2

Slider {
    property real minValue: 0.0
    property real maxValue: 0.0
    property bool isVisible: true //滑块handle是否显示，在音量调节器时需要隐藏
    property bool isPressed: false
    property var releasedFunc: function(){}
    id: sliderControl
    from: minValue
    to: maxValue

    background: Rectangle {
        x: sliderControl.leftPadding
        y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
        implicitWidth: sliderControl.width
        implicitHeight: 5
        width: sliderControl.availableWidth
        height: implicitHeight
        radius: 3
        color: "#171719"

        Rectangle {
            width: sliderControl.visualPosition * parent.width
            height: parent.height
            color: "#b82525"
            radius: 3
        }
    }

    handle: Rectangle {
        x: sliderControl.leftPadding + sliderControl.visualPosition
           * (sliderControl.availableWidth - width)
        y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
        width: 15
        height: 15
        radius: 15
        color: "#f6f6f6"
        visible: {
            if(isVisible){
                return true
            }
            else{
                if(sliderControl.hovered)
                    return true
                else
                    return false
            }
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "\uf6ca"
            color: "#b82525"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: icomoonFont.name
            font.pixelSize: 20
        }

        MouseArea {
            property real xmouse;
                        anchors.fill: parent;
                        hoverEnabled: true;

                        cursorShape: Qt.PointingHandCursor;
                        acceptedButtons: Qt.LeftButton;
                        onPressed: {
                            xmouse=mouseX;
                            sliderControl.isPressed=true;
                        }

                        onReleased: {
                            sliderControl.isPressed=false;
                            sliderControl.releasedFunc();
                        }

                        onPositionChanged: {
                            if(pressed)
                            {
                                sliderControl.value=sliderControl.value+(mouseX-xmouse)/(sliderControl.width)*(maxValue-minValue);
                            }
                        }
        }
    }
}
