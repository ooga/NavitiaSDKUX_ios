//
// Created by Chakkra CHAK on 13/09/2017.
//

import Foundation
import NavitiaSDK

class Modes {
    func getModeIcon(section: Section?) -> String {
        switch section!.type! {
        case "public_transport": return getPhysicalMode(section: section).lowercased()
        case "transfer": return section!.transferType!
        case "waiting": return section!.type!
        default: return section!.mode!
        }
    }

    func getPhysicalMode(section: Section?) -> String {
        let id = getPhysicalModeId(section: section)
        var modeData = id.characters.split(separator: ":").map(String.init)
        return modeData[1]
    }

    private func getPhysicalModeId(section: Section?) -> String {
        for link in section!.links! {
            if link.type == "physical_mode" {
                return link.id!
            }
        }
        return "<not_found>"
    }
}
