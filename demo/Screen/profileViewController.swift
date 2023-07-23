//
//  profileViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var bottleButton:UIButton!
    @IBOutlet weak var EWButton: UIButton!
    @IBOutlet weak var MOButton: UIButton!
    @IBOutlet weak var MetalButton:UIButton!
    @IBOutlet weak var logolImage: UIImageView!
    @IBOutlet weak var monthLabbel: UILabel!
    @IBOutlet weak var progressLebek: UILabel!
    public var pointsRecycle = 0;
    public var monthPoints = 0;
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logolImage.image = UIImage(named: "point-green")!
        
        //if monthPoints > 2 {
            //    logolImage.image = UIImage(named: "point-green")!
        //}
        //else if monthPoints < 1 {
          //  logolImage.image = UIImage(named: "point_red")!
        //}
        // Do any additional setup after loading the view.
    }
    
    private func showMGoal(){
        //let vc = BottleMapViewController.self
        //var bottle = vc.bottlePoints
        //monthPoints=monthPoints + bottle
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
