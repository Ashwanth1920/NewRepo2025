resource "aws_instance" "rajuuu" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd

              # Create the index.html file with full content
              cat <<EOT > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>SuperHero</title>
                  <style>
                      * {
                          margin: 0;
                          padding: 0;
                          box-sizing: border-box;
                          font-family: Arial, sans-serif;
                      }
                      .header {
                          color: black;
                          padding: 0px 20px;
                          position: sticky;
                          top: 0;
                          background-color: white;
                          z-index: 1000;
                      }
                      .header-flex {
                          display: flex;
                          justify-content: space-between;
                          width: 60%;
                      }
                      .container {
                          padding: 40px;
                          background-color: black;
                      }
                      .image-flex {
                          display: flex;
                          gap: 20px;
                          overflow-x: scroll;
                      }
                      .image-flex img {
                          object-fit: contain;
                          height: 400px;
                          width: 400px;
                          transition: transform 0.4s ease-in-out, box-shadow 0.4s ease-in-out;
                          animation: float 2s infinite alternate ease-in-out;
                      }
                      .image-flex img:hover {
                          transform: scale(1.1) rotate(5deg);
                          box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
                      }
                      @keyframes float {
                          0% {
                              transform: translateY(0);
                          }
                          100% {
                              transform: translateY(-10px);
                          }
                      }
                  </style>
              </head>
              <body>
                  <div class="header">
                      <div class="header-flex">
                          <h1 style="color: blue;">SUPERHERO</h1>
                      </div>
                  </div>
                  <div class="container">
                      <div class="image-flex">
                          <img src="https://imgs.search.brave.com/iZCcs_0iqn53B9TwYXl-UjJLrHEpmGUyhIfdz5RX0XM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2E1LzE1/LzcwL2E1MTU3MGY5/NTgwMjEwNzdjNGIz/MjMxMjNhZjVjNDg2/LmpwZw" alt="Hero 1">
                          <img src="https://imgs.search.brave.com/GrxBbHd8wYUOC--y-Q-gXDfyhsHjq1Ex7rcWd1VVGV8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2ZhL2Rm/L2Q5L2ZhZGZkOWZm/MDRmMmM3NjJjMDli/MTA3YzlmOGNiOTdj/LmpwZw" alt="Hero 2">
                      </div>
                  </div>
              </body>
              </html>
              EOT

              sudo systemctl restart httpd
              EOF
}

resource "aws_cloudwatch_metric_alarm" "foobar" { 
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors EC2 CPU utilization"
  insufficient_data_actions = []

  # Attach alarm to an EC2 instance
  dimensions = {
    InstanceId = aws_instance.rajuuu.id  # Link to your EC2 instance
  }
}

#!/bin/bash
echo "this is first line"
sleep 10
echo "this is the line after sleeping"