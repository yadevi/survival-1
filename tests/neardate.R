library(survival)
# the second data set is not sorted by id/date, on purpose

df1 <- data.frame(id= 1:10,
                  y1= as.Date(c("1992-01-01", "1996-01-01", "1997-03-20",
                              "2000-01-01", "2001-01-01", "2004-01-01",
                              "2014-03-27", "2014-01-30", "2000-08-01",
                              "1997-04-29")))

df2 <- data.frame(id= c(1, 1, 2, 3, 4, 4, 5, 6, 7, 7, 8, 9, 9, 9, 10, 
                        3, 3, 6, 6, 8),
                  y2= as.Date(c("1998-04-30", "2004-07-01", "1999-04-14", 
                        "2001-02-22", "2003-11-19", "2005-02-15", "2006-06-22",
                        "2007-09-20", "2013-08-02", "2015-01-09", "2014-01-15",
                        "2006-12-06", "1999-10-20", "2010-06-30", "1997-04-28",
                        "1995-04-20", "1997-03-20", "1998-04-30", "1995-04-20",
                        "2006-12-06")))

if (FALSE) {  # plot for visual check
    plot(y2 ~ id, df2, ylim=range(c(df1$y1, df2$y2)), type='n')
    text(df2$id, df2$y2, as.numeric(1:nrow(df2)))
    points(y1~id, df1, col=2, pch='+')
}

i1 <- neardate(df1$id, df2$id, df1$y1, df2$y2)
all.equal(i1, c(1, 3, 17, 5, 7, 8, 10, NA, 12, NA))

i2 <- neardate(df1$id, df2$id, df1$y1, df2$y2, best="prior")
all.equal(i2, c(NA, NA, 17, NA, NA, 18, 9, 11, 13, 15))

indx <- order(df2$id, df2$y2)
df3 <- df2[indx,]
i3 <- neardate(df1$id, df3$id, df1$y1, df3$y2)
all.equal(indx[i3], i1)

i4 <- neardate(df1$id, df3$id, df1$y1, df3$y2, best="prior")
all.equal(indx[i4], i2)

indx <- c(2,3,10,9, 4,5, 7,8,1,6)
df4 <- df1[indx,]
i5 <-  neardate(df4$id, df2$id, df4$y1, df2$y2)
all.equal(i1[indx], i5)
