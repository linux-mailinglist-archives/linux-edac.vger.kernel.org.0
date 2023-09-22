Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D47AB24F
	for <lists+linux-edac@lfdr.de>; Fri, 22 Sep 2023 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjIVMly (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Sep 2023 08:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjIVMlx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 Sep 2023 08:41:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2971199;
        Fri, 22 Sep 2023 05:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoqDzwPIYYk0LkTFqN1c7ZaTyPgA2hLHIYBL5wAiO9ihFpXuCYTYupyYEQidEbBgNQFfAZLehM+qGMjNzwW34AThqpYPC6oV1b8TM1MSspOV/vRLixAnDqArN2j9wCkdA0PDFnTbd8cAyQ57a+UOZ079DdVdt5EKTv6EISWcdYPifF9uNvV+8AMHnsmlMF1JneXNzN7QAQ+2+zWQ60zH2HWru8OkDWtWxk9QMmLjal/kkSuIp6WpFRcqBqgc9oXSlRnDcXzuXK/tILQOaZ071OhVGyaR6GZ+THkvbuICp+PJMW81FJPBxIwfUKgQTU3/SlapB06cObrz+jkCT4EI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR8TABd1GBWeagVFiDxzweW9ry/9fVfjzonb3Qcwcyo=;
 b=d3ivQIT8Y8CkkdUL+Sqig/atfkGdGQSTP9cQF5lMWk5/ATg672iDUxI2e+h0UpQrRQvGUg2U6MYHHV0dK7V5MaPvQIPiH3aBJx0tHaWHMIIp809lm7AKPcYVwPtn45spNQpP/83r0Z1yK+TQbfU188VhtWoZC2o7KbTSzV/cd6XfSY98GnaeVGeuTCJ12Sh1+4NYMpNgLqdOk2yI7yVdhJRpsqw6yOJIsKyxXT1W1CpWfrSMBFkg/DQuLMRp+iGeOklc5gvvTkkLJnn7lDco+A7geqolub1E4+8ZMO9qnnkhFD7JTIrbx1Xp7T/dWk7AjveIaZcKxhTae0wdDnl5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR8TABd1GBWeagVFiDxzweW9ry/9fVfjzonb3Qcwcyo=;
 b=JDUeCcytsT4eIOGfZDcqCpfFRv4P/LS2AAEzeC79wqAfoJPdGFlEhAkc5pO2jMp+a+N32ip/tcr4gnrwctsLm4z/JHOqvZk+Eg2atSyR5g4UsHw1cUMivvM6V5kmlqaknOIOgGTQOqnNjJtAV74kA5kIME3O00V09g34hIK9k+k=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 22 Sep
 2023 12:41:43 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::48af:8d18:40f3:a43a]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::48af:8d18:40f3:a43a%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:41:42 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v8 2/2] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Thread-Topic: [PATCH v8 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
Thread-Index: AQHZxs31cT4zt07OpUyi45xNaoL+GbAiqPAAgARrdhA=
Date:   Fri, 22 Sep 2023 12:41:42 +0000
Message-ID: <BY5PR12MB490257ECC744824A94F48FF881FFA@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20230804121924.18615-1-shubhrajyoti.datta@amd.com>
 <20230804121924.18615-3-shubhrajyoti.datta@amd.com>
 <20230919165927.GEZQnTb9gr5X13sJuD@fat_crate.local>
In-Reply-To: <20230919165927.GEZQnTb9gr5X13sJuD@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a3fc4b5a-a5ed-4e5e-bc4c-ea9280d78c6d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-22T12:33:34Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|DS7PR12MB8203:EE_
x-ms-office365-filtering-correlation-id: 4418a321-b70a-47c1-c5ca-08dbbb694640
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVGtSmiL4ZrqWdg6GMR/hhtkV//cVMD00fbSrvgRk1ob7/rPig6FRm607lLq+tEht9bTY0GXowUh27YpUcOZdi/f188Pk8fBpOHZKW4sxxAEr5OEr9wR+QfzsHi3pZ7o/qR0f60x30hloJoZUdCvlZA7+merPi0T4jV6YMZ9cDFaewpZmbi2SLaT4RWUDbznQcX/wwgx38/0Y2EG/v0Nj3+jDaGmTcSZmIMgokXfAqGFUR00kBWoVf7qbgzTcf99fmgzaN8cI1QFfn3xinVE3l8WeIvWk00n2ZOJQt0tyWOZMaWNEZp77LoyXP+kdnbHA3TOnoApKq7/CChpTKjzDbkh5YkbV/JQaCpHQ2P+0fC4LBG6YgWYUdxS1iF0HIRy3uVGChPQxCxM6IVKoL4Vd/vMwmEDKP5y0lFVJRCL8qxgnR4+kF44J+sFXYSsp2rmop64Ao02sAekGGqOubg8sGdoh3D9gWwDTrGoQcYh/vBjHxkCezqNqvAnf2IvdmsGUq/xU5vFvJ0LE+fuPh0YMzw+Jgn2xCBD/0hehE9oQpTzpZ0rRbmNyf7kHZsuFSGFbn77XwkqZEdvEJaUyo0+0FHnjS09VkSk2Xv7QSPMoyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199024)(186009)(1800799009)(83380400001)(26005)(9686003)(316002)(6916009)(64756008)(54906003)(7416002)(66446008)(66556008)(66946007)(66476007)(41300700001)(76116006)(52536014)(4326008)(8676002)(8936002)(71200400001)(6506007)(7696005)(53546011)(478600001)(2906002)(966005)(55016003)(33656002)(5660300002)(86362001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW9sbUFicE9ab1BzUHVRYVE0NkwwRk1aQml6SFRtbTZpbjNpWFdZaUh5WjdM?=
 =?utf-8?B?WUoybGVnTU5JUElsN3crTVJYamtKN2M1NVdKeHVXUE1DVmhMVW53amJ1SWVn?=
 =?utf-8?B?cUtOWmdYSVlSVW1MNmpZYXJOcS81MTRGeW9oTjR0QmVlZXpqbkVNOTVmNVlT?=
 =?utf-8?B?OHVOc2prMWpFdWh6NlZleXN0cW45MWFNU3FzU2lwdmozK1VveEpqbTB3eXls?=
 =?utf-8?B?WGRaU2xXdlJFdWUxWlE0MElSTGJOYXVIbHphTEg3OVllbzE0emhDVkgxUXJE?=
 =?utf-8?B?UXR2aU1kOFV2ekRGVkJYdGkrWlBpSUV3WHF0MlJZaXl3WEpEUDN5dkZxR0dw?=
 =?utf-8?B?cW1EVTN5d2NsQ1lSSjJIRThBanZubW1xWjR5TUc4d2txOVBSR1B5dVcvdnRn?=
 =?utf-8?B?SHBjS0U3RFQyMTZ1cU16cHlVVmExTXNvMnBabmRLV2ZWa0RmNzM4ZVMyVk1V?=
 =?utf-8?B?cXNQUkUydysyYlZZSlA3VWo1N21lVEEyWnB1eWRpWUowdjdqM2NHNzhXZlAz?=
 =?utf-8?B?NTBHWCtnRlZZNVdMN21sdExBcjZyNDRPOVJMMjhjUitBTDdlaHBMZllXczBY?=
 =?utf-8?B?MktnZXdyM2FHUCsxQmFmZGJTeGpKUVFOWjNZa0FWZ1ZyNU45ZHV1djQrVW9W?=
 =?utf-8?B?SklwZHVLWDdwRWdoKy9rMDFHM25IMU9tWXBCYzNuQnhSVnBpSG14cmlGMEpu?=
 =?utf-8?B?WVphcStHWEc1SFI5S1RTMEt4V2dhWEZOOXlFWDFnTG1uTVZ4ZGsxdCtmemRp?=
 =?utf-8?B?UEVvZDhtcTV1WXUwaGFHcWpCanVCb0RnTGJDUitHRVFPcG5NckM3dHpicFpR?=
 =?utf-8?B?MUVyci9LUTlFejZGbzBMR2h5Z3FEOGNmcFpJYjBBMFhlbU1IdWZlYmhBQ1Nx?=
 =?utf-8?B?OWs4WVREV09OVHU4ZS9UUnM2ZUprUVFCYjZqWVh4VHdRaXZaajVVak5nNWxK?=
 =?utf-8?B?c1F4Y3RqM052a1IvdVF6a2o4YkRZZkU4NWhrbmNXOWMxR28vRTQ2UVdLR0RB?=
 =?utf-8?B?MjFsaWduYk1HL0pPUXNibXhRelF5UWhnN2ZnTlBLZ2dERm02Qm5GUE1qM0RQ?=
 =?utf-8?B?emxEODNlTC92bjA1d2g0cXZSWHRpZEdFOWVUT2owcVVyMllNWWpFMittOUJP?=
 =?utf-8?B?WVhoSk9iT2toZVRJdzVNTmNYK0t2RG5pT1BwaTMzRng0dVdaMFRSYkIyL08z?=
 =?utf-8?B?RlFEc2ZKNHA3NVB4VWhwL2N1aU8xNlduNVRSWWdUa1Jvb0Uyb1lnd3czMi9B?=
 =?utf-8?B?SWt1aUR2Y0NiYXdOTms1eUdQQ3dMZzhzRjVKZHQ2THJXWDVmZE9oUjdlWEJp?=
 =?utf-8?B?UTRDTGhYM2t0VUVqRk9kbGRlQmd6amd6ZnloS1ZtaUpJMVVEcnVkbllkSEhJ?=
 =?utf-8?B?aXdtYVozZjZBcGh3Tmd2UTZCRnFxOFhCZmJRbDNmbk5VS0FvcHJwNUdVVkVF?=
 =?utf-8?B?UllmQ1EyK3dQOFBYZDVoSU8vU1J1ZWYrRzZ1bTJpNzFiUmloUGJYcHNDWVc5?=
 =?utf-8?B?U1AyZThZalBHWkdwYVdhWWRKeFVsa1hraUxOdE1Rc3RHMzNTblZ1NnJDQmt0?=
 =?utf-8?B?TTZUbUJUQ2lNNVQ1aW9nT3BzeU12OHo1Uzl3VTVlQ0VJZDlJWi8rUlU5UU9o?=
 =?utf-8?B?K1hGL0hiTlV0V1plMDVuQSs4UFlDZmpPb3BZMnFpZXlsWEdZcmFpL2RkTkk2?=
 =?utf-8?B?d1kwaWcvUXNNWWxzNitTekhYYUNYYkg1ZDZSdlJEa2hWWmcvUEZyWElucEcz?=
 =?utf-8?B?aGNWN2Ewa25tTm1sZUxYOEVGRW9NSVFhUEFFRmlXckZ2WXZOSVZpd3ZKRmpE?=
 =?utf-8?B?L215YW1HTkFjZ0NLUk5uQ1B4K2J1UUdNeUJEazdhQ1h6ZXJMZWdyZjJrZE5i?=
 =?utf-8?B?OU5ZdmhHcW53REd6MS9JdnRBTE5BV3d0YmU5TUEzd1BIZnRHTTR2UFhJcGxo?=
 =?utf-8?B?a0s5VEVESTFQdVUzU2NodTJ4cm83bmY4ZmllRXV0L2xKNHhMN2tzZVJkVm1i?=
 =?utf-8?B?OGVsdmIydXFUTEJDc21lUEtZODNZSTZzQmh3ZU1iSGV6cnJ5OVo5dTdIeFRt?=
 =?utf-8?B?KzNYUE5IdE1XdVFEb2dPK2Q1eS9WdVdEN3d3dUtMUDljMkM1ZWdUUzJTTzlq?=
 =?utf-8?Q?oLG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4418a321-b70a-47c1-c5ca-08dbbb694640
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:41:42.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lg8Hhn8q6Jhd1SOPyr5ZqnAvKxFdktDRT5hCk6Wm9zHAU3dZPEfefCOTsKQ2KpumI/0MHX9fqvzBy+u2GbCaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhJIEJvcmlzICwNCg0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMTksIDIwMjMgMTA6MzQgUE0NCj4gVG86IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFq
eW90aS5kYXR0YUBhbWQuY29tPg0KPiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGdp
dCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IFBvdHRodXJpLCBTYWkgS3Jpc2huYQ0KPiA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNv
bT47IGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3Jn
OyBjb25vcitkdEBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOw0KPiBqYW1lcy5tb3Jz
ZUBhcm0uY29tOyBtY2hlaGFiQGtlcm5lbC5vcmc7IHJyaWNAa2VybmVsLm9yZzsgU2ltZWssDQo+
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjgg
Mi8yXSBFREFDL3ZlcnNhbDogQWRkIGEgWGlsaW54IFZlcnNhbCBtZW1vcnkNCj4gY29udHJvbGxl
ciBkcml2ZXINCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBF
eHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNo
bWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBGcmksIEF1
ZyAwNCwgMjAyMyBhdCAwNTo0OToyNFBNICswNTMwLCBTaHViaHJhanlvdGkgRGF0dGEgd3JvdGU6
DQo+ID4gK2NvbmZpZyBFREFDX1ZFUlNBTA0KPiA+ICsgICAgIHRyaXN0YXRlICJYaWxpbnggVmVy
c2FsIEREUiBNZW1vcnkgQ29udHJvbGxlciINCj4gPiArICAgICBkZXBlbmRzIG9uIEFSQ0hfWllO
UU1QIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsgICAgIGhlbHANCj4gPiArICAgICAgIFN1cHBvcnQg
Zm9yIGVycm9yIGRldGVjdGlvbiBhbmQgY29ycmVjdGlvbiBvbiB0aGUgWGlsaW54IFZlcnNhbCBE
RFINCj4gPiArICAgICAgIG1lbW9yeSBjb250cm9sbGVyLg0KPiA+ICsNCj4gPiArICAgICAgIFJl
cG9ydCBib3RoIHNpbmdsZSBiaXQgZXJyb3JzIChDRSkgYW5kIGRvdWJsZSBiaXQgZXJyb3JzIChV
RSkuDQo+ID4gKyAgICAgICBTdXBwb3J0IGluamVjdGluZyBib3RoIGNvcnJlY3RhYmxlIGFuZCB1
bmNvcnJlY3RhYmxlIGVycm9ycyBmb3IgZGVidWcNCj4gPiArICAgICAgIHB1cnBvc2UgdXNpbmcg
c3lzZnMgZW50cmllcy4NCj4NCj4gICAgICAgICAgIFJlcG9ydCBib3RoIHNpbmdsZSBiaXQgZXJy
b3JzIChDRSkgYW5kIGRvdWJsZSBiaXQgZXJyb3JzIChVRSkuDQo+ICAgICAgICAgICBTdXBwb3J0
IGluamVjdGluZyBib3RoIGNvcnJlY3RhYmxlIGFuZCB1bmNvcnJlY3RhYmxlIGVycm9ycw0KPiAg
ICAgICAgICAgZm9yIGRlYnVnZ2luZyBwdXJwb3Nlcy4NCj4NCldpbGwgZG8uDQo+DQo+ID4gKy8q
Kg0KPiA+ICsgKiBzdHJ1Y3QgZWNjX2Vycm9yX2luZm8gLSBFQ0MgZXJyb3IgbG9nIGluZm9ybWF0
aW9uLg0KPiA+ICsgKiBAYnVyc3Rwb3M6ICAgICAgICAgICAgICAgIEJ1cnN0IHBvc2l0aW9uLg0K
PiA+ICsgKiBAbHJhbms6ICAgICAgICAgICBMb2dpY2FsIFJhbmsgbnVtYmVyLg0KPiA+ICsgKiBA
cmFuazogICAgICAgICAgICBSYW5rIG51bWJlci4NCj4gPiArICogQGdyb3VwOiAgICAgICAgICAg
R3JvdXAgbnVtYmVyLg0KPiA+ICsgKiBAYmFuazogICAgICAgICAgICBCYW5rIG51bWJlci4NCj4g
PiArICogQGNvbDogICAgICAgICAgICAgQ29sdW1uIG51bWJlci4NCj4gPiArICogQHJvdzogICAg
ICAgICAgICAgUm93IG51bWJlci4NCj4gPiArICogQHJvd2hpOiAgICAgICAgICAgUm93IG51bWJl
ciBoaWdoZXIgYml0cy4NCj4gPiArICogQGk6ICAgICAgICAgICAgICAgICAgICAgICBFQ0MgZXJy
b3IgaW5mby4NCj4gPiArICovDQo+ID4gK3VuaW9uIGVjY19lcnJvcl9pbmZvIHsNCj4gPiArICAg
ICBzdHJ1Y3Qgew0KPiA+ICsgICAgICAgICAgICAgdTY0IGJ1cnN0cG9zOjM7DQo+ID4gKyAgICAg
ICAgICAgICB1NjQgbHJhbms6MzsNCj4gPiArICAgICAgICAgICAgIHU2NCByYW5rOjI7DQo+ID4g
KyAgICAgICAgICAgICB1NjQgZ3JvdXA6MjsNCj4gPiArICAgICAgICAgICAgIHU2NCBiYW5rOjI7
DQo+ID4gKyAgICAgICAgICAgICB1NjQgY29sOjEwOw0KPiA+ICsgICAgICAgICAgICAgdTY0IHJv
dzoxMDsNCj4gPiArICAgICAgICAgICAgIHUzMiByb3doaTsNCj4gPiArICAgICB9Ow0KPiA+ICsg
ICAgIHU2NCBpOw0KPiA+ICt9Ow0KPg0KPiBJIG1pc3NlZCB0aGlzIHRoZSBsYXN0IHRpbWUgYnV0
LCBpZiB0aGlzIGlzIHN1cHBvc2VkIHRvIGJlIGEgdW5pb24gb2Ygc2l6ZW9mKHU2NCksDQo+IHdo
eSBhcmVuJ3QgeW91IGRvaW5nIHRoaXM6DQoNCldpbGwgdXBkYXRlDQo+DQo+IHVuaW9uIGVjY19l
cnJvcl9pbmZvIHsNCj4gICAgICAgICBzdHJ1Y3Qgew0KPiAgICAgICAgICAgICAgICAgdTMyIGJ1
cnN0cG9zOjM7DQo+ICAgICAgICAgICAgICAgICB1MzIgbHJhbms6MzsNCj4gICAgICAgICAgICAg
ICAgIHUzMiByYW5rOjI7DQo+ICAgICAgICAgICAgICAgICB1MzIgZ3JvdXA6MjsNCj4gICAgICAg
ICAgICAgICAgIHUzMiBiYW5rOjI7DQo+ICAgICAgICAgICAgICAgICB1MzIgY29sOjEwOw0KPiAg
ICAgICAgICAgICAgICAgdTMyIHJvdzoxMDsNCj4gICAgICAgICAgICAgICAgIHUzMiByb3doaTsN
Cj4gICAgICAgICB9Ow0KPiAgICAgICAgIHU2NCBpOw0KPiB9IF9fcGFja2VkOw0KPg0KPiBpLmUu
LCB0aGUgc3RydWN0IHNob3VsZCBoYXZlIHR3byB1MzIncyAtIHRoZSBmaXJzdCBvbmUgaXMgdGhl
IGJpdGZpZWxkIGFuZCB0aGUNCj4gc2Vjb25kIG9uZSBpcyByb3doaSBhbmQgdGhlICJvdmVybG9h
ZGVkIiBvbmUgaXMgdGhlIHU2NCBpLg0KPg0KPiBBbmQgYWxzbyBpdCBzaG91bGQgYmUgcGFja2Vk
IGV2ZW4gdGhvdWdoIHRoaXMgc2hvdWxkbid0IGJlIG5lZWRlZCBpbiB0aGlzDQo+IGNhc2UgYnV0
IHN0aWxsLg0KPg0KPiBEaXR0byBmb3IgdGhlIG90aGVyIHVuaW9ucy4NCj4NCj4gPiArDQo+ID4g
K3VuaW9uIGVkYWNfaW5mbyB7DQo+ID4gKyAgICAgc3RydWN0IHsNCj4gPiArICAgICAgICAgICAg
IHUzMiByb3cwOjY7DQo+ID4gKyAgICAgICAgICAgICB1MzIgcm93MTo2Ow0KPiA+ICsgICAgICAg
ICAgICAgdTMyIHJvdzI6NjsNCj4gPiArICAgICAgICAgICAgIHUzMiByb3czOjY7DQo+ID4gKyAg
ICAgICAgICAgICB1MzIgcm93NDo2Ow0KPiA+ICsgICAgICAgICAgICAgdTMyIHJlc2VydmVkOjI7
DQo+ID4gKyAgICAgfTsNCj4gPiArICAgICBzdHJ1Y3Qgew0KPiA+ICsgICAgICAgICAgICAgdTMy
IGNvbDE6NjsNCj4gPiArICAgICAgICAgICAgIHUzMiBjb2wyOjY7DQo+ID4gKyAgICAgICAgICAg
ICB1MzIgY29sMzo2Ow0KPiA+ICsgICAgICAgICAgICAgdTMyIGNvbDQ6NjsNCj4gPiArICAgICAg
ICAgICAgIHUzMiBjb2w1OjY7DQo+ID4gKyAgICAgICAgICAgICB1MzIgcmVzZXJ2ZWRjb2w6MjsN
Cj4gPiArICAgICB9Ow0KPiA+ICsgICAgIHUzMiBpOw0KPiA+ICt9Ow0KPg0KPiAuLi4NCj4NCj4g
PiArICAgICAvKiBVbmxvY2sgdGhlIFBDU1IgcmVnaXN0ZXJzICovDQo+ID4gKyAgICAgd3JpdGVs
KFBDU1JfVU5MT0NLX1ZBTCwgZGRybWNfYmFzZSArIFhERFJfUENTUl9PRkZTRVQpOw0KPiA+ICsN
Cj4gPiArICAgICB3cml0ZWwoMCwgZGRybWNfYmFzZSArIEVDQ1IwX0NFUlJfU1RBVF9PRkZTRVQp
Ow0KPiA+ICsgICAgIHdyaXRlbCgwLCBkZHJtY19iYXNlICsgRUNDUjFfQ0VSUl9TVEFUX09GRlNF
VCk7DQo+ID4gKyAgICAgd3JpdGVsKDAsIGRkcm1jX2Jhc2UgKyBFQ0NSMF9VRVJSX1NUQVRfT0ZG
U0VUKTsNCj4gPiArICAgICB3cml0ZWwoMCwgZGRybWNfYmFzZSArIEVDQ1IxX1VFUlJfU1RBVF9P
RkZTRVQpOw0KPiA+ICsNCj4gPiArICAgICAvKiBMb2NrIHRoZSBQQ1NSIHJlZ2lzdGVycyAqLw0K
PiA+ICsgICAgIHdyaXRlbCgxLCBkZHJtY19iYXNlICsgWEREUl9QQ1NSX09GRlNFVCk7DQo+DQo+
IEkgc3RpbGwgZG9uJ3Qga25vdyB3aGF0IHRoaXMgbG9ja2luZyBhbmQgdW5sb2NraW5nIGlzIGFs
bCBhYm91dCBhbmQgd2h5IGl0IGlzDQo+IG5lZWRlZC4uLg0KVGhlIGVudGlyZSByZWdpc3RlciBz
cGFjZSBpcyBsb2NrZWQgYnkgZGVmYXVsdA0KaHR0cHM6Ly9kb2NzLnhpbGlueC5jb20vci9lbi1V
Uy9hbTAxMi12ZXJzYWwtcmVnaXN0ZXItcmVmZXJlbmNlL1BDU1JfTE9DSy1YUkFNX1NMQ1ItUmVn
aXN0ZXINCldlIGhhdmUgIHdyaXRlIDB4RjlFOEQ3QzYgdG8gdW5sb2NrLg0KDQo+DQo+IEJ0dywg
eW91IG11c3QgYWx3YXlzIG1ha2Ugc3VyZSB5b3VyIHN0dWZmIGJ1aWxkczoNCj4NCj4gZHJpdmVy
cy9lZGFjL3ZlcnNhbF9lZGFjLmM6IEluIGZ1bmN0aW9uICdtY19yZW1vdmUnOg0KPiBkcml2ZXJz
L2VkYWMvdmVyc2FsX2VkYWMuYzoxMDM1Ojk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBv
ZiBmdW5jdGlvbg0KPiAnZGlzYWJsZV9pbnRyJzsgZGlkIHlvdSBtZWFuICdkaXNhYmxlX2lycSc/
IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLQ0KPiBkZWNsYXJhdGlvbl0NCj4gIDEwMzUgfCAg
ICAgICAgIGRpc2FibGVfaW50cihwcml2KTsNCj4gICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+
fg0KPiAgICAgICB8ICAgICAgICAgZGlzYWJsZV9pcnENCj4NCj4NCj4gT3RoZXJ3aXNlIGl0IGxv
b2tzIHRvIG1lIGxpa2UgeW91IGhhdmVuJ3QgdGVzdGVkIGl0IGFuZCBpZiB0aGF0IGlzIHRoZSBj
YXNlLCBJJ2xsDQo+IHNpbXBseSBpZ25vcmUgaXQuDQoNClRoZSBmdW5jdGlvbiBpcyBkZWZpbmVk
IHVuZGVyIENPTkZJR19FREFDX0RFQlVHIEkgaGFkIGl0IGVuYWJsZWQgdG8gYmUgYWJsZQ0KVG8g
aW5qZWN0IGVycm9ycyAuDQoNCkkgc2hvdWxkIGhhdmUgYWxzbyBjaGVja2VkIGRpc2FibGluZyBp
dC4NCkkgd2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4NCj4gU28gbWFrZSBzdXJlIHlv
dSBidWlsZC10ZXN0IGFuZCB0ZXN0IHlvdXIgc3R1ZmYgYmVmb3JlIHN1Ym1pdHRpbmcuDQo+DQo+
IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUu
a2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==
