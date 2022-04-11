//
//  ViewController.swift
//  StarCount
//
//  Created by ditthales on 24/03/22.
//

import UIKit

class ViewController: UIViewController {

    //Here goes the views =)

    @IBOutlet var logoInicioInicio: UIView!
    @IBOutlet var appView: UIView!
    @IBOutlet var selectLight: UIView!
    @IBOutlet var selectEye: UIView!
    @IBOutlet var selectSky: UIView!
    @IBOutlet var hiddenInfoSky: UIView!
    @IBOutlet var hiddenInfoEye: UIView!
    @IBOutlet var hiddenInfoLight: UIView!
    @IBOutlet var selectorView: UIView!
    @IBOutlet var hiddenInfos: UIView!
    @IBOutlet var resultView: UIView!
    @IBOutlet var pickerView: UIView!
    
    //Here goes the sliders =)
    @IBOutlet var sliderSky: UISlider!
    @IBOutlet var sliderEye: UISlider!
    @IBOutlet var sliderLight: UISlider!
    
    //Here goes the labels =)
    @IBOutlet var xLabel: UILabel!
    @IBOutlet var sliderNumberLabel: UILabel!
    
    //Here goes the buttons, but outlets =)
    @IBOutlet var buttonArrowOutlet: UIButton!
    @IBOutlet var buttonSkyOutlet: UIButton!
    @IBOutlet var buttonEyeOutlet: UIButton!
    @IBOutlet var buttonLightOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appView.alpha = 0
        logoInicioInicio.alpha = 0
        UIView.animate(withDuration: 1){
            self.logoInicioInicio.alpha = 1
        }
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            UIView.animate(withDuration: 1){
                self.logoInicioInicio.alpha = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.appView.alpha = 1
        }
    }
    
    //Here goes the function when you press the arrow (go) button
    @IBAction func buttonArrow() {
        /*
         1. identifies if the app is on the input view or the output view
         2. If the app is on the input view:
            2.1.1. animate the button to rotate PI rad
            2.1.2. pick up the results and put them into variables
            2.1.3. calculate the result (n)
            2.1.4. put the result into the label (x)
            2.1.1. input view isHidden = true
            2.1.2. output view isHidden = false
            
         */
        
        if resultView.isHidden == true{
            let dados = Condicao(sky: sliderSky.value, light: sliderLight.value, eye: sliderEye.value)
            //let numberOfStars = calculateResult() <-- Older version w/o OOP
            let numberOfStars = dados.calcular()
            pickerView.isHidden = true
            resultView.isHidden = false
            buttonArrowOutlet.transform = buttonArrowOutlet.transform.rotated(by: CGFloat.pi)
            xLabel.text = String(numberOfStars)
        }else{
            pickerView.isHidden = false
            resultView.isHidden = true
            buttonArrowOutlet.transform = buttonArrowOutlet.transform.rotated(by: CGFloat.pi)
        }
        
    }
    
    //The next function is to show/hide the values of the sliders
    @IBAction func sliderChangingNumbers(_ sender: UISlider) {
        sliderNumberLabel.alpha = 1
        sliderNumberLabel.isHidden = false
        sliderNumberLabel.text = String(Int(sender.value))
        UIView.animate(withDuration: 1){
            self.sliderNumberLabel.alpha = 0
        }
    }

    
    //Here goes the function when you press the chevrons
    @IBAction func buttonOpenAll(_ sender: UIButton) {
        /*
         0. Identifies whats button is the sender, then:
         1. Identifies if the slider from Eye Capacity is opened or closed
         2. If the slider is closed:
                2.1.1 isHidden view => false (open the slider)
                2.1.2 animate the button (rotate PI rad)
            If the slider is opened:
                2.2.1 isHidden view => true (close the slider)
                2.2.2 animate the button (rotate PI rad)
                2.2.3 if is all hidden => hide the label number
        */
        
        if sender == buttonSkyOutlet{
            if hiddenInfoSky.isHidden == false{
                hiddenInfoSky.isHidden = true
                selectSky.isHidden = false
                buttonSkyOutlet.transform = buttonSkyOutlet.transform.rotated(by: CGFloat.pi)
            } else{
                hiddenInfoSky.isHidden = false
                selectSky.isHidden = true
                buttonSkyOutlet.transform = buttonSkyOutlet.transform.rotated(by: CGFloat.pi)
                if isAllHidden() == true{
                    sliderNumberLabel.isHidden = true
                }
            }
        }else if sender == buttonEyeOutlet{
            if hiddenInfoEye.isHidden == false{
                hiddenInfoEye.isHidden = true
                selectEye.isHidden = false
                buttonEyeOutlet.transform = buttonEyeOutlet.transform.rotated(by: CGFloat.pi)
            } else{
                hiddenInfoEye.isHidden = false
                selectEye.isHidden = true
                buttonEyeOutlet.transform = buttonEyeOutlet.transform.rotated(by: CGFloat.pi)
                if isAllHidden() == true{
                    sliderNumberLabel.isHidden = true
                }
            }
        }else if sender == buttonLightOutlet{
            if hiddenInfoLight.isHidden == false{
                hiddenInfoLight.isHidden = true
                selectLight.isHidden = false
                buttonLightOutlet.transform = buttonLightOutlet.transform.rotated(by: CGFloat.pi)
            } else{
                hiddenInfoLight.isHidden = false
                selectLight.isHidden = true
                buttonLightOutlet.transform = buttonLightOutlet.transform.rotated(by: CGFloat.pi)
                if isAllHidden() == true{
                    sliderNumberLabel.isHidden = true
                }
            }
        }
    }
        
    //Here is the function when you press the (?) button
    @IBAction func understandButton() {
        redirectToSafari()
    }
        
    //This function is to check if the all the sliders are hidden
    func isAllHidden() -> Bool{
        if selectSky.isHidden == true && selectLight.isHidden == true && selectEye.isHidden == true{
            return true
        }else{
            return false
        }
    }

    //This function redirects you to a safari web page
    func redirectToSafari(){
        guard let url = URL(string: "http://www.ditthales.tk/PT-BR") else { return }
        UIApplication.shared.open(url)
    }
    
}

//This class represents the conditions that the user sends, and has the method "calcular" which does the math behind the app
class Condicao{
    var sky: Float
    var light: Float
    var eye: Float
    
    init(sky: Float, light: Float, eye: Float){
        self.sky = 0.5 * (1 - (sky / 100))
        self.light = light / 100
        self.eye = eye / 100
    }
    
    func calcular() -> Int{
        let qt: Float = 9500.0
        let numberOfStars: Int
        numberOfStars = Int(qt * self.sky * (1 - self.light) * self.eye)
        return(numberOfStars)
    }
}
