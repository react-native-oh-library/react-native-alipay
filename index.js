import React, { Component, useEffect } from 'react';
import { NativeModules, TurboModuleRegistry } from 'react-native';

const Alipay = TurboModuleRegistry.get('AlipayNativeModule');

export default Alipay;