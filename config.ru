require './config/environment'

use Rack::MethodOverride
use UsersController
use FamilyMembersController
use BloodPressureReadingsController
use MedicationsController
use PharmaciesController
use PhysiciansController
run ApplicationController
