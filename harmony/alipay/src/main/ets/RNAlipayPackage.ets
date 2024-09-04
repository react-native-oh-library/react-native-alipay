import {
    RNPackage,
    TurboModulesFactory,
  } from "@rnoh/react-native-openharmony/ts";
  import type {
    TurboModule,
    TurboModuleContext,
  } from "@rnoh/react-native-openharmony/ts";
  import { TM } from "@rnoh/react-native-openharmony/generated/ts";
  import { RNAlipayTurboModule } from './RNAlipayTurboModule';
  
  class RNAlipayModulesFactory extends TurboModulesFactory {
    createTurboModule(name: string): TurboModule | null {
      if (name === TM.AlipayNativeModule.NAME) {
        return new RNAlipayTurboModule(this.ctx);
      }
      return null;
    }
  
    hasTurboModule(name: string): boolean {
      return name === TM.AlipayNativeModule.NAME;
    }
  }
  
  export class RNAlipayPackage extends RNPackage {
    createTurboModulesFactory(ctx: TurboModuleContext): TurboModulesFactory {
      return new RNAlipayModulesFactory(ctx);
    }
  }