# mercure-chat


1) Install some missing packages:
   composer require symfonycasts/verify-email-bundle
2) In RegistrationController::verifyUserEmail():
    * Customize the last redirectToRoute() after a successful email verification.
    * Make sure you're rendering success flash messages or change the $this->addFlash() line.
3) Review and customize the form, controller, and templates as needed.
4) Run "php bin/console make:migration" to generate a migration for the newly added User::isVerified property.

