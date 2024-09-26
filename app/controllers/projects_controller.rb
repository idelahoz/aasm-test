class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :start_planning, :start_development, :complete, :archive, :reopen]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Proyecto creado con éxito.'
    else
      render :new
    end
  end
  

  def show
  end

  def start_planning
    @project.start_planning!
    redirect_to @project, notice: "El proyecto ahora está en la fase de planificación."
  end

  def start_development
    @project.start_development!
    redirect_to @project, notice: "El proyecto ahora está en desarrollo."
  end

  def complete
    @project.complete!
    redirect_to @project, notice: "El proyecto ha sido completado."
  end

  def archive
    @project.archive!
    redirect_to @project, notice: "El proyecto ha sido archivado."
  end

  def reopen
    @project.reopen!
    redirect_to @project, notice: "El proyecto ha sido reabierto y vuelve a planificación."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
