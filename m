Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793807D4C59
	for <lists+linux-edac@lfdr.de>; Tue, 24 Oct 2023 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJXJai (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Oct 2023 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjJXJ3z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Oct 2023 05:29:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF191BC1
        for <linux-edac@vger.kernel.org>; Tue, 24 Oct 2023 02:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvYbe70bzuT1ILMBPlMDMosfw0Kzwp7Gpjd+G3NyhnNxF/3KJxbJzjfLMXAr6sJYxNZR6L/aJA1aCEleOr/2HlWvpi0J9DcDlLvFyVhMIJUfPgZ55g1LPvuLc++2sHjLFXO6lsEOy2tFCWn8lTeOviiF/jw7KgFJuC40PpKGy2n5OKMUOAuLNdn0pOYflL31dCtfnPupEz9ExFaHJi6/W+kGYzwCwBrysh1fMs18xr7tP88VOUlSB/GW2yNSrTUnq16qf6vbtZj7V5XmyF8fyEx0zeX73RewXUOtiSO8n/7B9PZC9YHCCAISVjfrAcYp741FF+q/J3yMBPM8auRkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUIwFJRgxMhFxBXEHI5QY1wUWYIVRkGfAZ31gZXQREc=;
 b=kRiao5CnupeJ86e+tPvb/jaFwT11ulOpbcHIkqUngYMQD7/vq9xarFK5bxB2Td1mtJfDjzN3FShwcvtdImaXF2q36B68IiS4Fb9vWT3gftySDg79+iDy3rHKBYdrIs4ZV31SfWaA0IiYorovHkPcRCMxiLoztgJl82AnXsIgp6l2Ufnjkhqc2dPuMmEvv/4iNaVr5hhso4MqFVr/khMndwX5cg+zMC2lQY80t95LzVVaWkgXBeGmd6OCtG7elAvvenL2FUi3DkPb4ceh57Xq+o7lGnDovkNkgGx3PCqrBOtt7sKDI6zCz+2gzAH3AL4StqhJMgbQUeRZyUwSc9iI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUIwFJRgxMhFxBXEHI5QY1wUWYIVRkGfAZ31gZXQREc=;
 b=XZmYr28CSYWR+d0DkccyL7+Hd9zp0t746wICbIj+dlnMTsTI/BLxBYRHNm5v/Z9uPjuCdLfIw+R5ke7GpHYHRaWnIdeKem6w4XGHMvPeUAgT5zp2aYNq3x+G11fpv+1IFFOB+/8uoxoMco3ngjM4+UEfs4OOeDdkhuf02XTGtBU=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 09:29:10 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::d049:7cf7:c149:db9c]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::d049:7cf7:c149:db9c%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 09:29:10 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dan Carpenter <dan.carpenter@linaro.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Thread-Topic: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Thread-Index: AQHaA1vGTE5tLvyMa0ybgPzGhQOZLbBS0SAAgAWiGCCAAD48AIAAAExA
Date:   Tue, 24 Oct 2023 09:29:09 +0000
Message-ID: <BY5PR12MB4902A572453E8913F886C77281DFA@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain>
 <20231020154142.GFZTKftpt4HTM4tpkH@fat_crate.local>
 <BY5PR12MB490268A93CEC6B074DA6196281DFA@BY5PR12MB4902.namprd12.prod.outlook.com>
 <20231024092554.GAZTeNoqT7HQQzb08U@fat_crate.local>
