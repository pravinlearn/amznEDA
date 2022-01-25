
pass <- as.character("sen241697")
library(mailR)
send.mail(from="praveenstudy7@gmail.com",
          to="praveenarumugam19@gmail.com",
          subject="Test Email",
          body="PFA the desired document",
          html=T,
          smtp=list(host.name = "smtp.gmail.com",
                    port = 465,
                    user.name = "praveenstudy7@gmail.com",
                    passwd = pass,
                    ssl = T),
                    authenticate=T)
