//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

public protocol StackItem {
    /**
     The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems`
     of the parent. For example, if children are flowing vertically, `alignSelf` will control how the StackItem item
     will align horizontally.
     
     - Parameter value: Default value is .auto
     */
    @discardableResult
    func alignSelf(_ value: SAlignSelf) -> StackItem
    
    //
    // MARK: grow / shrink
    //
    
    /**
     The `grow` property defines the ability for a flex item to grow if necessary. It accepts a unitless value
     that serves as a proportion. It dictates what amount of the available space inside the flex container the
     item should take up.
     
     - Parameter value: Default value is 0
     */
    @discardableResult
    func grow(_ value: CGFloat) -> StackItem
    
    /**
     It specifies the "flex shrink factor", which determines how much the flex item will shrink relative to the
     rest of the flex items in the flex container when there isn't enough space on the main-axis.
     
     When omitted, it is set to 0 and the flex shrink factor is multiplied by the flex `basis` when distributing
     negative space.
     
     A shrink value of 0 keeps the view's size in the main-axis direction. Note that this may cause the view to
     overflow its flex container.
     
     - Parameter value: Default value is 1
     */
    @discardableResult
    func shrink(_ value: CGFloat) -> StackItem
    
    /**
     StackView's items are layouted only when a item's property is changed and when the StackView size change.
     In the event that you want to force StackView to do a layout of an item, you can mark it as dirty
     using `markDirty()`. `markDirty()` flag propagates to the direct StackView and all other parents StackViews.
     */
    @discardableResult
    func markDirty() -> StackItem

    /**
     This property controls dynamically if a StackView's item is included or not in the StackView layouting.
     When an item is excluded, StackView won't layout the view. Default value is true.

     This can be useful if you want to layout an item manually instead of using StackView layouting.
     */
    var isIncludedInLayout: Bool { get set }

    /**
     This property controls dynamically if a StackView's item is included or not in the StackView layouting.
     When an item is excluded, StackView won't layout the view. Default value is true.

     This can be useful if you want to layout an item manually instead of using StackView layouting.
     */
    @discardableResult
    func isIncludedInLayout(_ included: Bool) -> StackItem

    //
    // MARK: Width, height and size
    //
    /**
     The value specifies the view's width in pixels. The value must be non-negative.
     */
    @discardableResult
    func width(_ width: CGFloat?) -> StackItem
    
    /**
     The value specifies the view's width in percentage of its container width. The value must be non-negative.
     Example: view.flex.width(20%)
     */
    @discardableResult
    func width(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's minimum width in pixels. The value must be non-negative.
     */
    @discardableResult
    func minWidth(_ width: CGFloat?) -> StackItem
    
    /**
     The value specifies the view's minimum width in percentage of its container width. The value must be non-negative.
     */
    @discardableResult
    func minWidth(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's maximum width in pixels. The value must be non-negative.
     */
    @discardableResult
    func maxWidth(_ width: CGFloat?) -> StackItem
    
    /**
     The value specifies the view's maximum width in percentage of its container width. The value must be non-negative.
     */
    @discardableResult
    func maxWidth(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's height in pixels. The value must be non-negative.
     */
    @discardableResult
    func height(_ height: CGFloat?) -> StackItem
    
    /**
     The value specifies the view's height in percentage of its container height. The value must be non-negative.
     Example: view.flex.height(40%)
     */
    @discardableResult
    func height(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's minimum height in pixels. The value must be non-negative.
     */
    @discardableResult
    func minHeight(_ height: CGFloat?) -> StackItem
    
    /**
     The value specifies the view's minimum height in percentage of its container height. The value must be non-negative.
     */
    @discardableResult
    func minHeight(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies the view's maximum height in pixels. The value must be non-negative.
     */
    @discardableResult
    func maxHeight(_ height: CGFloat?) -> StackItem
    
    /**
     The value specifies the view's maximum height in percentage of its container height. The value must be non-negative.
     */
    @discardableResult
    func maxHeight(_ percent: SPercent) -> StackItem
    
    /**
     The value specifies view's width and the height in pixels. Values must be non-negative.
     */
    @discardableResult
    func size(_ size: CGSize) -> StackItem
    
    /**
     The value specifies the width and the height of the view in pixels, creating a square view. Values must be non-negative.
     */
    @discardableResult
    func size(_ sideLength: CGFloat?) -> StackItem
    
    @discardableResult
    func size(_ percent: SPercent) -> StackItem

    /**
     Set the view aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * An aspect ratio of 2 means the width is twice the size of the height.
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    @discardableResult
    func aspectRatio(_ value: CGFloat?) -> StackItem

    /**
     If the layouted view is an UIImageView, this method will set the aspectRatio using
     the UIImageView's image dimension.

     For other types of views, this method as no impact.
     */
    @discardableResult
    func aspectRatio() -> StackItem

    //
    // MARK: Margins
    //
    
    /**
     Set the top margin. Top margin specify the offset the top edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginTop(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginTop(_ value: SPercent) -> StackItem
    
    /**
     Set the left margin. Left margin specify the offset the left edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginLeft(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginLeft(_ value: SPercent) -> StackItem
    
    /**
     Set the bottom margin. Bottom margin specify the offset the bottom edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginBottom(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginBottom(_ value: SPercent) -> StackItem
    
    /**
     Set the right margin. Right margin specify the offset the right edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginRight(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginRight(_ value: SPercent) -> StackItem
    
    /**
     Set the start margin.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, start margin specify the offset the **left** edge of the item should have from from it’s closest sibling (item) or parent (container).
     * IN RTL direction, start margin specify the offset the **right** edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginStart(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginStart(_ value: SPercent) -> StackItem
    
    /**
     Set the end margin.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, end margin specify the offset the **right** edge of the item should have from from it’s closest sibling (item) or parent (container).
     * IN RTL direction, end margin specify the offset the **left** edge of the item should have from from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    func marginEnd(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginEnd(_ value: SPercent) -> StackItem
    
    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult
    func marginHorizontal(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginHorizontal(_ value: SPercent) -> StackItem
    
    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult
    func marginVertical(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func marginVertical(_ value: SPercent) -> StackItem
    
    /**
     Set all margins using UIEdgeInsets.
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult
    func margin(_ insets: UIEdgeInsets) -> StackItem
    
    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.
     
     Available only on iOS 11 and higher.
     */
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> StackItem
    
    /**
     Set all margins to the specified value.
     */
    @discardableResult
    func margin(_ value: CGFloat) -> StackItem
    
    @discardableResult
    func margin(_ value: SPercent) -> StackItem
    
    /**
     Set the individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult
    func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> StackItem
    
    /**
     Set the individually top, horizontal margins and bottom margin.
     */
    @discardableResult
    func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> StackItem
    
    /**
     Set the individually top, left, bottom and right margins.
     */
    @discardableResult
    func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> StackItem

    //
    // MARK: UIView Visual properties
    //

    /**
     Set the item/view background color.
     */
    @discardableResult
    func backgroundColor(_ color: UIColor) -> StackItem

    /**
     Set the item/view transparency `alpha`.
     */
    @discardableResult
    func alpha(_ alpha: CGFloat) -> StackItem
}
    
    
#endif