In-Reply-To: <20231024092554.GAZTeNoqT7HQQzb08U@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=630b564e-19e4-4afd-9bb4-912e781feffe;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T09:26:57Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|LV2PR12MB5895:EE_
x-ms-office365-filtering-correlation-id: 57cbd981-fd0c-414e-da1f-08dbd473ad8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTJZHBCIYIxO47rBl1PB+FAGm6JazCUfWZz4eNLsq+WFjLjkQ7QnncHrPvbUPhvzkHQBTP7FwjT32BINLpV5bHNvIBmf0BazoFE9bmlmqbTRzJrAGL1v2Cu/5Bux9scStfWGT5r0wUeNkz1H+UC7xSB6n4Grpe47nNPcwUNv7xaCmndx+04kkWhAkGIDjti35xVI7DS4lg1vzv6MOncKn6pqqZMwTBkO26CTy6GueTAdsKCW6vFzZpUBFtoLXUCUSmWAQhGVySqbLDQruVVJpYwSFOWuzUW0giY8wkf94zA+ahzVV6tfU7yy9H1NAENhSvEOht+m5KPpbFdWp5eHVm75rLhvpHuaG7+0/WX8jOK44amVxm5646wPNA8MDGt5+zY2pD2bWomdp2Osj4OnXTPAAb25mbDj5CeVp5c7l5uQ1w0j95VXq061urlAcN6DdD5Ir8+7nmAP18SiNewGBL4WzehKHsxUFYJ6009IB0c8hYySlwPaul2tgTidWSI9Fua0CXeF+uHVhGiuabNAPYR2bdRRA182GplksIh9aGDt/bmbK4L//Y9pR/tV63e/yxRJWrMLpgm72X27ZYjR4nvfAlMBco3VdOpNIfn5vZi6RQ2lvQFgp5A8bLVUSLdV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(55016003)(83380400001)(53546011)(2906002)(33656002)(52536014)(8676002)(8936002)(71200400001)(38100700002)(122000001)(26005)(4326008)(86362001)(7696005)(9686003)(5660300002)(6506007)(6916009)(316002)(66556008)(966005)(478600001)(66446008)(66946007)(41300700001)(54906003)(66476007)(76116006)(64756008)(228954003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0g2TTBDUzkrUTcxcDNnNmsvZndsbzZ4TkRvTWxYQTVTNkt6TkUwb1RpZWZk?=
 =?utf-8?B?TXRrdEJ2SXZDVXl5MmNTRTVDWFZGQk05emVxdXRENTlhR2VjcFF5SmwvY2Ez?=
 =?utf-8?B?Z3pSbUdYK0hqS3NLOWZNUHhUYXkrM3VpbStZMXJpSURHazZIOGRqQWdJZ3E3?=
 =?utf-8?B?eGd0MWo5WTdnRWNCSS9mdzFBRXE5bFlGV0llVFBVL3RLUys1eFVuMEVzRUxv?=
 =?utf-8?B?c0VXUzgrTUFSSUR3aW9xejdXTVk2Vm44ekxLS25ZTzhydHYra2RBMFZBWjVB?=
 =?utf-8?B?c1g3N0R6aDNHbVE5WHVUNmFpOWo3VElLQnZabytZdCtDY29qLzNBUG1JNWUw?=
 =?utf-8?B?UnZFb0psMDJTWjZZYzBmZ2ZjRGc5TCs4U1VFR0FXemozaWVQTUpucCtzK3Rv?=
 =?utf-8?B?RDArQ1ZrbG5QT1QycVU1S2hGaVYrY1lMZGNCcVJpNzJkdzlMOHRvUm1HU2pZ?=
 =?utf-8?B?TzFPaGo4dEtQTlZPamZyQmtnM2tMNzJTRmgvalBYd3hrT1l2RVlRZU9Ealoz?=
 =?utf-8?B?QVhDMkNsS0tHazJXdkJNblRrSmxnSnJDaldCTm8yTm15eWVLNFAyQVBNVUow?=
 =?utf-8?B?SkNRYjZOYVFGMHg2SVljSXM0b0tEQ0x1aWNyc210ZEJyc1VNUnRUYld0RzVv?=
 =?utf-8?B?ZzdmMEZSY2ZXREIrNVF3NjVnR3MzMkdMOG1jQ2c4OHRydUpnb2QwT2pJSjRI?=
 =?utf-8?B?ckVISHVZQyt2Yk5HUm5Mem1pNGdTaktIeHBXc0JwVXFVaUk2c082VmJWdFR1?=
 =?utf-8?B?eGlBMGZSbDZvOHFWYkRpTGF6b0tHYktFZzRUeWRmL1pvbG8yR21kN2grSnJk?=
 =?utf-8?B?aHZiOU9BSGJHNHdPNU5qWnJMSUYrQ3JycmZNMW00cWx0YmpzQjlGVjllS3NT?=
 =?utf-8?B?MW1SSThFdjNxdlFaQnNBbFlJS0lrcitjaVNUL2R3Nm13MU9CcXB0V1E4L0RY?=
 =?utf-8?B?MWo1NFpQSnhNSjNFNTYzcjd4ZTdsSXFsYzFtVmNTSXNMYVQzQTRtbmJlWmc2?=
 =?utf-8?B?R2h5UzFrTXRzdmtLYnlEeU1WNnRLSWdmb2hVSGJOVWdHYlhwbWJYTFFUbTRL?=
 =?utf-8?B?KzM2VmhhK3NkbnQ4aHY1MDBuVDRXc3RKUFNGc0duYnU1eDFNYkFpbXBCWmNC?=
 =?utf-8?B?d1ZkbklpU1BMYXRvR0ozek1yaW84cjhXYTlIUmlvNHlZQ1FrSXZ0dnZUSjhy?=
 =?utf-8?B?d3pUVmxMRzFwbEZmelhGbnlZZUZVSllOZzJ3Z3RRQ0Z3azRybHpNbnlBdDJq?=
 =?utf-8?B?KzduSkhlcmkrYmJnZGh3QTBVcERrWU9yS2xVSGZjaUM5SDhKK243Z3NXME5W?=
 =?utf-8?B?RmlCYm9GV2cwelRQdUN1b0lNL3VNb2F3SzFBSG8zN3FDZndYT3dKMUtURTlp?=
 =?utf-8?B?aSt3dHhDZnM0MHROUDNoYkNOSVVGUlZxR0tDcXZBMGVMM2szZkFuVy9HclRh?=
 =?utf-8?B?SVp5RnNrN3ZUWU41RXVMSHZSTnhrNThtOU1iRFlIb002S2ViYW5XY21vQVRn?=
 =?utf-8?B?RUh4RU1CZ0FmRGUwcFRHYUdjZVBYS3k1Ym1iaDVYVnFBdlRIUUM0MHhULzlD?=
 =?utf-8?B?N1M4Z3JVdmhBNUpMWUxLTHBXMGV4MkwwNGhXdXJGQWFKbmFSb3gvZTVHcHpI?=
 =?utf-8?B?RnI0K2RXSUFQYWZ2eTlBam9RN1hXbG92RDRGZTRHa2hRZWFVb2tmOS9JcUZo?=
 =?utf-8?B?VklXUVR0eTQ4UTY4d2hJVklLb3g1YU01bWxRZWtUZmhES3lJVi9DRWQyaTFJ?=
 =?utf-8?B?dDlMSGhBcDUyRFl6cE0rRG9UanhDaUtjRTN5N2dXdTVOQlZNVGtCZVNXZC93?=
 =?utf-8?B?UzFzSjVYOWtQaGhHL0pxeUhyakhLaW9zTFFYS2tNa2U3dlcra1FxZTdxME5q?=
 =?utf-8?B?QnAxaVkwQlJjYW9hK0M5aDdvcUFKVmtZMDdrUUdjMWJsdWFScDlaVUI0cTgx?=
 =?utf-8?B?K3pNTVhCQ3JXajdpRUJ4WlhTQmhrdHRwSCtkQWQyVmVid1lreUc0TXpaaDV1?=
 =?utf-8?B?ZmJLQkJrdlozZm14QVhsbzZzcFBuOVdpMDFaN3hWcGhkSFBnTFVwdjQxNm5x?=
 =?utf-8?B?Z1ZRRVRlb3VzQ2VkK3AwSFBRSndMUnROSEVQbXFkWEpyQy94M0dnSHFtU3Nn?=
 =?utf-8?Q?5o/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cbd981-fd0c-414e-da1f-08dbd473ad8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 09:29:10.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/DgwYj7c3E0iMhMJL3fQAJD83MRgzbFjsUxuTUPKjAx7UzWjs59GiaPJ0KB4hNfvcWm4a2RqOHwwA5el15nYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMjQsIDIwMjMgMjo1NiBQTQ0KPiBUbzogRGF0dGEsIFNodWJocmFq
