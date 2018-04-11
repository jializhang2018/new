class CoursesController < ApplicationController

  def index

  end

  def show

  end

  def destroy
    id = params["id"]
    course = Course.find(id)
    if course != nil
      course.delete
    end
    redirect_to "/courses"
  end

  def new

  end

  def create
    puts params["title"]
    print params["day_of_week"]
    print params["time_begin_hour"]
      print  params["time_begin_min"]
        print  params["time_begin_ampm"]
    print params["time_end_hour"]
      print params["time_end_min"]
        print  params["time_end_ampm"]

    m = Course.new
    m.title = params["title"]
    m.day_of_week = params["day_of_week"]
    m.time_begin = params["time_begin_hour"] + ":" + params["time_begin_min"] + " " + params["time_begin_ampm"]
    m.time_end = params["time_end_hour"] + ":" + params["time_end_min"] + " " + params["time_end_ampm"]
    if m.title == "" || params["day_of_week"] == "" || params["time_begin_hour"] == "" || params["time_begin_min"] == ""||
      params["time_begin_ampm"] == "" || params["time_end_hour"] == "" || params["time_end_min"] == "" || params["time_end_ampm"] == ""
      redirect_to "/courses/new"
      return
    end
    h1 = Integer(params["time_begin_hour"])
    if params["time_begin_ampm"] == "PM"
      h1 += 12
    end
    m1 = Integer(params["time_begin_min"])

    h2 = Integer(params["time_end_hour"])
    if params["time_end_ampm"] == "PM"
      h2 += 12
    end
    m2 = Integer(params["time_end_min"])

    if h1 > h2 || (h1 == h2 && m1 >= m2)
      redirect_to "/courses/new"
      return
    else
  m.save
      redirect_to "/courses"
      return
    end
  end

  def edit

  end

  def update
    id = params["id"]
    course = Course.find(id)
    course.title = params["title"]
    course.day_id = params["day_id"]
    course.time = params["time"]
    course.save
    redirect_to "/courses"
  end

end
