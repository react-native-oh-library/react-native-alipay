import { TurboModule } from '@rnoh/react-native-openharmony/ts';
import { TM } from "@rnoh/react-native-openharmony/generated/ts"
import { Pay } from "@cashier_alipay/cashiersdk"
import { 
  AFServiceParams,
  AFWantParams,
  AFServiceCenter,
  AFAuthServiceResponse,
  AFService,
  AFAuthResCode
} from '@alipay/afservicesdk';

let scheme: string = '';

export class RNAlipayTurboModule extends TurboModule implements TM.AlipayNativeModule.Spec {
    setAlipayScheme(sScheme: string) {
        scheme = sScheme;
    }

    async alipay(orderInfo: string): Promise<string> {
        let payObj = new Pay();
        let res = await payObj.pay(orderInfo, true);
        let message: string = JSON.stringify(Array.from(res.entries()));
        console.info("message: " + message);
        return message;
    }
    
    async authInfo(urlStr: string, useLanding: boolean, sBundleName: string, sModuleName: string, sAbilityName: string,
        callBack: (para: AFAuthServiceResponse) => void): Promise<void> {
        let bizParams = new Map<string, string>();
        let url = encodeURIComponent(urlStr);
        bizParams.set("url", url);

        let isFroceH5: boolean = false;
        let isInstallAlipay: boolean = AFServiceCenter.canOpenAliPay();
        console.log("install alipay : " + isInstallAlipay);
        if (isInstallAlipay) {
            isFroceH5 = true;
        }

        let backWant: AFWantParams = {
            bundleName: sBundleName,
            moduleName: sModuleName,
            abilityName: sAbilityName
        }

        let params = new AFServiceParams(bizParams, isFroceH5, useLanding, scheme, backWant, callBack);
        AFServiceCenter.call(AFService.AFServiceAuth, params);
    }
}