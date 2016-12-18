#1.Find out the number of rows are in collection pitching

db.pitching.find().count();

#2.Count the number of records are in the year of 1872

db.pitching.count({"year":1872});

#3.Count the number of records that is between year of 1870 to 1880

db.pitching.count({"year":{$gt:1870},"year":{$lt:1880}});

#4.Which player_id has the highest ipouts?

db.pitching.aggregate([
	{$match:{ipouts:{$gte: 0}}},	
	{$sort:	{ipouts:-1}},
	{$group:{_id:null,ipouts:{$first:"$ipouts"},
	player_id:{$first:"$player_id"}}}
])


# 5.Find average year in the whole pitching collection
db.pitching.aggregate([{
	$group:
	{
		_id:null,
		year:
		{
			$avg:"$year"
			}
		}
	}
]);

# 6.Group the players by year and return the average ipouts per year

db.pitching.aggregate( [
    { 
	$group: 
	{
		_id: "$year",
		ipouts: 
		{
			$avg: "$ipouts" 
			} 
		} 
	}
]);

# 7.Find out the players with max era and min era per year
db.pitching.aggregate( [ 
	{ 
		$group: 
		{ 
			_id: "$year", 
			min_era: 
			{ 
			$min: "$era" 
			}, 
			max_era: 
			{$max:"$era"} 
		} 
	}
] );


#8 Find out the average, maximun and minimum h and er per team_id
db.pitching.aggregate([	
	{
		$group:
		{
			_id:"$team_id",
			min_h:
			{$min:"$h"},
			max_h:
			{$max:"$h"},
			avg_h:
			{$avg:"$h"},
			min_er:
			{$min:"$er"},
			max_er:
			{$max:"$er"},
			avg_er:
			{$avg:"$er"}
		}
	}
]).pretty();

# 9.Find out the average, maximun and minimum h and er per team_id and year

db.pitching.aggregate([
	{
		$group:
		{
			_id:
			{team:"$team_id",
			year:"$year"},
			min_h:
			{$min:"$h"},
			max_h:
			{$max:"$h"},
			avg_h:
			{$avg:"$h"},
			min_er:
			{$min:"$er"},
			max_er:
			{$max:"$er"},
			avg_er:
			{$avg:"$er"}
		}
	}
]);


# 10.Order the team_id by the number of players in the team and group by year
db.pitching.aggregate([
{
	$group:
	{
		_id:
		{
			teamid:"$team_id",
			year:"$year"},
			players:
			{$sum:1}
		}
	},
		{$sort:{players:-1}}
]).pretty();

