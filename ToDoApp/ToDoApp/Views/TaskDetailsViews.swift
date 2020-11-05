//
//  AddTasksViews.swift
//  ToDoList
//
//  Created by Gaida  on 02/11/2020.
//

import Foundation
import UIKit
import Lottie

class AddTaskView: UIView {
   

    
    weak var delegate:TasksDetaileDelegate?

    override init (frame : CGRect) {
        super.init(frame : frame)

        configureUI()
    }

    convenience init () {
        self.init(frame:UIScreen.main.bounds)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    var pickedDate : Date = Date()
    let animationCheckView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.setDimensions(height: 120, width: 120)
        return view
    }()
    
   
    
    let myView: UIView = {
        let view = UIView()
          view.backgroundColor = UIColor.red
          view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let HeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New Task"
        label.font = UIFont.monospacedSystemFont(ofSize: 40, weight: .regular)
       // label.backgroundColor = .cyan
        label.textColor = .offWhite
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setDimensions(height: 50, width: 350)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .lightPeach
        stack.allRoundedConrners(radius: 20)
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
    let TitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Task Title"
        label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setDimensions(height: 50, width: 350)
        return label
    }()
    
    let DateLabel: UILabel = {
        let label = UILabel()
        label.text = "Due Date"
        label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
            //UIFont.boldSystemFont(ofSize: 20)
        //label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
       label.setDimensions(height: 50, width: 350)
        return label
    }()
    
   
    
    let TitleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Set Task Title"
        field.textAlignment = .center
        field.font = UIFont.monospacedSystemFont(ofSize: 19, weight: .bold)
      
        
        field.allRoundedConrners()
        field.textColor = .darkPeach
        field.translatesAutoresizingMaskIntoConstraints = false
        field.setDimensions(height: 50, width: 350)
        return field
    }()
    
    let datePicker : UIDatePicker = UIDatePicker()
    

    
    let ExtraNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Additional Notes "
        label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setDimensions(height: 50, width: 350 )
        return label
    }()
    
    func setDatePicker(){
    datePicker.datePickerMode = .dateAndTime
    datePicker.center =  center
    //datePicker.backgroundColor = .lightPink
    datePicker.allRoundedConrners()
    datePicker.setDimensions(height: 50, width: 350)
    datePicker.addTarget(self, action: #selector(pickDate(_:)), for: .valueChanged)
    }
    
     var textView: UITextView = {
        let textview = UITextView()
        textview.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        textview.backgroundColor = .offWhite
        textview.font = UIFont.monospacedSystemFont(ofSize: 19, weight: .light)
        textview.textAlignment = .justified
        textview.textColor = .darkPeach
        textview.allRoundedConrners()
        textview.setDimensions(width: 350)
        return textview
    }()
    
     let doneButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Done", for: .normal)
        but.setTitleColor(.black, for: .normal)
       
        but.setDimensions(height: 100, width: 100)
        but.layer.cornerRadius = 100 / 2
        but.clipsToBounds = true
        but.backgroundColor = .peachyPink
    
        but.layer.shadowOffset = CGSize(width: 0, height: 1)
        but.layer.shadowColor = UIColor.lightGray.cgColor
        but.layer.shadowOpacity = 1
        but.layer.shadowRadius = 5
        but.layer.masksToBounds = false
        
        but.addTarget(self, action: #selector(doneButtonClicked(_:)), for: .touchUpInside)

        return but
    }()
    
    @objc func doneButtonClicked(_ sender: UIButton){
        print(" butoton")
        delegate?.GetNewTask(title: TitleField.text!,
                             date: pickedDate,
                             desc: textView.text)
    }
    
    
    private func configureUI(){
        addSubview(HeaderLabel)
        addSubview(stackView)
        addSubview(myView)
        
        insertSubview(animationCheckView, aboveSubview: stackView)
        
        let animationView = AnimationView(name: "check-circle")
        animationView.setDimensions(height: 120, width: 120)
        animationCheckView.addSubview(animationView)
        animationView.play()

        addSubview(doneButton)
        addConstraints()
        setAdditionalStacks()
        setDatePicker()

 
    }
    
    private func addConstraints(){
        //MARK: - set Header Constraint
        NSLayoutConstraint.activate( [

            HeaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            HeaderLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
       // MARK: - set Main Stack View Constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: HeaderLabel.bottomAnchor,constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10 ),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10)

        ])
        
        
        //MARK: - Add view constraints
        
        NSLayoutConstraint.activate([
            myView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -70),
            myView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 250),
            myView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 10)
        ])
      
        //MARK: - Add done button constraints
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            doneButton.centerYAnchor.constraint(equalTo: myView.centerYAnchor)
                                        ])
        //MARK: - Add image  constraints
        NSLayoutConstraint.activate([
            animationCheckView.topAnchor.constraint(equalTo: HeaderLabel.bottomAnchor, constant: -10),
            animationCheckView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -3)
                                        ])
        
    }
     
    func setAdditionalStacks(){
        let stackView2 = UIStackView(arrangedSubviews: [
            TitleLabel,
            TitleField
        ])
        stackView2.axis = .vertical
       // stackView2.backgroundColor = .lightGray
        stackView2.alignment = .center
        stackView2.distribution = .fillEqually
        stackView2.spacing = 10
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackView2)

        //MARK: - set second stack constraints

        stackView2.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true


        let stackView3 = UIStackView(arrangedSubviews: [
                                        DateLabel,
                                        datePicker])
        stackView3.axis = .vertical
       // stackView3.backgroundColor = .systemPink
        stackView3.alignment = .center
        stackView3.distribution = .fillEqually
        stackView3.spacing = 10
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackView3)


        //MARK: - set third stack constraints

        stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 20).isActive = true

        let stackView4 = UIStackView(arrangedSubviews: [
                                        ExtraNoteLabel,
                                        textView])
        stackView4.axis = .vertical
        stackView4.alignment = .center
        stackView4.distribution = .fill
        stackView4.spacing = 10
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackView4)


        //MARK: - set third stack constraints

        stackView4.topAnchor.constraint(equalTo: stackView3.bottomAnchor, constant: 20).isActive = true
        stackView4.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -20).isActive = true
   }
    
    
    
@objc func pickDate(_ picker: UIDatePicker){
    pickedDate = picker.date
    delegate?.GetDate(date: picker.date)
}
    
    
}
