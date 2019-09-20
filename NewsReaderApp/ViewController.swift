import UIKit
import Alamofire

class ViewController: UIViewController ,UITableViewDataSource,UITextFieldDelegate{
//ニュース一覧を格納する配列
var newsDateArray = NSArray()
    //テーブルビュー
    @IBOutlet var table :UITableview!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table ViewのDataSource参照先指定
        table.delegate = self
        // Table Viewのタップ時のdelegate先を指定
        table.delegate = self
        // ニュース情報の取得先
        let requestUrl = "http://appcre.net/rss.php"
        // webサーバーに対してHTTP通信のリクエストを出してデータを取得
        Alamofire.request(.GET,requestUrl).responseJSON{ response in
        switch response.result{
        case .Sucsses(let json):
        //JSONデータをNSDictionaryに
        let jsonDic = json as! NSDictionary
        
        
        //辞書化したjsonDicからキー値"result"を取り出す
        self.newsDateArray = responseData["results"] as! NSArray
        print("\(self.newsDateArray)")
        //ニュース記事を取得したらテーブルビューを表示
        self.table.readData()
        case .Failure(let error):
        print("通信エラー:\(error)")
                
        }
            
        }
    }
  //テーブルビューのセル数をnewsDateArrayに格納しているデータの数で設定
    func tableView(tableView: UITableview,numberOfRowsInSection section: Int) -> Int {
        return newsDateArray.count
    }
  //セルに表示する内容を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //ストーリーボードで取得したCellを取得
        let cell =UITableViewCell(style:UITableViewCellStyle.Subtitle,reuseIdentifier: "Cell")
    //ニュース記事データを取得
        let newsDic = newsDateArray[indexPath.row] as! NSDictionary
    //タイトルとタイトルの行数、公開日時をCellにセット
    Cell.textLabel!.text = newsDic["title"] as? String
    Cell.textLabel!.numberOfLines = 3
    Cell.detailTextLabel!.text = newsDic ["publishedDate"]
        as? String
    return cell
    }
    func tableView(tableView:UITableView,didSelectRowAtIndex)
    }
}

