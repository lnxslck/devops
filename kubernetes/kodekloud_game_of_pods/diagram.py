from diagrams import Diagram 
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.network import ELB
from diagrams.onprem.database import PG

with Diagram("Web Service", show=False):
    ELB("lb") >> EC2("web") >> PG("userdb")