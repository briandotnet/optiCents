# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
store_chains = StoreChain.create([
  {:name => "Sobeys"},
  {:name => "SuperStore"},
  {:name => "Walmart"}
])

stores = Store.create([
  {:store_chain_id => 1,:name => "	Sobeys Bedford south	",:street_address=>"	55 Peakview Dr	",:city=>"	Bedford	",:province=>"	Nova Scotia	",:postal_code=>"	B3M 0G2	",:phone=>"	(902) 832-0640	",:description=>"	24h except Sunday 12pm-5pm	",:lat=>	44.6993298	,:lng=>	-63.6877451	},
  {:store_chain_id => 2,:name => "	Atlantic Superstore	",:street_address=>"	1650 Bedford Hwy	",:city=>"	Bedford	",:province=>"	Nova Scotia	",:postal_code=>"	B4A 4J7	",:phone=>"	(902) 832-3117	",:description=>"	7am to 10pm Monday-Saturday 9am - 9pm Sunday	",:lat=>	44.7338332	,:lng=>	-63.6556606	},
  {:store_chain_id => 2,:name => "	Gouthro's NoFrills	",:street_address=>"	118 Wyse Road	",:city=>"	Dartmouth	",:province=>"	Nova Scotia	",:postal_code=>"	B3A 1N7	",:phone=>"	(902) 465-7254	",:description=>"	8am to 10pm Monday-Saturday 10am - 6pm Sunday"	,:lat=>	44.6717141	,:lng=>	-63.577954	},
  {:store_chain_id => 3,:name => "	Wal-Mart	",:street_address=>"	220 Chain Lake Dr	",:city=>"	Halifax	",:province=>"	Nova Scotia	",:postal_code=>"	B3S 1C5	",:phone=>"	(902) 450-5570	",:description=>"	8am to 10pm Monday-Saturday 10am - 8pm Sunday"	,:lat=>	44.6542977	,:lng=>	-63.6778662	},
  {:store_chain_id => 2,:name => "	Atlantic Superstore	",:street_address=>"	3601 Joseph Howe Dr	",:city=>"	Halifax	",:province=>"	Nova Scotia	",:postal_code=>"	B3L 4H8	",:phone=>"	(902) 453-1080	",:description=>"	24h except Sunday 8am-10pm	",:lat=>	44.657586	,:lng=>	-63.6293362	},

  {:store_chain_id => 1,:name => "	Sobeys - McAllister Place	",:street_address=>"	519 Westmorland Dr	",:city=>"	Saint John	",:province=>"	New Brunswick	",:postal_code=>"	E2J 3W9	",:phone=>"	(506) 633-1187	",:description=>"	24h except Sunday 12pm-5pm	",:lat=>	45.3099292	,:lng=>	-66.0161041	},
  {:store_chain_id => 2,:name => "	Atlantic Superstore	",:street_address=>"	115 Campbell Rd	",:city=>"	Rothesay	",:province=>"	New Brunswick	",:postal_code=>"	E2E 6E4	",:phone=>"	(506) 847-7055	",:description=>"	24h except Sunday 12pm-5pm	",:lat=>	45.3896874	,:lng=>	-65.9677143	},
  {:store_chain_id => 2,:name => "	Dave's NoFrills	",:street_address=>"	621 Fairville Blvd	",:city=>"	Saint John	",:province=>"	New Brunswick	",:postal_code=>"	E2M 4X5	",:phone=>"	(506) 633-2256	",:description=>"8am to 10pm Monday-Saturday 12pm - 5pm Sunday",:lat=>	45.2563442	,:lng=>	-66.0927721	},
  {:store_chain_id => 1,:name => "	Ken-Val Co-op Food Market	",:street_address=>"	1 Market Street	",:city=>"	Quispamsis	",:province=>"	New Brunswick	",:postal_code=>"	E2E 4B1	",:phone=>"	(506) 849-6520	",:description=>"8am to 9pm Monday-Saturday 12pm - 5pm Sunday",:lat=>	45.4158704	,:lng=>	-65.9476366	},
  {:store_chain_id => 3,:name => "	Walmart	",:street_address=>"	450 Westmorland Road	",:city=>"	Saint John	",:province=>"	New Brunswick	",:postal_code=>"	E2J 4Z2 	",:phone=>"	506-634-6600 	",:description=>"8am to 10pm Monday-Saturday 10am - 8pm Sunday",:lat=>	45.3078537	,:lng=>	-66.0198242	},

  {:store_chain_id => 2,:name => "	Rocca's nofrills	",:street_address=>"	269 Coxwell Ave	",:city=>"	Toronto	",:province=>"	Ontario	",:postal_code=>"	M4L 3B5	",:phone=>"	n/a	",:description=>"8am to 9pm Monday-Saturday 9am - 8pm Sunday",:lat=>	43.6736938	,:lng=>	-79.3195611	},
  {:store_chain_id => 3,:name => "	Food Basics",:street_address=>"	1277 York Mills Rd",:city=>"	Toronto",:province=>"	Ontario",:postal_code=>"	M3A 1Z5",:phone=>"	(416) 444-7921",:description=>"8am to 10pm Monday-Saturday 9am - 9pm Sunday",:lat=>	43.760648	,:lng=>	-79.3258039	},
  {:store_chain_id => 3,:name => "	Price Chopper	",:street_address=>"	731 Eastern Avenue	",:city=>"	Toronto	",:province=>"	Ontario	",:postal_code=>"	M4M 1E6	",:phone=>"	(416) 465-7360	",:description=>"8am to 10pm Monday-Friday 8am - 8pm Saturday 9am - 8pm Sunday",:lat=>	43.6601994	,:lng=>	-79.3310941	},
  {:store_chain_id => 2,:name => "	Real Canadian Superstore	",:street_address=>"	825 Don Mills Road	",:city=>"	Toronto	",:province=>"	Ontario	",:postal_code=>"	M3C 1V4	",:phone=>"	(416) 391-0080	",:description=>"	7 days a week 7am-11pm	",:lat=>	43.7207253	,:lng=>	-79.3388117	},
  {:store_chain_id => 1,:name => "	Sobeys	",:street_address=>"	22 Balliol St	",:city=>"	Toronto	",:province=>"	Ontario	",:postal_code=>"	M4S 1C1 	",:phone=>"	(416) 485-1022	",:description=>"	8 days a week 7am-11pm	",:lat=>	43.6973858	,:lng=>	-79.3963622	}

])

