#include "mediaplayerextended.h"
#include <QVideoSink>
#include <QVideoFrame>
#include <QVideoFrameFormat>
#include <QStandardPaths>
MediaPlayerExtended::MediaPlayerExtended(QObject *parent):QMediaPlayer(parent) {}

bool MediaPlayerExtended::saveScreenshot()
{
    if (!videoSink())
        return false;
    QVideoFrame frame = videoSink()->videoFrame();
    if (!frame.isValid())
        return false;
    QImage img = frame.toImage();
    QString path = QString("%1/screenshot.png").arg(
        QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
    return img.save(path);
}
