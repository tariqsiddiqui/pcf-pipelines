/*
  Security Group Definitions
*/

/*
  Ops Manager Security group
*/
resource "aws_security_group" "directorSG" {
    name = "${var.prefix}-pcf_director_sg"
    description = "Allow incoming connections for Ops Manager."
    vpc_id = "${aws_vpc.PcfVpc.id}"
    tags {
        Name = "${var.prefix}-Ops Manager Director Security Group"
    }
}

resource "aws_security_group_rule" "allow_directorsg_ingress_default" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["${var.vpc_cidr}"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_ingress_ssh_concourse" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["54.81.136.18/32"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_ingress_ssh_junk_box" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["54.243.19.86/32"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_ingress_https_concourse" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["54.81.136.18/32"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_ingress_https_junk_box" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["54.243.19.86/32"]
    security_group_id = "${aws_security_group.directorSG.id}"
}


resource "aws_security_group_rule" "allow_directorsg_egress_default" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["${var.vpc_cidr}"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_egress_ntp" {
    type = "egress"
    from_port = 123
    to_port = 123
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_egress_http" {
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_egress_https" {
    type = "egress"
    from_port = 443
    to_port = 443 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

resource "aws_security_group_rule" "allow_directorsg_egress_replace_with_elb_ips" {
    type = "egress"
    from_port = 4443
    to_port = 4443 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.directorSG.id}"
}

/*
  RDS Security group
*/
resource "aws_security_group" "rdsSG" {
    name = "${var.prefix}-pcf_rds_sg"
    description = "Allow incoming connections for RDS."
    vpc_id = "${aws_vpc.PcfVpc.id}"
    tags {
        Name = "${var.prefix}-RDS Security Group"
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }    
  ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 1521
        to_port = 1521
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

/*
  PCF VMS Security group
*/
resource "aws_security_group" "pcfSG" {
    name = "${var.prefix}-pcf_vms_sg"
    description = "Allow connections between PCF VMs."
    vpc_id = "${aws_vpc.PcfVpc.id}"
    tags {
        Name = "${var.prefix}-PCF VMs Security Group"
    }
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["${var.vpc_cidr}"]
    }
      egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      egress {
        from_port = 4443
        to_port = 4443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
