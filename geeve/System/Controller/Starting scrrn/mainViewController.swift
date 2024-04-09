//
//  mainViewController.swift
//  geeve App
//
//  Created by Dev Navadiiya on 26/02/24.
//

import UIKit

class mainViewController : UIViewController {
    
    
    
    
    
    
    
    @IBOutlet weak var collection_view: UICollectionView!
    
    @IBOutlet weak var page_controler: UIPageControl!
    
    @IBOutlet weak var creatAccount: UIButton!
    
    @IBOutlet weak var Login_butoon: UIButton!
    
    
    
    var curruntPage = 0
    
    
    
    var slides :  [onbordingslide] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collection_view.dataSource = self
        self.collection_view.delegate = self
        
        slides = [onbordingslide(tital: "Let’s get started", discription: "Ladies and gentlemen, esteemed guests, and philanthropic souls, welcome to the launch of Geeve, an innovative donation app poised to revolutionize the way we give back. With Geeve, we're not just introducing a platform; we're ushering in a movement of compassion and solidarity. Our mission is simple yet profound: to bridge the gap between those who have the means to give and those in need. Whether it's supporting local charities, aiding disaster relief efforts, or funding crucial research, Geeve empowers users to make a tangible difference in the lives of others. Today, we invite you to join us in this journey of generosity and impact. Welcome to Geeve, where every act of kindness, big or small, has the power to change lives. Thank you." , image: UIImage(named: "Image 3")!) , onbordingslide(tital: "Welcome", discription: "Ladies and gentlemen, esteemed guests, and philanthropic souls, welcome to the launch of Geeve, an innovative donation app poised to revolutionize the way we give back. With Geeve, we're not just introducing a platform; we're ushering in a movement of compassion and solidarity. Our mission is simple yet profound: to bridge the gap between those who have the means to give and those in need. Whether it's supporting local charities, aiding disaster relief efforts, or funding crucial research, Geeve empowers users to make a tangible difference in the lives of others. Today, we invite you to join us in this journey of generosity and impact. Welcome to Geeve, where every act of kindness, big or small, has the power to change lives. Thank you.", image: UIImage(named: "Image 3")!) , onbordingslide(tital: "Help", discription: "Ladies and gentlemen, esteemed guests, and philanthropic souls, welcome to the launch of Geeve, an innovative donation app poised to revolutionize the way we give back. With Geeve, we're not just introducing a platform; we're ushering in a movement of compassion and solidarity. Our mission is simple yet profound: to bridge the gap between those who have the means to give and those in need. Whether it's supporting local charities, aiding disaster relief efforts, or funding crucial research, Geeve empowers users to make a tangible difference in the lives of others. Today, we invite you to join us in this journey of generosity and impact. Welcome to Geeve, where every act of kindness, big or small, has the power to change lives. Thank you.", image: UIImage(named: "Image 3")!)]
    }
    
    @IBAction func CreateAccount_Action(_ sender: Any) {
        
        navigateToViewController(main: "Main", storyboard: "sing_Page_ViewController", navigationController: self.navigationController )
        
    }
    
    
    @IBAction func logIn_action(_ sender: Any) {
        
        navigateToViewController(main: "Main", storyboard: "singInViewController", navigationController: self.navigationController)
        
    }
    
    
}


// MARK: - Collection Delegate Methode -

extension mainViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: splach_CollectionViewCell.identifire   , for: indexPath) as! splach_CollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        curruntPage = Int(scrollView.contentOffset.x / width)
        page_controler.currentPage = curruntPage
        
    }
    
    
    
}
 
