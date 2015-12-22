USE [IntegrateR]
CREATE TABLE [dbo].[Roulette](
	[Won] [int] NOT NULL,
) ON [PRIMARY]
go


insert into Roulette
values (-120), (-50), (200), (-150), (210)
go

execute sp_execute_external_script
  @language = N'R'
, @script = N' mysum <- 40 + 2;
               OutputDataSet <- data.frame(mysum);'
, @input_data_1 = N''
WITH RESULT SETS (([col] int NOT NULL));


execute sp_execute_external_script
  @language = N'R'
, @script = N' mysum <- sum(1:15);
               OutputDataSet <- data.frame(mysum);'
, @input_data_1 = N''
WITH RESULT SETS (([col] int NOT NULL));

execute sp_execute_external_script
  @language = N'R'
, @script = N' x <- array(1:15); y <- 10;
               OutputDataSet <- data.frame(x + y);'
, @input_data_1 = N''
WITH RESULT SETS (([col] int NOT NULL));

execute sp_execute_external_script
  @language = N'R'
, @script = N' x <- 1:15;
			   #InputDataSet is a data.frame
			   str(InputDataSet)
               y <- as.vector(t(InputDataSet));
			   z <- x + y;
               OutputDataSet <- data.frame(z);'
, @input_data_1 = N' SELECT 10 as y'
WITH RESULT SETS (([col] int NOT NULL));



execute sp_execute_external_script
  @language = N'R'
, @script = N'
		rouletteWeek <- c(-120, -50, 200, -150, 210);

		sumDays <- sum(rouletteWeek > 0);
		rouletteTotalPlus <- sum(rouletteWeek[rouletteWeek > 0]);
		rouletteTotal <- sum(rouletteWeek);

        OutputDataSet <- data.frame(sumDays, rouletteTotalPlus, rouletteTotal);'
, @input_data_1 = N''
WITH RESULT SETS (([sumDays] int, [rouletteTotalPlus] int, [rouletteTotal] int));

use IntegrateR
go
execute sp_execute_external_script
  @language = N'R'
, @script = N'
		rouletteWeek <- as.matrix(InputDataSet);

		sumDays <- sum(rouletteWeek > 0);
		rouletteTotalPlus <- sum(rouletteWeek[rouletteWeek > 0]);
		rouletteTotal <- sum(rouletteWeek);

        OutputDataSet <- data.frame(sumDays, rouletteTotalPlus, rouletteTotal);'
, @input_data_1 = N' Select Won from Roulette'
WITH RESULT SETS (([sumDays] int, [rouletteTotalPlus] int, [rouletteTotal] int));

execute sp_execute_external_script
  @language = N'R'
, @script = N'
		rouletteWeek <- as.matrix(InputDataSet);
		weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday");
		names(rouletteWeek) <- weekdays;

		rouletteDaysPlus <- rouletteWeek[rouletteWeek > 0];

        colNames <- cbind(rouletteDaysPlus);
        #colNames <- data.frame(rouletteDaysPlus, check.names = FALSE);

        OutputDataSet <- data.frame(rownames(colNames), rouletteDaysPlus);'
, @input_data_1 = N' Select Won from Roulette'
WITH RESULT SETS (([day] nvarchar(20), [rouletteDaysPlus] int));


