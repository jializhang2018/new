class RidesController < ApplicationController

  def index

  end

  def show

  end

  def destroy

  end

  def new

  end

  def create
    ride = Ride.new
    ride.passenger_name = params["passenger_name"]
    ride.origin = params["origin"]
    ride.destination = params["destination"]
    ride.complete = false
    ride.driver_id = -1
    ride.save
  end

  def edit
    
  end

  def update
    name = params["name"]
    if name == "assign"
      id = params["id"]
      driver_id = params["driver_id"]
      ride = Ride.find(id)
      ride.driver_id = driver_id
      ride.save
      driver = Driver.find(driver_id)
      driver.assigned = true
      driver.save
      redirect_to "/rides"
    else
      id = params["id"]
      driver_id = params["driver_id"]
      ride = Ride.find(id)
      ride.complete = true
      ride.save
      driver = Driver.find(driver_id)
      driver.assigned = false
      driver.save
      redirect_to "/rides"
    end
  end

end
