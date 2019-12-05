//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Rushikesh on 04/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
      func showActivityIndicator(toggle: Bool){
          DispatchQueue.main.async {
              UIApplication.shared.isNetworkActivityIndicatorVisible = toggle
          }
      }
}


