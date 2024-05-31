import UIKit
import WebKit


class AboutViewController: UIViewController {
    
  @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
      super.viewDidLoad()

      if let url = Bundle.main.url(
        forResource: "number", withExtension: "html") {
      let request = URLRequest(url: url)
        webView.load(request)
      }
    }

    
  @IBAction func backToGame() {
      
    dismiss(animated: true, completion: nil)
  }
}
