class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :set_course, only: [:show, :edit, :update, :destroy, :approve]
  helper_method :courses_title, :courses_search_title, :courses_overview_title

  def index
    courses = filter_courses(Course.includes(:comments)).approved
    render locals: { courses: courses, courses_title: courses_title }
  end

  def show
    @comments = @course.comments
    @comment = @course.comments.build
    @rating = @course.rating
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to root_path, notice: 'Спасибо за предложенный курс!'
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Курс был успешно обновлен.'
    else
      render :edit
    end
  end

  def approve
    @course.approve!
    redirect_to @course, notice: 'Курс был одобрен.'
  end

  private

  def courses_title
    @courses_title ||= "#{paid_param_title} по Ruby #{language_param_title}"
  end

  def courses_search_title
    @courses_search_title ||= if params[:title].present?
                                "Созвучные с «#{params[:title]}»"
                              else
                                ''
                              end
  end

  def courses_overview_title
    @courses_overview_title ||=
      "#{courses_amount_title} #{comments_amount_title} #{courses_suffix}"
  end

  def courses_amount_title
    courses_size = 1
    "#{courses_size} #{t('words.course', count: courses_size)}"
  end

  def comments_amount_title
    comments_size = 0
    "и #{comments_size} #{t('words.comment', count: comments_size)}"
  end

  def courses_suffix
    courses_size = 1
    t('words.courses_suffix', count: courses_size)
  end

  def paid_param_title
    case params[:paid]
    when '1'
      'Платные курсы'
    when '0'
      'Бесплатные курсы'
    else
      'Курсы'
    end
  end

  def language_param_title
    case params[:language]
    when 'Русский'
      'на русском'
    when 'English'
      'на английском'
    else
      ''
    end
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :language, :url, :paid)
  end

  def filter_courses(courses)
    title = params[:title] unless params[:title].blank?
    paid = params[:paid] if %w(1 0).include?(params[:paid])
    language = params[:language] if %w(Русский English).include?(params[:language])

    courses = courses.where('title ILIKE ?', "%#{title}%") if title.present?
    courses = courses.where(paid: paid) if paid.present?
    courses = courses.where(language: language) if language.present?
    courses
  end
end
