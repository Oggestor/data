

library(stringr)
library(tibble)

for_num <- c(rep(1,144),rep(2,135),
             rep(3,30),rep(4,103),
             rep(5,1737),rep(6,122),rep(7,3437),rep(8,2491),rep(9,23),rep(10,22),rep(11,22),
             rep(12,48),rep(13,112),rep(14,257),rep(15,15),rep(16,46),rep(17,49),rep(18,41),
             rep(19,157),rep(20,176),rep(21,216),rep(22,284),rep(23,70), rep(24,18),
             rep(25,81),rep(26,189),rep(27,146),rep(28,142), rep(29,142),rep(30,653),
             rep(31,40),rep(32,37), rep(33,66),rep(34,77),rep(35,21),
             rep(36,511),
             rep(37,27),
             rep(38,74),rep(39,2465),rep(40,501),rep(41,3836),rep(42,776),rep(43,749),
             rep(44,323),rep(45,317),rep(46,296),rep(47,315),rep(48,985),
             rep(49,120),rep(50,71),rep(51,43),
             rep(52,148),rep(53,232),rep(54,66),
             rep(55,75),
             rep(56,180),rep(57,745),rep(58,901),rep(59,796),rep(60,80),rep(61,69),rep(62,397),
             rep(63,147),rep(64,125),
             rep(65,21), rep(66,10), rep(67,37),
             rep(68,446),
             rep(69,72),
             rep(70,1684), rep(71,430), rep(72,52), rep(73,69), rep(74,84)
)


for_typ <- c(rep("Bank_finans",144),rep("Bank_finans",135),
            rep("Bemaning",30),rep("Bemaning",103),
            rep("Bygg",1737),rep("Bygg",122),rep("Bygg",3437),rep("Bygg",2491),rep("Bygg",23),rep("Bygg",22),rep("Bygg",22),
            rep("Data_IT",48),rep("Data_IT",112),rep("Data_IT",257),rep("Data_IT",15),rep("Data_IT",46),rep("Data_IT",49),rep("Data_IT",41),
            rep("Fastighet",157),rep("Fastighet",176),rep("Fastighet",216),rep("Fastighet",284),rep("Fastighet",70), rep("Fastighet",18),
            rep("Fastighet",81),rep("Fastighet",189),rep("Fastighet",146),rep("Fastighet",142), rep("Fastighet",142),rep("Fastighet",653),
            rep("Fastighet",40),rep("Fastighet",37), rep("Fastighet",66),rep("Fastighet",77),rep("Fastighet",21),
            rep("Företagstjänster",511),
            rep("Hotell_Resturang",27),
            rep("Sjukvard",74),rep("Sjukvard",2465),rep("Sjukvard",501),rep("Sjukvard",3836),rep("Sjukvard",776),rep("Sjukvard",749),
            rep("Sjukvard",323),rep("Sjukvard",317),rep("Sjukvard",296),rep("Sjukvard",315),rep("Sjukvard",985),
            rep("Juridik",120),rep("Juridik",71),rep("Juridik",43),
            rep("Kultur_Noje",148),rep("Kultur_Noje",232),rep("Kultur_Noje",66),
            rep("Motorfordon",75),
            rep("Organisationer",180),rep("Organisationer",745),rep("Organisationer",901),rep("Organisationer",796),rep("Organisationer",80),rep("Organisationer",69),rep("Organisationer",397),
            rep("Partihandel",147),rep("Partihandel",125),
            rep("Teknik",21), rep("Teknik",10), rep("Teknik",37),
            rep("Tillverkning",446),
            rep("Transport",72),
            rep("Utbildning",1684), rep("Utbildning",430), rep("Utbildning",52), rep("Utbildning",69), rep("Utbildning",84)
)




vari_names <- c("number","type","y5","y3","y2","age","sex","role","years",
                "h1","h2","h3","h4","h5","h6",
                "t1","t2","t3","t4","t5","t6",
                "k1","k2","k3","k4","l1","l2",
                "lb1","lb2","lb3","lb4","lb5","lb6","lb7",
                "a1","i1","v1")


mat <- matrix(NA,16855,37)
colnames(mat) <- vari_names
num <- c(5,7,8,40,41,42,43,48,56,58,59,61,62)

m <- 1
for(i in 1:length(for_num)){
  
  if(any(num == for_num[i])){
    mat[m,1] <- for_num[i]
    mat[m,2] <- for_typ[i]
    m <- m + 1
  }
  
}

df <- as_tibble(mat)
df$number <- as.numeric(df$number)




Bolag5 <- tibble()
Bolag7 <- tibble()
Bolag8 <- tibble()
Bolag40 <- tibble()
Bolag41 <- tibble()
Bolag42 <- tibble()
Bolag43 <- tibble()
Bolag48 <- tibble()
Bolag56 <- tibble()
Bolag58 <- tibble()
Bolag59 <- tibble()
Bolag61 <- tibble()
Bolag62 <- tibble()

