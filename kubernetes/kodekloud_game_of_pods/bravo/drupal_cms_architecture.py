#!/usr/bin/python

from diagrams import Cluster, Diagram
from diagrams.onprem.database import Postgresql
from diagrams.onprem.client import User
from diagrams.custom import Custom
from diagrams.k8s.network import Service
from diagrams.k8s.podconfig import Secret
from diagrams.k8s.storage import PV, PVC
from diagrams.k8s.compute import Deployment


with Diagram("", show=False):
    user = User("User")
    drupal_service = Service("drupal-service")
    drupal_mysql = Deployment("drupal-mysql")
    drupal_mysql_service = Service("drupal-mysql-service")
    drupal = Deployment("drupal")
    drupal_mysql_secret = Secret("drupal-mysql-secret")
    drupal_mysql_pvc = PVC("drupal-mysql-pvc")
    drupal_mysql_pv = PV("drupal-mysql-pv")
    drupal_mysql_pv_hostpath = Custom("drupal-mysql-pv-hostpath", "./images/folder.png")
    drupal_pv_hostpath = Custom("drupal-pv-hostpath", "./images/folder.png")
    drupal_pv = PV("drupal-pv")
    drupal_pvc = PVC("drupal-pvc")

    with Cluster("drupal"):
        grpdrupal = [
            drupal_pvc,
            drupal_pv,
            drupal_pv_hostpath
        ]

    with Cluster("drupal-mysql"):
        grpmysql = [
            #drupal-mysql,
            drupal_mysql_pvc,
            drupal_mysql_pv,
            drupal_mysql_pv_hostpath
        ]


    #user >> drupal_service >> drupal >> drupal_mysql_service >> drupal_mysql
    #drupal_mysql >> drupal_mysql_secret

    #drupal_mysql_service >> grpmysql

#    grpdrupal >> drupal

    user >> [ drupal, drupal_pvc, drupal_pv, drupal_pv_hostpath]   

    