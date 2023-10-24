Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0E7D4701
	for <lists+linux-edac@lfdr.de>; Tue, 24 Oct 2023 07:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjJXFoG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Oct 2023 01:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJXFoF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Oct 2023 01:44:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D510D
        for <linux-edac@vger.kernel.org>; Mon, 23 Oct 2023 22:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccXs+0MuUT16dYRS3UtfuVRa56PS9nFrKnYg/zML4lPgqRkUk11TE7pjnjdR00HX9Xpn7KNdkaCpo3E4RNoYLKjlbxq6CVXJmVqJBfKb5098q+I6IjMh1uPYf/zBwDxFHVkWa/UtPipft1VtBO/Ej6aLgpSkvyWGTLNT6hcOlAwa5NjE7njLLi2m09yEZYTQ7U4UGfcb1DUpIT/j5Qkskyw9oCVRpaAQPM85oyRDpK33snAJNBYqpxnwgLbsx19wSy7TSTCdD3/CTkoBDE7NOOfHk9yiaHm8LrL97c8SZrRVj74O0qbc9u7B3JOFw9AX22bD7pD3E7zHvfMdCbTejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+VacsDV2HoOF3faA/01T1y0reJFxLVA1aF7QYqqHqw=;
 b=WsA7JNcqYyLlQbiA09kAPDiOJeYssqgobYKks3RIQsi/MueHkOowYY4QBLuk0fAgSrvUYUJElrQ791XyBHuTnsxZDyCIpB4V1XvsNIZE/hYvhaooYKyeZ7pCsij+9mevCzYWRmnkF03IMm14qDIGVQyk8DchNZIqpV0743eWYTy0Jm3JSOH0Yxp+dU2W2GTx/8+qz7mthSCPOcmd/SKn0wATfKGmK/Um04uMcCl1cYvbbAQFi+gi88/QvpTPsEQhfWs4R1FZ05baQnBdBTrz/vYJo2DxCqqpkAE6XfUc9jSvjDIjRTiW/ruWR/+cw7C//rZVWvNIfxoBelznadLSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+VacsDV2HoOF3faA/01T1y0reJFxLVA1aF7QYqqHqw=;
 b=KuDsicWIwSCTe3pEQpvR1O+thztKqx/9C3Y3dfngrZ5M6Oj6PiMKYF4fh+/d0vJ8w7kZD5gJ6XLOyigjOZfzGRzjEnZYVF5yThVlCVSYFbNRJig4JfO2iTHrgb4/alsKKiYTTUfrHAZ3brHSscjhpclKgt5HdSkzaSVZF+TmlSY=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 05:43:59 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::d049:7cf7:c149:db9c]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::d049:7cf7:c149:db9c%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 05:43:59 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Thread-Topic: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Thread-Index: AQHaA1vGTE5tLvyMa0ybgPzGhQOZLbBS0SAAgAWiGCA=
Date:   Tue, 24 Oct 2023 05:43:59 +0000
Message-ID: <BY5PR12MB490268A93CEC6B074DA6196281DFA@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain>
 <20231020154142.GFZTKftpt4HTM4tpkH@fat_crate.local>
