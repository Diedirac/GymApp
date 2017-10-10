//
//  TrainingManageViewController.swift
//  GymeFit
//
//  Created by Chuan Yen Fu on 2017/9/14.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit
import CVCalendar

class TrainingManageViewController: UIViewController {
    var currentCalendar: Calendar!
    
    @IBOutlet weak var calendarBar: UINavigationBar!
    @IBOutlet weak var calendarItem: UINavigationItem!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.4, blue: 0.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.calendarBar.tintColor = UIColor.lightGray
        self.calendarBar.items = [calendarItem]
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.todayButtonTapped))
        todayButton.tintColor = UIColor.red
        self.calendarItem.setLeftBarButton(todayButton, animated: true)
        
        currentCalendar = Calendar.init(identifier: .gregorian)
        
        self.calendarItem.title = CVDate(date: Date(), calendar: currentCalendar).globalDescription
        self.menuView.menuViewDelegate = self
        self.calendarView.calendarDelegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc private func todayButtonTapped() {
        let today = Date()
        calendarView.toggleViewWithDate(today)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrainingManageViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        self.calendarItem.title = date.globalDescription
    }
    
    func topMarker(shouldDisplayOnDayView dayView: DayView) -> Bool {
        return true
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {

    }
    
}
