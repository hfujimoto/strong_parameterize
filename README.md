# Strong Paramations

**Strong Paramations** gives your Rails app generator to convert all
attr_accessible to [strong_parameters](https://github.com/rails/strong_parameters)

## Getting Started

### Enabling the generators

Add `gem "strong_paramations"` to the development group in your `Gemfile`.  
You can do this by adding the line

    `gem "strong_paramations", :group => :development`
    
_or_ if you prefer the block syntax

    group :development do 
      # ... 
      gem "strong_paramations"            # Add this line 
      # ... 
    end

### Converting attr_accessible to strong_parameters

convert all models:

    rails generate strong_paramations:convert_attr_accessibles:all

_or_ specify the model name:

    rails generate strong_paramations:convert_attr_accessibles user

such as the following result:

```diff
--- a/MY_AWESOME_APP/app/controllers/users_controller.rb
+++ b/MY_AWESOME_APP/app/controllers/users_controller.rb
@@ -55,4 +55,12 @@ class UsersController < ApplicationController
       format.json { head :ok }
     end
   end
+
+  module StrongParameters
+    private
+    def user_params
+      params.require(:user).permit(:name, :age)
+    end
+  end
+  include StrongParameters
 end
diff --git a/MY_AWESOME_APP/app/models/user.rb b/MY_AWESOME_APP/app/models/user.rb
index 0878e9e..c6afd7f 100644
--- a/MY_AWESOME_APP/app/models/user.rb
+++ b/MY_AWESOME_APP/app/models/user.rb
@@ -1,3 +1,3 @@
 class User < ActiveRecord::Base
-  attr_accessible :name, :age
+  # attr_accessible :name, :age
 end
```

## License

Copyright (c) AOKI Yuuto and [contributors](https://github.com/wneko/strong_paramations/contributors). See LICENSE for further details.