In-Reply-To: <20231020154142.GFZTKftpt4HTM4tpkH@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e2b8ea2a-2108-435b-8f2e-aba77b4bd63b;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T05:43:08Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SA0PR12MB7480:EE_
x-ms-office365-filtering-correlation-id: 35c10fc3-75c3-41a5-a5cd-08dbd45438af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaoXbW3YLkdtd/XLMZv5A3ryjJY6OTfJzd2+J7K7cnZCApQML6Q5tdy3DKHZEE8vlZd2bjrwo2GzUyACmxN7CZggtzAhNaiAZ6yikcS6TdxUpZAypPaWRN3UrZIHa1nYlLkdpKY3I9oZ4uL39R/uVobdKIA36wnDU/BA/r1E0X+71r8rI2LXt+G7Pnv+TJn+540649TR7GLuljOfIj4Dxvv3rPMrgSdW7lxClYWx0CY7mxai6K3qyV5Y+FOP/DGYd5nxZcCJkFBNkrjRQzlww7XmhRfSusyUBo+MIUPzS50qENKHxpxXl0iS9y2E8Zz3A1EErldALHiPZHnliWLba4y7jPb12jlVXqEmz/LyCF2Dqh6NeWMo6wj14RWsap5z+ldpfR/zAN95NJDLLS8TguEx4K7WnC88W/wAb8dedWximtBy6DoKNrd2aUAh/4yDHc6jR/1P6gg+Vg+4SdvfT+MtTI8Vwdsb8GEGD9dAw+PD8Ds+Nz6It8/fRJWy/u1HO+15hzGStHJiNUjsTRNodWWoca3GsoHLIPCTcypIQvrRVrVATAxKPpzwUWStylMYHpoKgmSZwPgh3irmeC5kO4tZhbu2HTJEjeA6JuM+G+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(41300700001)(26005)(122000001)(33656002)(86362001)(38100700002)(83380400001)(5660300002)(76116006)(7696005)(9686003)(52536014)(53546011)(6506007)(64756008)(66556008)(66476007)(66446008)(316002)(478600001)(66946007)(110136005)(966005)(55016003)(71200400001)(38070700009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHAxSUUvN243NUE5WU9rQ1ZYMnkrSEVRZlZtaUR2N2orb3pPSnQ5Q0REcm5E?=
 =?utf-8?B?bWwyU2k3VmVud2tTWUh6NkwyN3NDL1UwRXc1aGZaSWpJSE0rNlYxYncvZ3Fm?=
 =?utf-8?B?MmoyOWlOWW4zNWFIcWRCaUFlMTJlaGFQZm9rVlhlL2w3VHkvcmRubUFKSXdv?=
 =?utf-8?B?WmMydWRCd2g5d1BTT2xRRG1kNmNrSk8zY3dGSG43cXlSTTE3cWtTWDZzck5N?=
 =?utf-8?B?TFdvd08zMTB1SVVpUlpyOTUvcC9UbEtLRGNDbXR0Vzl4SUp5VHBnVWxoMmgw?=
 =?utf-8?B?MFdHODVuTjVUN01DMzRHYis0aDFwT1FuMUl1T2lRMnhNYytWR1JLV05pYkM5?=
 =?utf-8?B?ckhzOXFDcjBSRThvOVRqdDM4M3oyT090YzZSMU40dlU5VXdIb3lZL0xBbFpM?=
 =?utf-8?B?Z0hzaW5FWlByY0lpcG4rWmlhVWlzbHBRT3NMSlNQTElWRi9IV1lxS1c1cVB6?=
 =?utf-8?B?allVcjhFb1ZEUHVuQmNpQ2tiMXhWZVFnQnFDOHk0UkM5azV4eUxPR1psMTJk?=
 =?utf-8?B?b3c4WG13eTNzSG9HaitWNUpPalZYL08wZ1BsbUpwak8yU29CcXFOOWEveFdU?=
 =?utf-8?B?Nzd3SkFsTkpwOTFmMjJ1TThHYzNVR0RHUTJvS2Z3Uno0ekJlOW5IcE5XRUIr?=
 =?utf-8?B?WFZQL3VkNmY1MzZYblViV3hOTmZqZjg1UlJPc3I3TVltUnFIcFNlbzQ0Mzh0?=
 =?utf-8?B?bWNuRWNaN25KdmlDaGphdnBIVWhNL3RtcXRwbjBhbk15S2JFcVJlc1FpeHpp?=
 =?utf-8?B?aE5GSXJkaTMyNTFPU04wSXZ5SWpLaUtQWUlJYktSWUhXSitiRDE1MFA3MmJX?=
 =?utf-8?B?U2Zhd3NSUGlNakxvTTJEeGtjMmNkc2RMTEFETVFRQzJZaHdSNjRJQ0dWT0tN?=
 =?utf-8?B?ZnhXZUVEeGFXVk54VTlNT3FhNjBtbTRKcUV5MythamlPN1RLLzU0R2JoVzBs?=
 =?utf-8?B?eFNXUFhhR3RtdHNQUU11RkdBenJBMGJFdGE4V0VPbmZYcEdJNEhFNWJMTk1N?=
 =?utf-8?B?U21ieUJuMHdEOXhMRGFxcXlvUW5FTys4WE04RmRoaWVEcU5FbGVPRG9jdmJh?=
 =?utf-8?B?blZ1TTg2TEE0Q3h3STRFMGdydHB3V1orL2RjdkZwWExDK1lDMEpwRjNHa3hw?=
 =?utf-8?B?dkN4dE8wODNHWkpxNFkwMXBYemdjTXNObUhwUlBaTDlVWCs5cUlEaHBZRjlT?=
 =?utf-8?B?dDdUTXY0R3NmWnMxWGxVb3RjTUd2UXVMZVpaV3JJdW9wa1VXZHhueGlYWS90?=
 =?utf-8?B?bFZRS0VBOGZNQmFZb2lWWkVYa1ozdmhLUFNzU3Z4UkNEbGUyTDhCak1LNmxz?=
 =?utf-8?B?bXFDckNGci9ZTjR6YjQwOEsxRXVUZjlGT1c0a3A4N05kTWMwbkFWdjVSWjQz?=
 =?utf-8?B?d1paNDcvZDFFaXFKL0pjVnA1bGdCSzNWMVVSanFKeThUWGVMMmQ1V2xIcVFi?=
 =?utf-8?B?SHRZQ1RvcmZTOFh5V3BXa2MvSGxPOUptd3doQ3lYS1VHYjJwdkpoV3dPZHo2?=
 =?utf-8?B?eXpBdUsxVGRSTDI1MUpoSXNJNSt6SlJVajFTeDVQY1VIbTM3a1NpKzBTajJI?=
 =?utf-8?B?USt2aU1VKy92S3R6SDlxTFVzUVYrdkZMV1hFdjMveElQNytHOWFDLzE1bHpM?=
 =?utf-8?B?SUI1VThLZTF0aFRmQ2tMOE9Bc1lnbWNicFZzcWtiZXN2VEwxTExETG12RXBh?=
 =?utf-8?B?Y0luSncrT2RSVGNPRWNjdGFQNFFoek5PRW5TY1JObEt3WU8vS3VsSklHSEFW?=
 =?utf-8?B?VjhFczU1NUhrTW0zclBDbGVhNlI3UXEyaGMzOUVJQXpHb0pNSE9tNnFjLy9S?=
 =?utf-8?B?RGcycm8rdm8ySmVyajg2YWFBbzBDSHZRSnl3bXUwUVEzblhld1dieStlUnI2?=
 =?utf-8?B?Vjh6eE02bWZWKzdJR0ZXaHY1Y1ZZT0RpaFVVKzhuWnNWeEExc0dNZlBGNElZ?=
 =?utf-8?B?Qmp1OTM1ekxyd0lQTWlxMWoxQWJwT3daQ1cxTlJta0xNSTR5dUxudjB0VStw?=
 =?utf-8?B?ZGwrNkJEdGtWWnNZS1ZWV2QvdHNYeHlvK1lvUXVrTXR0UUlBWFdSbU1nQTFB?=
 =?utf-8?B?YmZnWmJKTC80RkVTb2syejBRQWlkTlJsR1VhRys5QzNrbk9pWm1oKy91Mldw?=
 =?utf-8?Q?pT0M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c10fc3-75c3-41a5-a5cd-08dbd45438af
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 05:43:59.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zjRXureyjdy70eGLPZSG6PLWL1T+nFskdPkX4QC7/Zkb1grNXZn3b1h2wzagKivuLhyHadMzLi4u0Gy7upI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6
IEZyaWRheSwgT2N0b2JlciAyMCwgMjAyMyA5OjEyIFBNDQo+IFRvOiBEYW4gQ2FycGVudGVyIDxk
YW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IENjOiBEYXR0YSwgU2h1YmhyYWp5b3RpIDxzaHVi
aHJhanlvdGkuZGF0dGFAYW1kLmNvbT47IGxpbnV4LQ0KPiBlZGFjQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW2J1ZyByZXBvcnRdIEVEQUMvdmVyc2FsOiBBZGQgYSBYaWxpbnggVmVy
c2FsIG1lbW9yeSBjb250cm9sbGVyDQo+IGRyaXZlcg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0
aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+DQo+DQo+IE9uIEZyaSwgT2N0IDIwLCAyMDIzIGF0IDA0OjQ1OjU3UE0gKzAzMDAsIERh
biBDYXJwZW50ZXIgd3JvdGU6DQo+ID4gSGVsbG8gU2h1YmhyYWp5b3RpIERhdHRhLA0KPiA+DQo+
ID4gVGhlIHBhdGNoIDBmZDkzNDU4MGVhMzogIkVEQUMvdmVyc2FsOiBBZGQgYSBYaWxpbnggVmVy
c2FsIG1lbW9yeQ0KPiA+IGNvbnRyb2xsZXIgZHJpdmVyIiBmcm9tIE9jdCA1LCAyMDIzIChsaW51
eC1uZXh0KSwgbGVhZHMgdG8gdGhlDQo+ID4gZm9sbG93aW5nIFNtYXRjaCBzdGF0aWMgY2hlY2tl
ciB3YXJuaW5nOg0KPiA+DQo+ID4gICAgICAgZHJpdmVycy9lZGFjL3ZlcnNhbF9lZGFjLmM6OTY3
IG1jX3Byb2JlKCkNCj4gPiAgICAgICB3YXJuOiB1bnNpZ25lZCAnZWRhY19tY19pZCcgaXMgbmV2
ZXIgbGVzcyB0aGFuIHplcm8uDQo+DQpUaGFua3Mgc2VudCB0aGUgcGF0Y2guDQoNCj4gSSBndWVz
cyBzb21ldGhpbmcgbGlrZSB0aGlzIG9udG9wOg0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9l
ZGFjL3ZlcnNhbF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvdmVyc2FsX2VkYWMuYyBpbmRleA0KPiAw
OGY2MzAxODU5MTMuLjg3ZTczMGRmZWZhMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9lZGFjL3Zl
cnNhbF9lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFjL3ZlcnNhbF9lZGFjLmMNCj4gQEAgLTk2
MiwxMCArOTYyLDggQEAgc3RhdGljIGludCBtY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiAgICAgICAgIGlmICghZ2V0X2VjY19zdGF0ZShkZHJtY19iYXNlYWRkcikpDQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOWElPOw0KPg0KPiAtICAgICAgIC8qIEFsbG9jYXRl
IElEIG51bWJlciBmb3Igb3VyIEVNSUYgY29udHJvbGxlciAqLw0KPiArICAgICAgIC8qIEFsbG9j
YXRlIElEIG51bWJlciBmb3IgdGhlIEVNSUYgY29udHJvbGxlciAqLw0KPiAgICAgICAgIGVkYWNf
bWNfaWQgPSBlbWlmX2dldF9pZChwZGV2LT5kZXYub2Zfbm9kZSk7DQo+IC0gICAgICAgaWYgKGVk
YWNfbWNfaWQgPCAwKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+ICAg
ICAgICAgcmVndmFsID0gcmVhZGwoZGRybWNfYmFzZWFkZHIgKyBYRERSX1JFR19DT05GSUcwX09G
RlNFVCk7DQo+ICAgICAgICAgbnVtX2NoYW5zID0gRklFTERfUFJFUChYRERSX1JFR19DT05GSUcw
X05VTV9DSEFOU19NQVNLLA0KPiByZWd2YWwpOw0KPg0KPiAtLS0NCj4NCj4gVGh4Lg0KPg0KPiAt
LQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+DQo+IGh0dHBzOi8vcGVvcGxlLmtl
cm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=
