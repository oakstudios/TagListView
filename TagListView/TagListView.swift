//
//  TagListView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

@objc public protocol TagListViewDelegate {
    optional func tagPressed(title: String, tagView: TagView, sender: TagListView) -> Void
    optional func tagRemoveButtonPressed(title: String, tagView: TagView, sender: TagListView) -> Void
}

@IBDesignable
public class TagListView: UIView, UITextFieldDelegate {
    
    @IBInspectable public dynamic var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            for tagView in tagViews {
                tagView.textColor = textColor
            }
        }
    }
    
    @IBInspectable public dynamic var selectedTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            for tagView in tagViews {
                tagView.selectedTextColor = selectedTextColor
            }
        }
    }
    
    @IBInspectable public dynamic var tagBackgroundColor: UIColor = UIColor.grayColor() {
        didSet {
            for tagView in tagViews {
                tagView.tagBackgroundColor = tagBackgroundColor
            }
        }
    }
    
    @IBInspectable public dynamic var tagHighlightedBackgroundColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.highlightedBackgroundColor = tagHighlightedBackgroundColor
            }
        }
    }
    
    @IBInspectable public dynamic var tagSelectedBackgroundColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.selectedBackgroundColor = tagSelectedBackgroundColor
            }
        }
    }
    
    @IBInspectable public dynamic var cornerRadius: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.cornerRadius = cornerRadius
            }
        }
    }
    @IBInspectable public dynamic var borderWidth: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.borderWidth = borderWidth
            }
        }
    }
    
    @IBInspectable public dynamic var borderColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.borderColor = borderColor
            }
        }
    }
    
    @IBInspectable public dynamic var selectedBorderColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.selectedBorderColor = selectedBorderColor
            }
        }
    }
    
    @IBInspectable public dynamic var paddingY: CGFloat = 2 {
        didSet {
            for tagView in tagViews {
                tagView.paddingY = paddingY
            }
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var paddingX: CGFloat = 5 {
        didSet {
            for tagView in tagViews {
                tagView.paddingX = paddingX
            }
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var marginY: CGFloat = 2 {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var marginX: CGFloat = 5 {
        didSet {
            rearrangeViews()
        }
    }
    
    @objc public enum Alignment: Int {
        case Left
        case Center
        case Right
    }
    @IBInspectable public var alignment: Alignment = .Left {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var shadowColor: UIColor = UIColor.whiteColor() {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var shadowRadius: CGFloat = 0 {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var shadowOffset: CGSize = CGSizeZero {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var shadowOpacity: Float = 0 {
        didSet {
            rearrangeViews()
        }
    }
    
    @IBInspectable public dynamic var enableRemoveButton: Bool = false {
        didSet {
            for tagView in tagViews {
                tagView.enableRemoveButton = enableRemoveButton
            }
            rearrangeViews()
        }
    }
    
    @IBInspectable public dynamic var removeButtonIconSize: CGFloat = 12 {
        didSet {
            for tagView in tagViews {
                tagView.removeButtonIconSize = removeButtonIconSize
            }
            rearrangeViews()
        }
    }
    @IBInspectable public dynamic var removeIconLineWidth: CGFloat = 1 {
        didSet {
            for tagView in tagViews {
                tagView.removeIconLineWidth = removeIconLineWidth
            }
            rearrangeViews()
        }
    }
    
    @IBInspectable public dynamic var removeIconLineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54) {
        didSet {
            for tagView in tagViews {
                tagView.removeIconLineColor = removeIconLineColor
            }
            rearrangeViews()
        }
    }
    
    public dynamic var textFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            for tagView in tagViews {
                tagView.textFont = textFont
            }
            rearrangeViews()
        }
    }
    
    @IBOutlet public weak var delegate: TagListViewDelegate?
    
    public private(set) var tagViews: [TagView] = []
    
    private var text: String? = ""
    private var textField = TextField()
    private var hiddenTextField = TextField()
    private var wasEditing = false
    
    private(set) var tagBackgroundViews: [UIView] = []
    private(set) var rowViews: [UIView] = []
    private(set) var tagViewHeight: CGFloat = 0
    private(set) var rows = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    
    // MARK: - Interface Builder
    
    public override func prepareForInterfaceBuilder() {
        addTag("Welcome")
        addTag("to")
        addTag("TagListView").selected = true
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        rearrangeViews()
    }
    
    private func rearrangeViews() {
        let views = tagViews as [UIView] + tagBackgroundViews + rowViews
        for view in views {
            view.removeFromSuperview()
        }
        rowViews.removeAll(keepCapacity: true)
        
        var currentRow = 0
        var currentRowView: UIView!
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        for (index, tagView) in tagViews.enumerate() {
            tagView.frame.size = tagView.intrinsicContentSize()
            tagViewHeight = tagView.frame.height
            
            if currentRowTagCount == 0 || currentRowWidth + tagView.frame.width > frame.width {
                currentRow += 1
                currentRowWidth = 0
                currentRowTagCount = 0
                currentRowView = UIView()
                currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + marginY)
                
                rowViews.append(currentRowView)
                addSubview(currentRowView)
            }
            
            let tagBackgroundView = tagBackgroundViews[index]
            tagBackgroundView.frame.origin = CGPoint(x: currentRowWidth, y: 0)
            tagBackgroundView.frame.size = tagView.bounds.size
            tagBackgroundView.layer.shadowColor = shadowColor.CGColor
            tagBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: tagBackgroundView.bounds, cornerRadius: cornerRadius).CGPath
            tagBackgroundView.layer.shadowOffset = shadowOffset
            tagBackgroundView.layer.shadowOpacity = shadowOpacity
            tagBackgroundView.layer.shadowRadius = shadowRadius
            tagBackgroundView.addSubview(tagView)
            currentRowView.addSubview(tagBackgroundView)
            
            currentRowTagCount += 1
            currentRowWidth += tagView.frame.width + marginX
            
            switch alignment {
            case .Left:
                currentRowView.frame.origin.x = 0
            case .Center:
                currentRowView.frame.origin.x = (frame.width - (currentRowWidth - marginX)) / 2
            case .Right:
                currentRowView.frame.origin.x = frame.width - (currentRowWidth - marginX)
            }
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
        }
        
        // Add text view
        textField.removeFromSuperview()
        textField.font = textFont
        let textWidth = (text?.sizeWithAttributes([NSFontAttributeName: textFont]).width ?? 0) + 10.0
        
        textField = TextField(frame: CGRectMake(0, 0, textWidth, tagViewHeight))
        textField.text = text
        
        textField.addTarget(self, action: #selector(TagListView.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        textField.deleteHandler = { isEmpty in
            if let lastTagView = self.tagViews.last where isEmpty {
                self.removeTagView(lastTagView)
            }
        }
        textField.delegate = self
        
        if currentRowTagCount == 0 || currentRowWidth + textField.frame.width > frame.width {
            currentRow += 1
            currentRowWidth = 0
            currentRowView = UIView()
            currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + marginY)
            rowViews.append(currentRowView)
            addSubview(currentRowView)
        }
        
        textField.frame.origin = CGPoint(x: currentRowWidth, y: 0)
        textField.frame.size = CGSize(width: frame.width - currentRowWidth - 1, height: textField.frame.height)
        
        currentRowView.addSubview(textField)
        currentRowView.frame.size.width = currentRowWidth
        currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
        
        // End add text view
        
        // Hidden Text View
        hiddenTextField.removeFromSuperview()
        hiddenTextField = TextField(frame: CGRectZero)
        hiddenTextField.autocorrectionType = .No
        hiddenTextField.deleteHandler = { isEmpty in
            for tagView in self.selectedTags() {
                self.removeTagView(tagView)
            }
        }
        addSubview(hiddenTextField)
        
        if wasEditing {
            if selectedTags().count > 0 {
                hiddenTextField.becomeFirstResponder()
            } else {
                textField.becomeFirstResponder()
            }
        }
        
        rows = currentRow
        
        invalidateIntrinsicContentSize()
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let locationPoint = touches.first?.locationInView(self),
            let hitView = hitTest(locationPoint, withEvent: event) where hitView == self
        {
            wasEditing = true
            textField.becomeFirstResponder()
        }
    }
    
    // MARK: UITextFieldDelegate
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let text = textField.text where textField == self.textField {
            var isRepeat = false
            for tagView in tagViews {
                if tagView.currentTitle == text {
                    isRepeat = true
                }
            }
            
            self.text = nil
            self.textField.text = nil
            
            if !isRepeat {
                let scrubbedText = text.stringByTrimmingCharactersInSet(
                    NSCharacterSet.whitespaceAndNewlineCharacterSet()
                )
                addTag(scrubbedText)
            }
        }
        
        return true
    }
    
    var previousRowRemainder: CGFloat = 0.0
    
    func textFieldDidChange(textField: TextField) {
        text = textField.text
        if textField.frame.origin.x + textField.textWidth  > frame.size.width  {
            previousRowRemainder = frame.size.width - textField.frame.origin.x
            rearrangeViews()
        } else if textField.textWidth < previousRowRemainder {
            previousRowRemainder = 0.0
            rearrangeViews()
        }
    }
    
    // MARK: - Manage tags
    
    public override func intrinsicContentSize() -> CGSize {
        var height = CGFloat(rows) * (tagViewHeight + marginY)
        if rows > 0 {
            height -= marginY
        }
        return CGSizeMake(frame.width, height)
    }
    
    private func createNewTagView(title: String) -> TagView {
        let tagView = TagView(title: title)
        
        tagView.textColor = textColor
        tagView.selectedTextColor = selectedTextColor
        tagView.tagBackgroundColor = tagBackgroundColor
        tagView.highlightedBackgroundColor = tagHighlightedBackgroundColor
        tagView.selectedBackgroundColor = tagSelectedBackgroundColor
        tagView.cornerRadius = cornerRadius
        tagView.borderWidth = borderWidth
        tagView.borderColor = borderColor
        tagView.selectedBorderColor = selectedBorderColor
        tagView.paddingX = paddingX
        tagView.paddingY = paddingY
        tagView.textFont = textFont
        tagView.removeIconLineWidth = removeIconLineWidth
        tagView.removeButtonIconSize = removeButtonIconSize
        tagView.enableRemoveButton = enableRemoveButton
        tagView.removeIconLineColor = removeIconLineColor
        tagView.addTarget(self, action: #selector(tagPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.removeButton.addTarget(self, action: #selector(removeButtonPressed(_:)), forControlEvents: .TouchUpInside)
        
        // On long press, deselect all tags except this one
        tagView.onLongPress = { this in
            for tag in self.tagViews {
                tag.selected = (tag == this)
            }
        }
        
        return tagView
    }
    
    public func addTag(title: String) -> TagView {
        return addTagView(createNewTagView(title))
    }
    
    public func insertTag(title: String, atIndex index: Int) -> TagView {
        return insertTagView(createNewTagView(title), atIndex: index)
    }
    
    public func addTagView(tagView: TagView) -> TagView {
        tagViews.append(tagView)
        tagBackgroundViews.append(UIView(frame: tagView.bounds))
        rearrangeViews()
        
        return tagView
    }
    
    public func insertTagView(tagView: TagView, atIndex index: Int) -> TagView {
        tagViews.insert(tagView, atIndex: index)
        tagBackgroundViews.insert(UIView(frame: tagView.bounds), atIndex: index)
        rearrangeViews()
        
        return tagView
    }
    
    public func removeTag(title: String) {
        // loop the array in reversed order to remove items during loop
        for index in (tagViews.count - 1).stride(through: 0, by: -1) {
            let tagView = tagViews[index]
            if tagView.currentTitle == title {
                removeTagView(tagView)
            }
        }
    }
    
    public func removeTagView(tagView: TagView) {
        tagView.removeFromSuperview()
        if let index = tagViews.indexOf(tagView) {
            tagViews.removeAtIndex(index)
            tagBackgroundViews.removeAtIndex(index)
        }
        
        rearrangeViews()
    }
    
    public func removeAllTags() {
        let views = tagViews as [UIView] + tagBackgroundViews
        for view in views {
            view.removeFromSuperview()
        }
        tagViews = []
        tagBackgroundViews = []
        rearrangeViews()
    }
    
    public func selectedTags() -> [TagView] {
        return tagViews.filter() { $0.selected == true }
    }
    
    // MARK: - Events
    
    func tagPressed(sender: TagView!) {
        hiddenTextField.becomeFirstResponder()
        wasEditing = true
        sender.onTap?(sender)
        delegate?.tagPressed?(sender.currentTitle ?? "", tagView: sender, sender: self)
    }
    
    func removeButtonPressed(closeButton: CloseButton!) {
        if let tagView = closeButton.tagView {
            delegate?.tagRemoveButtonPressed?(tagView.currentTitle ?? "", tagView: tagView, sender: self)
        }
    }
    
    public override func resignFirstResponder() -> Bool {
        hiddenTextField.resignFirstResponder()
        textField.resignFirstResponder()
        return true
    }
    
    public func tagValues() -> [String] {
        var values = [String]()
        for tagView in tagViews {
            if let value = tagView.currentTitle {
                values.append(value)
            }
        }
        return values
    }
}
