


import UIKit


struct MyDataModel {
    
    var page:Int
    var total_pages:Int
    var per_page:Int
    var breweries:Array<Dictionary<String,Any>>
    
    
}


class ViewController: UIViewController {

    var ModelArray = Array<MyDataModel>()
    override func viewDidLoad() {
        super.viewDidLoad()
        webServiceCall()
        
    }

    func webServiceCall()
    {
        let service = ApiWebServiceCall()
       
        let UrlApi = "http://www.json-generator.com/api/json/get/cefkcgxlyW?indent=2"
        var urlString = UrlApi.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        service.getDataWith(url:urlString! ){ (result) in
            switch result {
            case .Success(let data):
             self.ModelArray.removeAll()
             self.getCompanylist(array:[data] )
            case .Error( _):
                break
              
                
                
                
            }
            
        }
        
        
        
    }

    private func getCompanylist(array: [[String: AnyObject]])
   {
    
    for i in 0  ..< array.count
        
    {
        var total_records = 0
        let per_page = array[i]["per_page"] as! Int
        let total_pages = array[i]["total_pages"] as! Int
        let page = array[i]["page"] as! Int
        let breweries = array[i]["breweries"] as! Array<Dictionary<String,Any>>;
       // let IndCode =  array[i]["IND_CODE"] as! Int
        if (array[i]["total_records"]as? NSNull) != nil {
            
            
             total_records = 0

            
            
            
        }
        if (array[i]["Growth"]  != nil) {
            
            
           total_records = array[i]["total_records"] as! Int

            
            
        }
    
      let Model1 = MyDataModel(page: page, total_pages: total_pages, per_page: per_page, breweries: breweries)
        ModelArray.append(Model1)
     
        print("Id",ModelArray[0].breweries[0]["id"]!)
        print("page",ModelArray[0].page)
    }
}
}
