module PaginationHandler
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def paginate_object(objects)
    param_page = integer_parser(params[:page])
    param_per_page = integer_parser(params[:per_page])

    page = param_page || DEFAULT_PAGE
    per_page = param_per_page || DEFAULT_PER_PAGE

    paginated_objects = objects.paginate(page: page, per_page: per_page)

    { data: paginated_objects, pagination: { page: page, per_page: per_page } }
  end

  private

  def integer_parser(param)
    Integer(param) rescue nil
  end
end
