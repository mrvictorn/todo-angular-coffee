angular.module 'simple-todos',['angular-meteor'] 

Accounts.ui.config
  passwordSignupFields: "USERNAME_ONLY"

onReady = ->
  angular.bootstrap document, ['simple-todos']

if Meteor.isCordova
  angular.element(document).on 'deviceready', onReady
else
  angular.element(document).ready onReady

angular.module('simple-todos').controller 'TodosListCtrl', ['$scope', '$meteor',
  ($scope, $meteor) ->
    $scope.query = {}

    $scope.tasks = $meteor.collection () ->
      Tasks.find $scope.getReactively 'query',
        sort:
          createdAt:-1 

    $scope.addTask = (newTask) ->
      $scope.tasks.push
        text: newTask
        createdAt: new Date()
        owner: Meteor.userId()
        username: Meteor.user().username 

    $scope.$watch 'hideCompleted' , ->
      if $scope.hideCompleted
        $scope.query = 
          checked: 
            $ne: true
      else
        $scope.query = {}

    $scope.incompleteCount = ->
      Tasks.find({ checked: {$ne: true} }).count();

]