eW90aSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQo+IENjOiBEYW4gQ2FycGVudGVyIDxk
YW4uY2FycGVudGVyQGxpbmFyby5vcmc+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW2J1ZyByZXBvcnRdIEVEQUMvdmVyc2FsOiBBZGQgYSBYaWxpbnggVmVyc2Fs
IG1lbW9yeSBjb250cm9sbGVyDQo+IGRyaXZlcg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ug
b3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9u
IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcu
DQo+DQo+DQo+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDA1OjQzOjU5QU0gKzAwMDAsIERhdHRh
LCBTaHViaHJhanlvdGkgd3JvdGU6DQo+ID4gVGhhbmtzIHNlbnQgdGhlIHBhdGNoLg0KPg0KPiBU
aGlzIGlzIG5vdCBob3cgdGhpcyB3b3JrczogeW91IGVpdGhlciBhZ3JlZSB3aXRoIHRoZSBkaWZm
IGFuZCByZXBseSB3aXRoIGFuDQo+IEFja2VkLWJ5IG9yIHlvdSBkb24ndCBhZ3JlZSBhbmQgeW91
IHNheSB3aHkuDQo+DQo+IFdoYXQgeW91IGRvbid0IGRvIGlzIHRha2Ugc29tZW9uZSBlbHNlJ3Mg
ZGlmZiBhbmQgc2xhcCB5b3VyIG5hbWUgb24gaXQNCj4gd2l0aG91dCBhc2tpbmcgZm9yIHBlcm1p
c3Npb24gZmlyc3QuDQo+DQo+IFRha2Ugc29tZSB0aW1lIHRvIHJlYWQgYWJvdXQgdGhlIGRldmVs
b3BtZW50IHByb2Nlc3MgaW4NCj4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzLyB0byBnZXQgYWNxdWFp
bnRlZCB3aXRoIGhvdyBMaW51eCBkZXZlbG9wbWVudA0KPiB3b3Jrcy4NCk15IGJhZC4gSSBtaXN1
bmRlcnN0b29kLg0KPg0KPiA+ID4gSSBndWVzcyBzb21ldGhpbmcgbGlrZSB0aGlzIG9udG9wOg0K
PiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvdmVyc2FsX2VkYWMuYyBiL2Ry
aXZlcnMvZWRhYy92ZXJzYWxfZWRhYy5jDQo+ID4gPiBpbmRleA0KPiA+ID4gMDhmNjMwMTg1OTEz
Li44N2U3MzBkZmVmYTAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2VkYWMvdmVyc2FsX2Vk
YWMuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9lZGFjL3ZlcnNhbF9lZGFjLmMNCj4gPiA+IEBAIC05
NjIsMTAgKzk2Miw4IEBAIHN0YXRpYyBpbnQgbWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqcGRldikNCj4gPiA+ICAgICAgICAgaWYgKCFnZXRfZWNjX3N0YXRlKGRkcm1jX2Jhc2Vh
ZGRyKSkNCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOWElPOw0KPiA+ID4NCj4gPiA+
IC0gICAgICAgLyogQWxsb2NhdGUgSUQgbnVtYmVyIGZvciBvdXIgRU1JRiBjb250cm9sbGVyICov
DQo+ID4gPiArICAgICAgIC8qIEFsbG9jYXRlIElEIG51bWJlciBmb3IgdGhlIEVNSUYgY29udHJv
bGxlciAqLw0KPiA+ID4gICAgICAgICBlZGFjX21jX2lkID0gZW1pZl9nZXRfaWQocGRldi0+ZGV2
Lm9mX25vZGUpOw0KPiA+ID4gLSAgICAgICBpZiAoZWRhY19tY19pZCA8IDApDQo+ID4gPiAtICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPg0KPiA+ID4gICAgICAgICByZWd2YWwg
PSByZWFkbChkZHJtY19iYXNlYWRkciArIFhERFJfUkVHX0NPTkZJRzBfT0ZGU0VUKTsNCj4gPiA+
ICAgICAgICAgbnVtX2NoYW5zID0NCj4gRklFTERfUFJFUChYRERSX1JFR19DT05GSUcwX05VTV9D
SEFOU19NQVNLLA0KPiA+ID4gcmVndmFsKTsNCj4NCj4gQXMgdG8gdGhpcyAtIEkgYWxyZWFkeSBt
ZXJnZWQgaXQgd2l0aCB0aGUgZHJpdmVyIHBhdGNoIGFzIGl0IHdhcyB0aGUgdG9wbW9zdA0KPiBv
bmUgb24gdGhlIGJyYW5jaC4NClRoYW5rcy4NCkJ1dCBhbnl3YXlzIGZlZWwgZnJlZSB0byBhZGQg
bXkNCkFja2VkLWJ5OiBTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUBhbWQu
Y29tPg0KPg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+DQo+IGh0dHBz
Oi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=
