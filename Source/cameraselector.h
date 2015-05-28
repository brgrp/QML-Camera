#ifndef CAMERASELECTOR_H
#define CAMERASELECTOR_H

#include <QObject>
#include <QCamera>
#include <QCameraInfo>
#include <QVideoDeviceSelectorControl>

class CameraSelector : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QObject* cameraObject READ readCameraObject WRITE setCameraObject )
    Q_PROPERTY(int selectedCameraDevice READ selectedDevice WRITE setSelectedCameraDevice )

    QCamera *m_camera;
    QVideoDeviceSelectorControl *m_deviceSelector;

public:
    explicit CameraSelector(QObject *parent = 0);
    ~CameraSelector();

    void setCameraObject(QObject *cam);

    int setSelectedCameraDevice(int cameraId);

    QObject* readCameraObject();
    int selectedDevice();
signals:

public slots:
};

#endif // CAMERASELECTOR_H

