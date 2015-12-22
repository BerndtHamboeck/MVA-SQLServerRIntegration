40 + 2

sum(1:15) 

x <- 1:15 
x


y <- 10 
x + y 


rouletteWeek <- c(-120, -50, 200, -150, 210);
weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday");
names(rouletteWeek) <- weekdays;
rouletteWeek

#days with profit
sumDays <- sum(rouletteWeek > 0);
#sum of profit
rouletteTotalPlus <- sum(rouletteWeek[rouletteWeek > 0]);
#total
rouletteTotal <- sum(rouletteWeek);

#days with profit
rouletteDaysPlus <- rouletteWeek[rouletteWeek > 0];


sumDays 
rouletteTotalPlus
rouletteTotal
rouletteDaysPlus