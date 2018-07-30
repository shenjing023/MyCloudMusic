import QtQuick 2.9
import QtQuick.Controls 2.2
import Network 1.0

Rectangle {
    property string albumUrl: ""    //专辑图片url
    property string songName: ""    //歌名
    property string albumName: ""   //专辑名
    property string singer: ""          //歌手
    property string lyric: ""           //歌词
    property string songId: ""      //歌曲id
    property int songLength: 0  //歌曲长度
    property var lyricTimes:[]   //存储每一句歌词对应的时间


    id:root
    //color: "#222225"

    /*
      根据播放进度的时间，找出对应的lyricTimes的下标,来控制歌词列表滚动
      */
    function findInsertIndex(num){
        var arr=lyricTimes
        var left=0
        var right=arr.length-1
        if (num<=arr[0]){
            return 0
        }
        else if(num>=arr[right]){
            return right
        }

        while(left<=right){
            var mid=left+parseInt((right-left)/2)
            if(arr[mid]>num){
                right=mid-1
            }
            else if(arr[mid]<num){
                left=mid+1
            }
            else{
                return mid
            }
        }

        return left-1
    }

    Connections{
        target: playController
        onPlaySliderChanged:{
            if (lyricTimes.length>0){
                lyricView.currentIndex=findInsertIndex(value)
                lyricView.positionViewAtIndex(findInsertIndex(value),ListView.Center)
            }
        }
        onPlayFinished:{
            network.get("/personfm?source=netease")
        }
        onNextSong:{
            network.get("/personfm?source=netease")
        }
    }

    Network{
        id:network
        onSign_requestFinished: {
            var data=JSON.parse(bytes)
            albumName=data["album"]
            songName=data["name"]
            albumUrl=data["picUrl"]
            singer=data["singer"]
            songId=data["id"]
            songLength=data["duration"]
            loadingLoader.visible=false
            // 解析歌词
            lyricModel.clear()
            if (data["lyric"]!==""){
                var lyrics=data["lyric"].split("\n")
                for (var i=0;i<lyrics.length;++i){
                    //console.log(lyrics[i])
                    var timeReg = /\[\d*:\d*((\.|\:)\d*)*\]/g;
                    var timeRegExpArr = lyrics[i].match(timeReg);
                    if(!timeRegExpArr)continue;
                    for(var k = 0,h = timeRegExpArr.length;k < h;k++) {
                        var t = timeRegExpArr[k];
                        var min = Number(String(t.match(/\[\d*/i)).slice(1));
                        var sec = Number(String(t.match(/\:\d*/i)).slice(1));
                        lyricTimes.push(min*60+sec)
                    }

                    lyricModel.append({
                                          _lyric:lyrics[i].replace(timeReg,'')
                                      })
                }
            }

            playMusic("source=netease" + "&id=" + songId,
                      albumUrl, songLength,
                      songName, singer)

        }
        onSign_requestError: {
            loadingLoader.visible=false
            loadingLoader.source = "qrc:/Content/NetworkError.qml"
        }
    }

    ListModel{
        //歌词列表model
        id:lyricModel
    }

    Loader{
        id:loadingLoader
        anchors.fill: parent
        source: "qrc:/Content/Loading.qml"
        z:10
        visible: true
    }

    Row{
        anchors.centerIn: parent
        width: 760
        height: 500
        spacing: 30

        //左边专辑图片
        Rectangle{
            id:leftImage
            width: parent.width/2-10
            height: parent.height

            Image {
                id: albumImage
                width: parent.width
                height: parent.height-70
                source: albumUrl
            }
        }

        //右边歌曲信息
        Column{
            width: parent.width/2-10
            height: parent.height
            spacing: 20
            //歌名
            Label{
                id:songLabel
                width: parent.width
                text: songName
                font.family: "Microsoft YaHei"
                font.pixelSize: 24
                verticalAlignment: Label.AlignVCenter
            }

            Item{
                width: parent.width
                height: 30
                //专辑
                Label{
                    width: parent.width/2
                    height: parent.height
                    text: "专辑: "+albumName
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 14
                    verticalAlignment: Label.AlignVCenter
                    elide: Text.ElideRight
                }
                //歌手
                Label{
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2
                    width: parent.width/2
                    height: parent.height
                    text: "歌手: "+singer
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 14
                    verticalAlignment: Label.AlignVCenter
                    elide: Text.ElideRight
                }
            }

            //歌词
            ListView{
                id:lyricView
                width: parent.width
                height: parent.height-songLabel.height-50

                model: lyricModel
                delegate: Label{
                    text: _lyric
                    font.family: "Microsoft YaHei"
                    font.pixelSize: ListView.isCurrentItem?20:16
                    wrapMode: Text.Wrap
                    width: parent.width
                    color: ListView.isCurrentItem?"red":"black"
                }
                //clip:true
                spacing: 10
                ScrollBar.vertical: ScrollBar{

                }
                boundsBehavior: Flickable.StopAtBounds
            }
        }
    }

    Component.onCompleted: {
        network.get("/personfm?source=netease")
    }
}
