//
// Copyright (c) 2022 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

@_spi(AdyenInternal)
extension PhoneExtension: CustomStringConvertible {

    public var description: String { "\(countryDisplayName) (\(value))" }

}

/// Describes a single phone extension picker item in the list of selectable items.
@_spi(AdyenInternal)
public typealias PhoneExtensionPickerItem = BasePickerElement<PhoneExtension>

/// Describes a picker item.
@_spi(AdyenInternal)
public final class FormPhoneExtensionPickerItem: BaseFormPickerItem<PhoneExtension> {

    /// Initializes the picker item.
    ///
    /// - Parameter selectableValues: The list of values to select from.
    /// - Parameter style: The `FormPhoneExtensionPickerItem` UI style.
    override internal init(preselectedValue: PhoneExtensionPickerItem,
                           selectableValues: [PhoneExtensionPickerItem],
                           style: FormTextItemStyle) {
        assert(selectableValues.count > 0)
        super.init(preselectedValue: preselectedValue, selectableValues: selectableValues, style: style)
    }

    override public func build(with builder: FormItemViewBuilder) -> AnyFormItemView {
        builder.build(with: self)
    }
    
}
