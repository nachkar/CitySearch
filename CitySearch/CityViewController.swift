//
//  CityViewController.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit
import MapKit

class CityViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!

    var viewModel: CityMapViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handleViewModel()
    }
    
    func handleViewModel() {
        weak var weakself = self
        
        viewModel.didFinishProcessing = {
            let selectedLocPoint = MKPointAnnotation()
            selectedLocPoint.title = weakself?.viewModel.name
            selectedLocPoint.coordinate = CLLocationCoordinate2D(latitude: (weakself?.viewModel.coord!.lat)!, longitude: (weakself?.viewModel.coord!.lon)!)
            weakself?.mapView.addAnnotation(selectedLocPoint)
            
            selectedLocPoint.title = weakself?.viewModel.name
            weakself?.title = weakself?.viewModel.name
            
            let mapCamera = MKMapCamera(lookingAtCenter: selectedLocPoint.coordinate, fromEyeCoordinate: selectedLocPoint.coordinate, eyeAltitude: 1000.0)
            weakself?.mapView.setCamera(mapCamera, animated: true)
        }
        
        viewModel.didFinishLoading()
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
