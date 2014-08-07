# Layer for creating and displaying folds
class FoldLayer < Layer
    @folds = []

    def add_fold! fold
        @folds << fold
    end

end
