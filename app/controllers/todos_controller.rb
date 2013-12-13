#encoding: utf-8
class TodosController < ApplicationController
  layout "layout_v2/application"

  before_filter :find_todo, only: [:show, :edit, :update, :destroy]
  before_filter :find_todo_type, only: [:new, :edit]

  respond_to :html, :js

  def index
    @todos = Todo.all
  end

  def show; end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.create(params[:todo])
    @todo.set_todo_type(params)
  end

  def edit; end

  def update
    @todo.update_attributes(params[:todo])
  end

  def destroy
    @todo.destroy
  end

  private

  def find_todo
    @todo = Todo.find(params[:id])
  end

  def find_todo_type
    @taggroups = Taggroup.all
      .select { |d| d.type == "todo" }
      .sort { |a, b| a.label <=> b.label }
  end
end

