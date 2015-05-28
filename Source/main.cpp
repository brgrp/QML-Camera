#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlEngine>
#include <QDir>
#include <QDebug>
#include <QtDeclarative/qdeclarativepropertymap.h>
#include <QQmlContext>
#include <QMultimedia>

#include "cameraselector.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView* view = new QQuickView;

    QDir dir("./Output");
       if (!dir.exists())
       {
           qDebug()<<QString("Output path does not exist. Create path:").append(dir.absolutePath());
           dir.mkpath(".");
       }

       QList<QCameraInfo> cameras = QCameraInfo::availableCameras();
       foreach (const QCameraInfo &cameraInfo, cameras)
           qDebug() << cameraInfo.deviceName();

//       CameraSelector selector;
//       selector.setSelectedCameraDevice(1);
    qmlRegisterType<CameraSelector>("cameraSelector", 1, 0, "CameraSelector");

    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->rootContext()->setContextProperty("absImagePath", dir.absolutePath());
    view->setSource(QUrl("qrc:///main.qml"));

    view->resize(800, 600);
    QObject::connect(view->engine(), SIGNAL(quit()), qApp, SLOT(quit()));
    view->show();
    return app.exec();
}

