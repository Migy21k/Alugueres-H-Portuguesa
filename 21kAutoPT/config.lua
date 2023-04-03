--DEVMIGY21K
config = {}


config.RentTime = 900000   -- 15min para mais tempo ou menos : https://convertlive.com/pt/u/converter/minutos/em/milissegundos#15
config.WarningRentTime1 = 420000 --7min isto é para avisar quanto tempo falta
config.WarningRentTime2 = 60000 --1min

config.cars = {
    [1] = {
        ["car_name"] = "Motorizada",
        ["car_price"] = 10,
    },
    [2] = {
        ["car_name"] = "Land Cruiser",
        ["car_price"] = 300,
    },
    [3] = {
        ["car_name"] = "Mercedes Cla ",
        ["car_price"] = 800,
    },
    [4] = {
        ["car_name"] = "Mota 160",
        ["car_price"] = 15000,
    },
    [5] = {
        ["car_name"] = "Ford Taurus",
        ["car_price"] = 7000,
    },
    [6] = {
        ["car_name"] = "Porsche 930t",
        ["car_price"] = 10000,
    },
    [7] = {
        ["car_name"] = "Lancer Evo",
        ["car_price"] = 1000,
    },
    [8] = {
        ["car_name"] = "Toyota Camry",
        ["car_price"] = 1200,
    },
    [9] = {
        ["car_name"] = "Hilux Picape",
        ["car_price"] = 5000,
    },
}


config.PedList = {                                         
	{
		model = "s_m_m_movprem_01",                            
		coords = vector3(109.5597, -1088.195, 28.3),               
		heading = 337.9669,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
}


config.CarSpawnLocation = {
    airport	= vector4(110.9821, -1081.255, 29.1924, 333.7501),     
}
config.PlayerReturnLocation = {
    airport 	= vector4(109.5597, -1088.195, 28.3, 239.13),       
}