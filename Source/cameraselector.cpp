#include "cameraselector.h"

CameraSelector::CameraSelector(QObject *parent) : QObject(parent)
{

}

CameraSelector::~CameraSelector()
{

}

void CameraSelector::setCameraObject(QObject *cam)
{
    // get the QCamera from the declarative camera's mediaObject property.
    m_camera = qvariant_cast<QCamera*>(cam->property("mediaObject"));

    // get the video device selector control
    QMediaService *service = m_camera->service();
    m_deviceSelector = qobject_cast<QVideoDeviceSelectorControl*>(service->requestControl(QVideoDeviceSelectorControl_iid));
}

int CameraSelector::setSelectedCameraDevice(int cameraId)
{
    // A camera might already be started, make sure it's unloaded
    m_camera->unload();

    m_deviceSelector->setSelectedDevice(cameraId);
    return 1;
}

QObject* CameraSelector::readCameraObject()
{


}

int CameraSelector::selectedDevice()
{

    return 0;
}