list <- list(Bolag5,Bolag7,Bolag8,Bolag40,Bolag41,Bolag42,Bolag43,
             Bolag48,Bolag56,Bolag58,Bolag59,Bolag61,Bolag62)


for(i in 1:length(list)){
list[[i]] <- read.csv2(str_c("https://raw.githubusercontent.com/Oggestor/Uppsats/main/Bolag",num[i],".csv",collapse = ""))
}



for(i in 1:length(list)){
  list[[i]] <- list[[i]][-1,!(str_detect(colnames(list[[i]]),"X"))]
}


cuma <- 1
for(i in 1:length(list)){
 
    for(g in 1:(ncol(df))){ # 37
      
      if(any(colnames(list[[i]]) == colnames(df)[g])){
        
        
        df[cuma:(cuma-1+(table(df$number)[i])),which(colnames(df) == colnames(df)[g])] <- list[[i]][1:table(df$number)[i],which(colnames(list[[i]]) == colnames(df)[g])]
     
      }
     
    }
  cuma <- cuma + (table(df$number)[i]) 
}


df[is.na(df)] <- "NA"
df[df == ""] <- "NA"
df[df == " - "] <- "NA"

df <- df[-15594,] # någon skum rad hade smugit in



# ÄNDRAR SKALOR ----------------------------------------------------------------

# alla 1-5 variabler , OBS OBS MÅSTE SES ÖVER, VISSA 1-4
h1_h6 <- 10:36
for(i in h1_h6){
  
   df[df[,i] == "" ,i]<- "NA"
   df[df[,i] == ("0") | df[,i] == ("-1") | df[,i] == ("6"),i] <- "vet ej"
}


# KÖN
df[df[,7] == "1",7] <- "kvinna"
df[df[,7] == "2",7] <- "man"
df[df[,7] == "Kvinna",7] <- "kvinna"
df[df[,7] == "Man",7] <- "man"
df[df[,7] == "3"|df[,7] == "4"|df[,7] == "5"|
     df[,7] == "Vill ej uppge"| df[,7] == "Annat",7] <- "annat/vill ej uppge"

(table(df$sex))


# v1
df[df[,37] == "3",37] <- "vill ej uppge"
(table(df$v1))



# y
bolag1till5 <- c(7,40,41,42,43,56,62)
for(j in 1:length(bolag1till5)){
    
    if((df[which(df$number == bolag1till5[j])[1],3] == "NA") &
       (df[which(df$number == bolag1till5[j])[1],4] == "NA")){
      i <- 5
    }else if((df[which(df$number == bolag1till5[j])[1],4] == "NA") &
             (df[which(df$number == bolag1till5[j])[1],5] == "NA")){
      i <- 3
    }else{
      i <- 4
    }

  
  df[df$number == bolag1till5[j] & (df$y5 == "1" | df$y5 == "2" |
                                    df$y3 == "1" | df$y3 == "2" |
                                    df$y2 == "1" | df$y2 == "2"),i] <- "nej"
  
  df[df$number == bolag1till5[j] & (df$y5 == "4" | df$y5 == "5" |
                                    df$y3 == "4" | df$y3 == "5" |
                                    df$y2 == "4" | df$y2 == "5"),i] <- "ja"
  
  
  df[df$number == bolag1till5[j] & 
       (df$y5 == "3" | df$y5 == "-1" | df$y5 == "6"|
        df$y3 == "3" | df$y3 == "-1" | df$y3 == "6"|
        df$y2 == "3" | df$y2 == "-1" | df$y2 == "6"),i] <- "vet ej"
 
}


bolag1till2 <- c(5,8,48,58,59,61)


  
for(j in 1:length(bolag1till2)){
  if((df[which(df$number == bolag1till2[j])[1],3] == "NA") &
     (df[which(df$number == bolag1till2[j])[1],4] == "NA")){
    i <- 5
  }else if((df[which(df$number == bolag1till2[j])[1],4] == "NA") &
           (df[which(df$number == bolag1till2[j])[1],5] == "NA")){
    i <- 3
  }else{
    i <- 4
  }

    
    df[df$number == bolag1till2[j] & (df$y5 == "1"  |
                                      df$y3 == "1" | 
                                      df$y2 == "1" ),i] <- "ja"
    
    df[df$number == bolag1till2[j] & (df$y5 == "2" | 
                                      df$y3 == "2" |
                                      df$y2 == "2" ),i] <- "nej"
    
    
    df[df$number == bolag1till2[j] & 
         (df$y5 == "3" | df$y5 == "4" | 
          df$y3 == "3" | df$y3 == "4" | 
          df$y2 == "3" | df$y2 == "4" ),i] <- "vet ej"
    
}

table(df$y5)
table(df$y2)
table(df$y3)


# age 
table(df$age) # FÖR MKE NA

# years
table(df$years) # FÖR MKE NA

# type
table(df$type) # FÖR MKE NA


# TAR BORT age, years, type

df <- df[,-c(6,8,9)]


df[df == "NA"] <- NA






