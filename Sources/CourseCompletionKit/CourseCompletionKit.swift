import SwiftUI

public struct CompleteCourseView: View {
    var settings: CourseCompletionAssets
    var courseTitle: String
    var completionRate: Double
    var numPoints: Int
    
    public init(settings: CourseCompletionAssets, courseTitle: String, completionRate: Double, numPoints: Int) {
        self.settings = settings
        self.courseTitle = courseTitle
        self.completionRate = completionRate
        self.numPoints = numPoints
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 30) {
            
            Image(settings.completeCourseIcon)
                .padding(.top, 30)
            
            Text("Congratulations!")
                .font(.custom(settings.titleFont, size: 20))
                .foregroundColor(Color(settings.mainTextColor))
            
            Group {
                Text("You have successfully complete ")
                    .font(.custom(settings.descriptionFont, size: 14))
                    .foregroundColor(Color(settings.descriptionTextColor)) +
                
                Text(String(courseTitle))
                    .font(.custom(settings.titleFont, size: 14))
                    .foregroundColor(Color(settings.primaryColor)) +
                
                Text(". Complete more course like this to earn more points.")
                    .font(.custom(settings.descriptionFont, size: 14))
                    .foregroundColor(Color(settings.descriptionTextColor))
            }.multilineTextAlignment(.center)
             .fixedSize(horizontal: false, vertical: true)
             .padding(.horizontal, 20)
            
            
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack(alignment: .firstTextBaseline) {
                        StarsView(color: Color(settings.primaryColor), rating: Float(completionRate))
                        Text(String(completionRate))
                            .font(.custom(settings.descriptionFont, size: 14))
                            .foregroundColor(Color(settings.primaryColor))
                    }
                    
                    Text("Completion Rate")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.mainTextColor))
                    
                }.frame(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height/8)
                
                Divider()
                    .frame(height: UIScreen.main.bounds.height/20)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(String(numPoints) + " Points")
                        .font(.custom(settings.titleFont, size: 20))
                        .foregroundColor(Color(settings.primaryColor))
                    
                    Text("Scores Earned")
                        .font(.custom(settings.descriptionFont, size: 14))
                        .foregroundColor(Color(settings.mainTextColor))
                    
                }.frame(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height/8)
            }.fixedSize()
            
            Spacer()
            
            Button(
                action: {
                    NavigationUtil.popToRootView()
                }, label: {
                    Text("Done")
                        .font(Font.custom(settings.titleFont, size: 16))
                        .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
                        .background(Color(settings.primaryColor))
                        .accentColor(Color(settings.buttonTextColor))
                        .cornerRadius(UIScreen.main.bounds.width/35)
                        .padding(.bottom, UIScreen.main.bounds.height/30)
                }
            )
            
        }.padding()
            .navigationBarHidden(true)
    }
}


public struct StarsView: View {
  private static let MAXRATING: Float = 5
  var color: Color
  var rating: Float
    
  private let fullCount: Int
  private let emptyCount: Int
  private let halfFullCount: Int

    public init(color: Color, rating: Float) {
    self.color = color
    self.rating = rating
    fullCount = Int(rating)
    emptyCount = Int(StarsView.MAXRATING - rating)
    halfFullCount = (Float(fullCount + emptyCount) < StarsView.MAXRATING) ? 1 : 0
  }

  public var body: some View {
      HStack(spacing: 2) {
          ForEach(0..<fullCount, id: \.self) { _ in
         self.fullStar
       }
       ForEach(0..<halfFullCount, id: \.self) { _ in
         self.halfFullStar
       }
       ForEach(0..<emptyCount, id: \.self) { _ in
         self.emptyStar
       }
     }
  }

  private var fullStar: some View {
      Image(systemName: "star.fill").foregroundColor(self.color)
  }

  private var halfFullStar: some View {
      Image(systemName: "star.lefthalf.fill").foregroundColor(self.color)
  }

  private var emptyStar: some View {
      Image(systemName: "star").foregroundColor(self.color)
  }
}


public struct NavigationUtil {
  static func popToRootView() {
    findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
      .popToRootViewController(animated: true)
  }

  static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
    guard let viewController = viewController else {
      return nil
    }

    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }

    for childViewController in viewController.children {
      return findNavigationController(viewController: childViewController)
    }

    return nil
  }
}
