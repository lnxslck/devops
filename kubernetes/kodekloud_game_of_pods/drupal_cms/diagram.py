#!/usr/bin/python

from diagrams import Cluster, Diagram, Edge
from diagrams.onprem.database import Postgresql
from diagrams.onprem.client import User
from diagrams.custom import Custom

with Diagram("Drupal CMS Deployment", show=False):
    user = User("User")

    with Cluster(""):
        drupal = Custom("Drupal", "./drupal.png")
        drupal >> Postgresql("Drupal DB")

    user >> Edge(label="HTTP/80") >> drupal