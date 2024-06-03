module ArticlesHelper
    def date(datetime)
        datetime.strftime('%B %e, %Y')
    end
end
