//::///////////////////////////////////////////////
//:: Ferocity 1
//:: NW_S1_Feroc1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Dex and Str of the target increases
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:://////////////////////////////////////////////
/*
Patch 1.70

- duration calculation was bugged
- added thundering & terrifying rage bonuses if creature have these feats
*/

#include "x2_i0_spells"

void main()
{
    //Declare major variables
    int nIncrease = 3;
    //Determine the duration by getting the con modifier
    int nCon = (GetAbilityScore(OBJECT_SELF, ABILITY_CONSTITUTION) - 10 + nIncrease)/2;

    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, nIncrease);
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eStr, eDex);
    eLink = EffectLinkEffects(eLink, eDur);

    //Make effect extraordinary
    eLink = ExtraordinaryEffect(eLink);
    //effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_FEROCITY_1, FALSE));

    if (nCon > 0)
    {
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
        //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
        CheckAndApplyEpicRageFeats(nCon);
    }
}
