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

    // TODO: This line causes segmentation fault upon application exit.
    // Consider constructing the image using frame.bits() instead:
    //      frame.map(QVideoFrame::ReadOnly);
    //      QImage::Format imageFormat = QVideoFrameFormat::imageFormatFromPixelFormat(frame.pixelFormat());
    //      QImage img( frame.bits(), frame.width(), frame.height(), frame.bytesPerLine(), mageFormat);
    //      frame.unmap();
    QImage img = frame.toImage();

    QString str = QString("%1/screenshot.png").arg(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
    img.save(str);
    return true;
}
