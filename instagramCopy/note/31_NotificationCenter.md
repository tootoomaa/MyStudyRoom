# Notification

앱에서 사용자에게 알람을 띄워주는 역활



## 적용 방법

1. 프로젝트에 `Push Notifications` Capabilities추가 

   - Xcode 프로젝트 이름 선택 -> Sign&Capabilitues -> Capability -> Push Notification 
     - ![200905_NotificationfeatureAdd](/Users/kimkwangsoo/Document/dev/MyStudyRoom/instagramCopy/image/200905_NotificationfeatureAdd.png)
   - 정상적으로 적용된 모습
     - ![200905_NotificationfeatureAddComplete](/Users/kimkwangsoo/Document/dev/MyStudyRoom/instagramCopy/image/200905_NotificationfeatureAddComplete.png)

2. AppDelegate에 UserNotifications 관련 코드 추가

   - 소스코드 

     - ```swift
       import UserNotifications // 추가
       
       class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
       
         var window: UIWindow?
       
         func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           // Override point for customization after application launch.
       
           FirebaseApp.configure()
       
           window = UIWindow()
           window?.rootViewController = MainTabVC()
       
           attempToRegisterForNotifications(application: application)
       
           return true
         }
         
         func attempToRegisterForNotifications(application: UIApplication) {
       
           UNUserNotificationCenter.current().delegate = self
       
           let options: UNAuthorizationOptions = [.alert, .badge, .sound]
       
           UNUserNotificationCenter.current().requestAuthorization(options: options) { (authorized, error) in
       			if authorized {
       					print("DEBUG: Successfully Registered for Notification")
       			}
       		}
           application.registerForRemoteNotifications()
         }
       
         func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           print("DEBUG: Registered for Notification with Deivece Toekn", deviceToken)
         }
       
       ```

3. 권한 승인 팝업 확인

![200905_NotificationAlert](/Users/kimkwangsoo/Document/dev/MyStudyRoom/instagramCopy/image/200905_NotificationAlert.png)

4. PodFile 수정 및 설치
   - `  pod 'Firebase/Messaging'` 추가 
   - pod install
5. 























### Referense 

-  [Firebase Cloud Messaging | Send notifications across platforms for free](https://firebase.google.com/products/cloud-messaging/?gclid=Cj0KCQjwy8f6BRC7ARIsAPIXOjhOAURv5lm5C66R54If6i0sKunMmucUP1W79iQBMlA28ocUHUIDkBMaApHjEALw_wcB) 

