#ifndef MEDIAPLAYEREXTENDED_H
#define MEDIAPLAYEREXTENDED_H

#include <QMediaPlayer>
#include <QQmlEngine>

class MediaPlayerExtended : public QMediaPlayer
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MediaPlayerExtended(QObject *parent = nullptr);
    Q_INVOKABLE bool saveScreenshot();
};

#endif // MEDIAPLAYEREXTENDED_H
