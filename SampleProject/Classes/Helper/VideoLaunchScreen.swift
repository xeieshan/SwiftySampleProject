/*
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {
  var window: UIWindow?
  var moviePlayer: MPMoviePlayerViewController!
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      var movieUrl: NSURL!
      // Adding the movie animation while application starts.
      movieUrl = NSBundle.mainBundle().URLForResource("Launch_animation_mov", withExtension: "mov")!
      moviePlayer = MPMoviePlayerViewController(contentURL: movieUrl)
      moviePlayer.moviePlayer.scalingMode = MPMovieScalingMode.Fill
      moviePlayer.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
      let backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
      backGroundView.backgroundColor = UIColor.whiteColor()
      moviePlayer.moviePlayer.backgroundView.addSubview(backGroundView)
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerEnd:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
      moviePlayer.moviePlayer.setFullscreen(true, animated: false)
      moviePlayer.moviePlayer.controlStyle = MPMovieControlStyle.None
      moviePlayer.moviePlayer.repeatMode = MPMovieRepeatMode.None
      moviePlayer.moviePlayer.play()
      window!.rootViewController = moviePlayer
      self.window?.makeKeyAndVisible()
      
      return true
  }
  
  func moviePlayerEnd(notification: NSNotification) {
      DLog("Movie player did end playing")
      NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
      // TO prevent the black screen when movie ends.
      if self.moviePlayer == self.moviePlayer {
          self.moviePlayer.moviePlayer.pause()
      }
      // View controller you want to show when launch video ends.
      let destinationVC = TabBarController()
      // Make sure it will match the appearing view background color.
      destinationVC.view.backgroundColor = UIColor.whiteColor()
      
      // Trantion of rootViewcontroller from appdelegate to make it smoother using UIView.transitionWithView.
      UIView.transitionWithView(self.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve , animations: { () -> Void in
          self.window?.rootViewController = destinationVC
          }, completion: nil)
      
      
      self.window?.makeKeyAndVisible()
      if self.moviePlayer != nil{
          /* We got the thumbnail image. You can now use it here */
          if self.moviePlayer == self.moviePlayer {
              self.moviePlayer.moviePlayer.stop()
              self.moviePlayer.moviePlayer.view.removeFromSuperview()
              self.moviePlayer = nil
          }
      }
  }
}*/