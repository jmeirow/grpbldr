

=begin


The goal for this testing is to test those things that are controlled by the Controller and UI

This implies that this is NOT the place for testing those classes better tested in unit tests.

Example:


  SomeModel may have all sorts of validations on it.  TDD should have insured that SomeModel does the things 
  that make sense for it to do, ie, "discover" relevant validations. All of those validations should be tested
  in the unit tests for SomeModel.

  E2E tests that involve any views where SomeModel is read/updated/created/destroyed need only test ONE validation that 
  may be expected to be called from that view. The test is not to see if ALL validations on SomeModel work, those should
  have been taken care of in unit testing. The E2E test is only concerned that that the view is wired up to display validation
  errors. 


  GroupBuilder logic ultimately involves logic that must:

    1) distinguish data of one club from that of another.

    -- the remaining items all deal with data within one club

    2) distinguish between users
    3) ..meetings
    4) ..roles
    5) ..etc




    Create a club
      verify that the following were created
        member
          verify that member is an amdin
        default (regular) meeting type
        default (regular) agenda definition

    Create second meeting type
    Create second agenda

    Create roles  (create,delete,update,create)
    create role groups
    update agenda definition
    create agenda line items
    create agenda bottoms

    create 5 new members

    create 

  









    Donna 248 544 4402 

    Esther 248 969 9806






















=end