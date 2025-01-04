HarvestMissionExtension = {}

function HarvestMissionExtension.isAvailableForField(field, superFunc, mission)
-- InfoDisplayExtension.DebugText("HarvestMissionExtension.isAvailableForField(%s, %s)", field, mission);
    if mission == nil then
        local fieldState = field:getFieldState();
        if not fieldState.isValid then
            return false;
        end
        local fruitTypeIndex = fieldState.fruitTypeIndex;
        if fruitTypeIndex == FruitType.UNKNOWN then
            return false;
        end
        local fruitDesc = g_fruitTypeManager:getFruitTypeByIndex(fruitTypeIndex);
        if fruitDesc:getIsCatchCrop() then
            return false;
        end
        -- preparable means harvest mission can be done
        if fruitDesc:getIsPreparable(fieldState.growthState) then
            return true;
        end
        if not fruitDesc:getIsHarvestReady(fieldState.growthState) then
            return false;
        end
    end
    return true;
end

HarvestMission.isAvailableForField = Utils.overwrittenFunction(HarvestMission.isAvailableForField, HarvestMissionExtension.isAvailableForField)