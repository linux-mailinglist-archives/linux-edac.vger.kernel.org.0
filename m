Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576447562C1
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jul 2023 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGQMbR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jul 2023 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGQMbQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Jul 2023 08:31:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557FE60;
        Mon, 17 Jul 2023 05:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYhs3zwRXqyOfwy0OPl5IyomvHqeT59yWw0RCpewxs8e8nXNdR3FconWE142QifcVAwy5llZOx+ttQieQTFTigZj5pc2W0jxPtBcr64tiXznYngVCzyFxLkHxPkj6kjQvw1kGTaMbn1wpgdsoHgtIr2og5k72EnGXIv6AwR5mKD+BCqyY/vMBpjLnYxZRTmtJiJYr43EJQ3N6LWmFpFUHBpG2mKU7sMCJvKliiR+HCy34kGODiuvKj/tCxkvGH9pH+dAwqfPL9FzNxktzEzitkSwzPH/8vU2wlO4tOz3wKySQyVXuRsgzimlh1NSLNM+VRBiiui0UIe7DdP8s+Dvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNz5XbAjKbOi7vezFIfY3tQQBlSwlKLoMNdE1i51bek=;
 b=DqpjnOr4Gis7SMX2YbDyPwCr9qaZnmHctKxDLIQeTiU8YzJUXDnR8P/9eGBflMgmuYjThR6gcWge5J8lhSD1aVF8ol0zhNFqM8MjpZt998CLBFfPa8zYVMgF54ir9jA35zVk5WbobpL5UcHare1ti8hVpNGZ2Jjd+lkE15Tw/ThjMZrqXUDVIOja+tYNlFp+4g6ALtYxfd58i6yZv3pb+L41VZLJmwqa+dcnPTUntamZR3AEvIJqQeZJNRvWRCzkjHZQfKRc/p7RlfTiXhKkhDorGaPJUi6Pkyroa5grAoWKIi1V0/HEjhGXCbrlkfhs9ZsLd8ZYom0gZf9K1NySng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNz5XbAjKbOi7vezFIfY3tQQBlSwlKLoMNdE1i51bek=;
 b=0n7HhxA251uyGbFAUppO17RDuvzYOXtW3CDgGwGY/zwPJU3orBEeJjilqBscgjnkrqrZbrtk8cVE67Wktu1VUt5LnYaEWIGlpz1xwog9wF7oKQfFrzZMhhRI6yiPM/3aZuWMZW13tzRKRMfi3XRJYd1lHWKCyAFBaDsGG0vDA30=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 12:31:09 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::1814:46ae:a86:d75b]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::1814:46ae:a86:d75b%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 12:31:09 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: RE: [PATCH v7 2/2] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Thread-Topic: [PATCH v7 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
Thread-Index: AQHZnnjLF4C/u+e2JE6wqrnH8YWR36+90aWAgABE5EA=
Date:   Mon, 17 Jul 2023 12:31:09 +0000
Message-ID: <BY5PR12MB49024D6631D16B3BA68840FD813BA@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20230614042852.5575-1-shubhrajyoti.datta@amd.com>
 <20230614042852.5575-3-shubhrajyoti.datta@amd.com>
 <20230717081841.GDZLT5Yc/PT77hZ+Xa@fat_crate.local>
In-Reply-To: <20230717081841.GDZLT5Yc/PT77hZ+Xa@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=80f34cf4-f00f-4dc2-9d80-b7effd0dfe33;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-17T12:25:15Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: 79f407d9-dce2-410d-60b9-08db86c1b300
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqZuQ1eH4AX/EkbnVhzsT0gnrUAyrNv4FwWs9D2Jnx12XhofZZd1ScBd65Wxrv97pxY92VqIfB77XP3weYFJYxRXCNmnKQiT14FUG0C9XNkZKv5d4FWR1vj72MIs7ccmP+/BkReL4J3gQkoX3rone5JwG5U5yM76wpXV8eP6rNqLLjYOKnUlQRaDOnxPhG7qeWNr4myhQc28LzgZMrzpAWaqEq94Wtsk/up//pJCp+ZFHX1mYpgG5SvbXOf6lvUe4A0W1+zR1VGhp4AfxjvcIgaFY+/Xo4kgAJTvRBCj/LexrrWpBSqzSs5HUN6aZYChCluGGjtpuRO36O+MbTEPCH3P2VGvm4Sg9NuPWjestGyhu76vh6bDmZmBrtFtwCMGx2FvRv4J4En6lNrhCWX3SZ4NxmlIDuFYZgFglzq63TeteCVWZH0xn6FGc9m27FC4UjBRNYdRJSsq9GJ2qw4LWptVxVYhiqVMdP1mBiM53zocbxh4VhDm65VciSJqwVXSdcGQIDDTmfWZKMFM+lbLh4A9SvR3R0UmAKTLmtudHgXzMVOdAhY7NWZFGDH0JnsAHkLT+uFGpELdthjt/wmeH4DEBD/M3GxXU/POashZ/Uw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(83380400001)(38100700002)(38070700005)(86362001)(122000001)(52536014)(6916009)(8676002)(316002)(2906002)(8936002)(7416002)(41300700001)(5660300002)(4326008)(66556008)(66476007)(66946007)(76116006)(66446008)(64756008)(33656002)(54906003)(478600001)(7696005)(9686003)(71200400001)(966005)(55016003)(26005)(186003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmUxa0JrRGlhVm5KYkxFTURmYVorcHlocjdnR3ZGVDUxd1JXeUJJd0M2dWhy?=
 =?utf-8?B?V1R6cm05N2ZJdDNGelltYU4wSFFaQ3lnY0lIQXJ2bVBGUTVHREcrNlJUdEMr?=
 =?utf-8?B?SnVBSE9YUGhBQ2VSeUd5amtJUlFmRXdPcklZbjVKKzJTTGlYalRWYkpPUjZV?=
 =?utf-8?B?Ny9OaDR4SUpva0xFTjNhS2JkUGU4bFIvTk1yc2dsbEM2VUlEOE1qMm82WGxa?=
 =?utf-8?B?VEVJUnBERm82UUlaVXZFRDc4NEZxWUJpWXJ2dVdnL00zalNPZlg5SG14dXJZ?=
 =?utf-8?B?OGxOWndRckpNTVFMV24vbEJ6ZVZYbzV2ZnpWZVpZcWlXTXBmVWlaeEVxZUZR?=
 =?utf-8?B?UVcxemQzRDBZMWY1MnFxUXkxSXF3TFJkcU9vU2J0RHlsM2RPTzlCYXgyWjRI?=
 =?utf-8?B?U1FvRC9VUkZ0YXdWaXdEeUtUSXN5VWR3ZEZaNHJjaGx3akRmWS9xeWZyWVYr?=
 =?utf-8?B?OEhyRWhMYjRqY2g5dm5NUHNMRUx1YVNLYndjWlJHOU5lQkNURTE1S0o0ck9B?=
 =?utf-8?B?UU1TTzB5Z3FHVUNrT3dxb205dTRLaW9vazJWV0NrSktnSWRWaGVhdzJMMkFq?=
 =?utf-8?B?QTc4NEF3WVYvajlrU1QyWllsMldWWFFUcmRvYWRyL2E3Z0Rrbm1XbXp5RkE5?=
 =?utf-8?B?cWhkUFNURVkxUzJGNE9SU2pWc2VFTGp6ckgwZWVVdXlQNFlyTkt4V01LVldW?=
 =?utf-8?B?Q2p4eXJyMldRUnFJanV0UGYyQ1h6OUc5MlVpTDVVSGhTSnE3bHBXSXptdy9s?=
 =?utf-8?B?VXZzV29GajBtZTI5ekZSbWh2ajF6d0xORHFaa1plelcwUnZWNkdZTEt4WTdW?=
 =?utf-8?B?K2d4VDI4bmcwcVRmcU9rU1M1KzArRGhsbWhLSlBnZkQwUjJvcDV6Z2Q5ZWNQ?=
 =?utf-8?B?OFl6ZG9qbENLWlJkTXBIaFF3ZE5Hd2Y4QStOWnZWSDFnc1luZFhxeURBclpr?=
 =?utf-8?B?cXFmRCtsWXFNVVMvZ3creGhDd1ZQck4wUHV5c3dFaW5IR0h0dGp5ejFyb1lO?=
 =?utf-8?B?VnR3bUFtNkY4U001UWw3Y1QxNlFKNTE3ZzAxaWNZSUUxRVErcE5sampHTGhT?=
 =?utf-8?B?SFBTZjFYREVOU0lzT3QyQjVHWDVQUmd6Q3NGVTVLY0tHWVo2KzNyck9iSXZN?=
 =?utf-8?B?NE1LUnB2aTdIN01zUElTNEZ0M1VpbnIrWHFsQkRKZXlMV3NOa28zYVEzNjBI?=
 =?utf-8?B?TW8vWTZvWVdnVWhrcGRQWlZVRkxpWU1ab29iMVhiVlBka21qSGQ1YWtaMGNx?=
 =?utf-8?B?Nlp5QUVDTDYxY25VcFFmZVAzUXRvWjlyM3NmSU9McFZQSytSU3hjWnNibU9s?=
 =?utf-8?B?eGFOd0hFTnFnV1NENy9SWnY4eE5UK1B6S1dmN0VUbHh0Y0RhVDNTWnBLSmMx?=
 =?utf-8?B?SFZIQ2ZXZ0M5cE1vd1RXYi9GSkNzUE4vU0JWNTBCUmM1UnFjbzJ1cEVSVzlQ?=
 =?utf-8?B?cTQ5U2VpMWxRL3ZzSUtEbERxSnozTWlsajdDQ05wTnVUQlRNdWV6cnJZOTBO?=
 =?utf-8?B?YW8xTWJLOUxlMjAzQUJTWDVmZWxYQStSRzBRaFBkVjNwbkJTd3FEZ1hNdFdk?=
 =?utf-8?B?dmtzTFc1bSs2S0RFMndoYXExZVhobUltb2tOdEhYN3MveElUTjRSNUJuZFZE?=
 =?utf-8?B?WWJyR2RNU1NCcnJEckxMYmVtREZSUVFza2pnYjhBa0VCd2I1SVlnRXdvbHpP?=
 =?utf-8?B?eGl1NU13Ym1JYkw2MnNXTVBGV0JKVkZTUjVuMXlYdzAzQTZoZm1zNlQ2OG5K?=
 =?utf-8?B?ZkhEbWZpWW1kSkZxL1l2MFplSUlBbDVibG02aCtJOVBwbEVsZ25VTFJSZUV5?=
 =?utf-8?B?ZGVsSVFVUjBnWUpQbDhzNHNJalUwd1NzdHhHenFyUmgzVks5cjM2aDlZSFJE?=
 =?utf-8?B?bnNSUTNXTDhoUzUvbXdiTTd2VjRpN2ZnelhMNGFtaFlWOTBHWUZDNVpuV0ZJ?=
 =?utf-8?B?WHBxcmdqajBrdmZUbHZ3R3FFcEJBbzgxb3YyMUFkcC8wWkh0ZlFYSUFjR3d0?=
 =?utf-8?B?dVVKSDhiRlkrbDFqRCtvTkU1SWJJWGppT0hFZWdwV2dPejhzZHZ2eGhzUHRM?=
 =?utf-8?B?cXlMNmMrbi9EVTBYUmJKSk9KYXVzRUJqWnU2d1h2TVBsODE0aTFNWXM5Q0xt?=
 =?utf-8?Q?3ZcU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f407d9-dce2-410d-60b9-08db86c1b300
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 12:31:09.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2c8tS9G++Q0Th4TlQ7IhL3FGE/cIbjO3YmP5XLy0l3lTB0GzlQsiftxy6wAd/DQr0MWcQMIEV466kvJ/ZyBs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEJvcmlzLA0KDQpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Qm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxNywg
MjAyMyAxOjQ5IFBNDQo+IFRvOiBEYXR0YSwgU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0
dGFAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFNRC1Y
aWxpbngpIDxnaXRAYW1kLmNvbT47DQo+IGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IHRvbnkubHVja0BpbnRlbC5jb207IGphbWVz
Lm1vcnNlQGFybS5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gcnJpY0BrZXJuZWwub3JnOyBT
aW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IHNib3lkQGtlcm5lbC5vcmc7
IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0K
PiBjb25vcitkdEBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBFREFD
L3ZlcnNhbDogQWRkIGEgWGlsaW54IFZlcnNhbCBtZW1vcnkNCj4gY29udHJvbGxlciBkcml2ZXIN
Cj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEp1biAxNCwgMjAy
MyBhdCAwOTo1ODo1MkFNICswNTMwLCBTaHViaHJhanlvdGkgRGF0dGEgd3JvdGU6DQo+ID4gIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDcgKw0KPiA+ICBkcml2ZXJz
L2VkYWMvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDExICsNCj4gPiAgZHJpdmVycy9lZGFj
L01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIGRyaXZlcnMvZWRhYy92ZXJz
YWxfZWRhYy5jICAgICAgICAgICB8IDEwNjUgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5oIHwgICAxMCArDQo+ID4gIDUg
ZmlsZXMgY2hhbmdlZCwgMTA5NCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2VkYWMvdmVyc2FsX2VkYWMuYw0KPg0KPiBJJ3ZlIGRvbmUgc29tZSBjaGFuZ2Vz
IG9udG9wLCBzZWUgYmVsb3c6DQo+DQo+IFRoYXQgdG9nZ2xpbmcgb2YgaW50ZXJydXB0cyBhdCB0
aGUgZW5kIG9mIG1jX3Byb2JlKCkgaGFwcGVucyBvbmx5IGZvcg0KPiBkZWJ1Z2ZzJ3Mgc2FrZSBz
byB0aGV5IGNhbiBtb3ZlIGluc2lkZSB0aGUgaWZkZWYuDQo+DQo+IFJpZ2h0Pw0KPg0KPiAtLS0N
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNGYzNTE0
ZTgxMTZhLi41NjljNDgzNjg0NTggMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBi
L01BSU5UQUlORVJTDQo+IEBAIC0yMzQxMCw3ICsyMzQxMCw3IEBAIE06ICAgICAgU2h1YmhyYWp5
b3RpIERhdHRhDQo+IDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCj4gIE06ICAgICBTYWkg
S3Jpc2huYSBQb3R0aHVyaSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT4NCj4gIFM6ICAg
ICBNYWludGFpbmVkDQo+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS1jb250cm9sbGVycy94bG54LHZlcnNhbC0NCj4gZGRybWMtZWRhYy55YW1sDQo+IC1G
OiAgICAgZHJpdmVycy9lZGFjL3hpbGlueF9kZHJtY19lZGFjLmMNCj4gK0Y6ICAgICBkcml2ZXJz
L2VkYWMvdmVyc2FsX2VkYWMuYw0KPg0KPiAgWElMSU5YIFdBVENIRE9HIERSSVZFUg0KPiAgTTog
ICAgIFNyaW5pdmFzIE5lZWxpIDxzcmluaXZhcy5uZWVsaUBhbWQuY29tPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9lZGFjL3ZlcnNhbF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvdmVyc2FsX2VkYWMu
YyBpbmRleA0KPiA0YWEwNzNmZmE4MjcuLjA3YTA3NjQxMTcyYyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9lZGFjL3ZlcnNhbF9lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFjL3ZlcnNhbF9lZGFj
LmMNCj4gQEAgLTE5NSw3ICsxOTUsNyBAQCB1bmlvbiBlZGFjX2luZm8gew0KPiAgc3RydWN0IGVj
Y19zdGF0dXMgew0KPiAgICAgICAgIHVuaW9uIGVjY19lcnJvcl9pbmZvIGNlaW5mb1syXTsNCj4g
ICAgICAgICB1bmlvbiBlY2NfZXJyb3JfaW5mbyB1ZWluZm9bMl07DQo+IC0gICAgICAgYm9vbCBj
aGFubmVsOw0KPiArICAgICAgIHU4IGNoYW5uZWw7DQo+ICAgICAgICAgdTggZXJyb3JfdHlwZTsN
Cj4gIH07DQo+DQo+IEBAIC02MzcsMzggKzYzNywzOCBAQCBzdGF0aWMgdm9pZCBtY19pbml0KHN0
cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwgc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICAgICAgICBpbml0X2Nzcm93cyhtY2kpOw0KPiAgfQ0KPg0KPiAtc3RhdGljIHZvaWQgZW5h
YmxlX2ludHIoc3RydWN0IGVkYWNfcHJpdiAqcHJpdikNCj4gK3N0YXRpYyB2b2lkIGRpc2FibGVf
YWxsX2ludHIoc3RydWN0IGVkYWNfcHJpdiAqcHJpdikNCj4gIHsNCj4gICAgICAgICAvKiBVbmxv
Y2sgdGhlIFBDU1IgcmVnaXN0ZXJzICovDQo+ICAgICAgICAgd3JpdGVsKFBDU1JfVU5MT0NLX1ZB
TCwgcHJpdi0+ZGRybWNfYmFzZWFkZHIgKw0KPiBYRERSX1BDU1JfT0ZGU0VUKTsNCj4NCj4gLSAg
ICAgICAvKiBFbmFibGUgVUUgYW5kIENFIEludGVycnVwdHMgdG8gc3VwcG9ydCB0aGUgaW50ZXJy
dXB0IGNhc2UgKi8NCj4gLSAgICAgICB3cml0ZWwoWEREUl9JUlFfQ0VfTUFTSyB8IFhERFJfSVJR
X1VFX01BU0ssDQo+IC0gICAgICAgICAgICAgIHByaXYtPmRkcm1jX2Jhc2VhZGRyICsgWEREUl9J
UlFfRU5fT0ZGU0VUKTsNCj4gKyAgICAgICB3cml0ZWwoWEREUl9JUlFfQUxMLA0KPiArICAgICAg
ICAgICAgICBwcml2LT5kZHJtY19iYXNlYWRkciArIFhERFJfSVJRX0RJU19PRkZTRVQpOw0KPiAr
ICAgICAgIHdyaXRlbChYRERSX0lSUV9BTEwsDQo+ICsgICAgICAgICAgICAgIHByaXYtPmRkcm1j
X2Jhc2VhZGRyICsgWEREUl9JUlExX0RJU19PRkZTRVQpOw0KPg0KPiAtICAgICAgIHdyaXRlbChY
RERSX0lSUV9VRV9NQVNLLA0KPiAtICAgICAgICAgICAgICBwcml2LT5kZHJtY19iYXNlYWRkciAr
IFhERFJfSVJRMV9FTl9PRkZTRVQpOw0KPiAgICAgICAgIC8qIExvY2sgdGhlIFBDU1IgcmVnaXN0
ZXJzICovDQo+ICAgICAgICAgd3JpdGVsKDEsIHByaXYtPmRkcm1jX2Jhc2VhZGRyICsgWEREUl9Q
Q1NSX09GRlNFVCk7ICB9DQo+DQo+IC1zdGF0aWMgdm9pZCBkaXNhYmxlX2FsbF9pbnRyKHN0cnVj
dCBlZGFjX3ByaXYgKnByaXYpDQo+ICsjaWZkZWYgQ09ORklHX0VEQUNfREVCVUcNCj4gKyNkZWZp
bmUgdG9fbWNpKGspIGNvbnRhaW5lcl9vZihrLCBzdHJ1Y3QgbWVtX2N0bF9pbmZvLCBkZXYpDQo+
ICsNCj4gK3N0YXRpYyB2b2lkIGVuYWJsZV9pbnRyKHN0cnVjdCBlZGFjX3ByaXYgKnByaXYpDQo+
ICB7DQo+ICAgICAgICAgLyogVW5sb2NrIHRoZSBQQ1NSIHJlZ2lzdGVycyAqLw0KPiAgICAgICAg
IHdyaXRlbChQQ1NSX1VOTE9DS19WQUwsIHByaXYtPmRkcm1jX2Jhc2VhZGRyICsNCj4gWEREUl9Q
Q1NSX09GRlNFVCk7DQo+DQo+IC0gICAgICAgd3JpdGVsKFhERFJfSVJRX0FMTCwNCj4gLSAgICAg
ICAgICAgICAgcHJpdi0+ZGRybWNfYmFzZWFkZHIgKyBYRERSX0lSUV9ESVNfT0ZGU0VUKTsNCj4g
LSAgICAgICB3cml0ZWwoWEREUl9JUlFfQUxMLA0KPiAtICAgICAgICAgICAgICBwcml2LT5kZHJt
Y19iYXNlYWRkciArIFhERFJfSVJRMV9ESVNfT0ZGU0VUKTsNCj4gKyAgICAgICAvKiBFbmFibGUg
VUUgYW5kIENFIEludGVycnVwdHMgdG8gc3VwcG9ydCB0aGUgaW50ZXJydXB0IGNhc2UgKi8NCj4g
KyAgICAgICB3cml0ZWwoWEREUl9JUlFfQ0VfTUFTSyB8IFhERFJfSVJRX1VFX01BU0ssDQo+ICsg
ICAgICAgICAgICAgIHByaXYtPmRkcm1jX2Jhc2VhZGRyICsgWEREUl9JUlFfRU5fT0ZGU0VUKTsN
Cj4NCj4gKyAgICAgICB3cml0ZWwoWEREUl9JUlFfVUVfTUFTSywNCj4gKyAgICAgICAgICAgICAg
cHJpdi0+ZGRybWNfYmFzZWFkZHIgKyBYRERSX0lSUTFfRU5fT0ZGU0VUKTsNCj4gICAgICAgICAv
KiBMb2NrIHRoZSBQQ1NSIHJlZ2lzdGVycyAqLw0KPiAgICAgICAgIHdyaXRlbCgxLCBwcml2LT5k
ZHJtY19iYXNlYWRkciArIFhERFJfUENTUl9PRkZTRVQpOyAgfQ0KPg0KPiAtI2lmZGVmIENPTkZJ
R19FREFDX0RFQlVHDQo+IC0jZGVmaW5lIHRvX21jaShrKSBjb250YWluZXJfb2Yoaywgc3RydWN0
IG1lbV9jdGxfaW5mbywgZGV2KQ0KPiAtDQo+ICAvKioNCj4gICAqIHBvaXNvbl9zZXR1cCAtIFVw
ZGF0ZSBwb2lzb24gcmVnaXN0ZXJzLg0KPiAgICogQHByaXY6ICAgICAgRERSIG1lbW9yeSBjb250
cm9sbGVyIHByaXZhdGUgaW5zdGFuY2UgZGF0YS4NCj4gQEAgLTc4Nyw3ICs3ODcsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucw0KPiB4ZGRyX2luamVjdF9lbmFibGVfZm9w
cyA9IHsNCj4gICAgICAgICAubGxzZWVrID0gZ2VuZXJpY19maWxlX2xsc2VlaywNCj4gIH07DQo+
DQo+IC1zdGF0aWMgdm9pZCBlZGFjX2NyZWF0ZV9kZWJ1Z2ZzX2F0dHJpYnV0ZXMoc3RydWN0IG1l
bV9jdGxfaW5mbyAqbWNpKQ0KPiArc3RhdGljIHZvaWQgY3JlYXRlX2RlYnVnZnNfYXR0cmlidXRl
cyhzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2kpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGVkYWNf
cHJpdiAqcHJpdiA9IG1jaS0+cHZ0X2luZm87DQo+DQo+IEBAIC0xMDEyLDEzICsxMDEyLDEyIEBA
IHN0YXRpYyBpbnQgbWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
ICAgICAgICAgICAgICAgIGdvdG8gZGVsX21jOw0KPiAgICAgICAgIH0NCj4NCj4gLSAgICAgICBk
aXNhYmxlX2FsbF9pbnRyKHByaXYpOw0KPiAgI2lmZGVmIENPTkZJR19FREFDX0RFQlVHDQo+IC0g
ICAgICAgZWRhY19jcmVhdGVfZGVidWdmc19hdHRyaWJ1dGVzKG1jaSk7DQo+IC0NCj4gKyAgICAg
ICBkaXNhYmxlX2FsbF9pbnRyKHByaXYpOw0KPiArICAgICAgIGNyZWF0ZV9kZWJ1Z2ZzX2F0dHJp
YnV0ZXMobWNpKTsNCj4gICAgICAgICBzZXR1cF9hZGRyZXNzX21hcChwcml2KTsNCj4gLSNlbmRp
Zg0KPiAgICAgICAgIGVuYWJsZV9pbnRyKHByaXYpOw0KPiArI2VuZGlmDQoNCldlIGRpc2FibGUg
YWxsIHRoZSBpbnRlcnJ1cHRzIGFuZCBlbmFibGUgb25seSB0aGUgY29ycmVjdGFibGUgYW5kIG5v
bi1jb3JyZWN0YWJsZSBlcnJvcnMuDQpUaGUgZGlzYWJsZSB0YWtlcyBjYXJlIG9mIHRoZSBpc3N1
ZSB0aGF0IGlmIG90aGVyIGludGVycnVwdHMgYXJlIGVuYWJsZWQgdGhlbiB0aGVyZSBpcyBubyBv
bmUgdG8NCmhhbmRsZSB0aGUgaW50ZXJydXB0cy4NCg0KQWxzbyB0aGUgZW5hYmxlIGludGVycnVw
dHMgYXJlIG5lZWRlZCBmb3IgdGhlIGRyaXZlciB0byB3b3JrLiBUaGUgZGVidWcgZm9yIGVycm9y
IGluamVjdGlvbiB0bw0KdGVzdCB0aGUgbm90aWZpY2F0aW9uLg0KDQo+ICAgICAgICAgcmV0dXJu
IHJjOw0KPg0KPiAgZGVsX21jOg0KPg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9y
aXMuDQo+DQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRp
cXVldHRlDQo=
