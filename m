Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8615B17BA
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 10:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiIHIxA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiIHIwj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 04:52:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3FE6BBA;
        Thu,  8 Sep 2022 01:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJB8wJR+VOzBymj8hpukAjlozq1/Td1f8y90c4xArS6IqJmhBarnTaatgfWt+HcSWK0MxGER2DRcCFxPTTY4iLRaR0XdsqiWDepIthCAZR8THbU0bGdKxsUAHnQPMyTEW77zzmLhi0yZupo6/kod2NMCsWg0r0vCDe1GlKuSi4EPnIfbrFD28OofmUMaen7wMItv7GMu1KdBhs99arOGsTSD5/dDNwOLl4NIf27iBBO1Qu/VWugrEOVoxPKWlNPrenSlQIAsIkzQpq+hmyqBTu13fsv0VITHKRpMcVbfvhQrQNJTdCiK1DzlZNYP7NVEbresA17ybLp5g/pw5p3twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+56KY1kaGIOCrEzB1YLR31+oD3F2lH4GfijYTs2Emgw=;
 b=WkBpqesKwDgMFuSRRldPOKJjJpPwnb3GBE24opQ/ZMyiWnAmO3O4I5HSRo47FpyDuh0GXrY/9IYaoms0eA23gIXcgYEA7hkZAO+FlTamMU/XZPAShbPWFplGTvYHlZNVdyDkbHYjURyk2odP7jJloCQOD+fPOCuZE1XKT5IIDjphruBtPaGbLvvvxuyZdBx335eMK6CpnFp4M48tIQXQPMVE8/cQpCjaiuwut3x+DGQva1l8b+CAAR/F79FiNam5Bp4G10csM0XNV3e+rUSAxgxQI/swFmbcfpJC6vOh8yVg9XPqJtLGnw0NduL7BYf2zZBSfA2WiMJB5OPBcMJffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+56KY1kaGIOCrEzB1YLR31+oD3F2lH4GfijYTs2Emgw=;
 b=Z4u0yObwVUcSp47dSAzAcyyq2x01Sl5r+HWwUrpjqX7fko/IgbE9JYj5Q+3ogLCmJ+nH5rheI/ti9oFhU8QNJ3URCPaW12/jT53TEngXtCZcWzpLVlb+oMO/6w37f/2BmzHccpGygC11ztR0hmdtq2cMoE9vPZhMo+vFcsYDOCo=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 08:51:37 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231%4]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 08:51:37 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Boris Petkov <bp@alien8.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Subject: RE: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Thread-Topic: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Thread-Index: AQHYwqtoeX2MhABwF0S4ucamabz+ba3T/zcAgAEApQCAADb0gIAAAd7A
Date:   Thu, 8 Sep 2022 08:51:37 +0000
Message-ID: <BY5PR12MB4258FBEC062B033510FA53CDDB409@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
 <20220907111531.703-3-sai.krishna.potthuri@amd.com>
 <YxikJCguJWunfh6x@nazgul.tnic>
 <BY5PR12MB4258C4746631BBD6A7B388D6DB409@BY5PR12MB4258.namprd12.prod.outlook.com>
 <E7324951-0608-432F-8E9C-6C08DA64838D@alien8.de>
In-Reply-To: <E7324951-0608-432F-8E9C-6C08DA64838D@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4218f585-e2b3-4964-b2bc-08da917756f3
x-ms-traffictypediagnostic: DM8PR12MB5464:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAeW3+tn0Rd5oMv1a/zTV4TAAC6r5zlzkdWkdrxi63UlrKnOFPABGe5tzd8xdq9g76WwFcTMtardUJCIEBfWswX7xZ24YioDAMTuPeTvjImV23EolHlWpWzK5gETwofXOmOceS02BmEWre7rgKD7YoaKTcSP88d6EHnccg4+PpiurhBTIoP04KQ6ir+5OpRAposJd67qK9Pq/bdlGNxQL9NC+IpuaAZGyFGdkdiABJUCPp42wlvBdhNNaoFEoWJ1xVz/mmLoGnNZxQ4NbFaI2n2mBfYzcYQaK6ZxcUgBSunLHAdQk9RfE6ypiKqNW0jNscplpmPcDTjK37Py3wjcBhHWc3dPIxhcabPB7tI5/oUOJmlUahPEV1dv3GOQ7Bte+T1iyufHo5nTi1pU6+hSO7RFK6J6yedIRX5EETpXcNqtESJpVH2w4qtbSsbKkwwpFT3FrugJjdnF0wGcACQc7wkAZIpV6mzYtM3AU4fFLictCs71EoYi9zucwZ9z+9mLK2pl+cDYBKm2B6Slc0IUoRvpiJDgYhlXpzb7v1FsjVIt8sJ52/RrxoqJHKukNDU/XH3+/JYFHMoIEfbKP0/JyZKYxDuUgO1locxWUKGjiGyxacYU8mXlPCHcKzRtiw54tEZZXOIlJjlXBJ75+FcfPoU76mZy+HXAyvWtatUPkhu/tcnW0RnVrZ2hxXOl3ahKScj/5nPfxxoXNFSe8pmuFprmV0r65c8UrYiSeyN5Z+0mCXqgwEui3BKEqKDy+tqwI2Rh+gXnXSDNDcjIpi29Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(26005)(2906002)(66476007)(86362001)(33656002)(8936002)(7416002)(478600001)(4326008)(7696005)(9686003)(66556008)(53546011)(5660300002)(66946007)(4744005)(64756008)(8676002)(76116006)(55016003)(122000001)(66446008)(52536014)(41300700001)(38100700002)(83380400001)(6506007)(71200400001)(186003)(316002)(38070700005)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVNtd1ZMcGlaNEttbEpsMkFVUlYzeE9rYmluRFZ6WkpkUmE2cUh0SG5vU0pi?=
 =?utf-8?B?WVh3SjlPWW51NkF6S25uSVUwTHlNbFkrSVU4Qy8zM202RENaNlZZcHc3UWhP?=
 =?utf-8?B?YldjOXlXMjdYb1U3MUVRNGt5a0IzVDlTTk1kcmNoY3YzQzNhZkZNVC8wTGIx?=
 =?utf-8?B?SEZ4ejhoTklaVWlZaEdOQ0E3M2MvelliaTFvKzg4R0UzeG5EeC9qdE1WN2pr?=
 =?utf-8?B?UG9tRk1tRmJScmJ4SlEzY0pUUW02YVVvRGZGUWFuYXB6QVdlWEF6MVJDTWFk?=
 =?utf-8?B?Z0hYWXRlalFyeHVKZ3orVlU3aks0M3luNWNoNUVpRjhKVWRJQ0lnbGgrR0Fx?=
 =?utf-8?B?cmNLY1JhZ29pUGJ2RG5nOHluVjRXcUZOaUtyT2Q1Q2RPUkJrWklhNFBlTGNj?=
 =?utf-8?B?UWxZYTBUckZkZmc5TFVJUjYzUnhlZjI2aTN6bGFwaGhmYlJISGFXNmhCWENW?=
 =?utf-8?B?MmMvTitmMGM3ZmVuR3dMNnd4bFgra1VLbDhiWG40cjJmTHZMaGFhcHNFdWNT?=
 =?utf-8?B?bVRyN29INVlSSElESlo1Tjh5eEk5V04wVkgyU3ZGZUNkcDQ3WjkyQ3BLSFEw?=
 =?utf-8?B?SVFDOWV6bW85ZmpxZlgxbXVBKzFWSno2UlZrTEIzUGdSRXM0d2tjR1gvWVZW?=
 =?utf-8?B?eHdkRllGQVJEQXhBMGxaQXpkc0RhU2NiVjBOeVc0K05zU3JrU004c2RIdHhS?=
 =?utf-8?B?MGVheGsrcFErVnhFSDRQMVJ3OHhwRWlzNmF0NktjY0tjRVZjMEdEejgycWNo?=
 =?utf-8?B?dU5YTEd6eXkxVHZBVVMwVjdWSjd1ME0yYkRyL1pzL3JrYk1pSFE1ZW5zRGl4?=
 =?utf-8?B?Uk5RRjZWc0ptaXNYakVrTFVWcUx6Mnp2RldZSytESDVhdDBWbksxUVViYklv?=
 =?utf-8?B?Njg2Y1FTQ3drODRrc1BWU2ZnaDVzVUh5QXJIREJwd1Y2RWRiYmI5VGVhbk02?=
 =?utf-8?B?TE9ZckdENFFSUTZEZmdyUU1MWHpQL0RMN2lRb0Z5L0ZLcFlXblh2RzBvaFpN?=
 =?utf-8?B?UlpTN2k1UGJ4UU9hTzFIZVVsMlJqOVBUaXVwTmE0dzMxKzZtLzNCclJUekpM?=
 =?utf-8?B?dGg3azA0TXNGbFcvT1pwVHlqSUlIMWswRFhiUU5QVE5CMFZBSS9nM2pRbWVs?=
 =?utf-8?B?bG5sRWgyT1ZjcXlpK01pcWNaTGduMndOQlZJSUpYc2VjdnBEOHVHS29ob1RD?=
 =?utf-8?B?TmQ5bEZlQWRjdE0zOE1yVlBrckxhV1BLUjI3V2dHMGJBcS9WdmtscEoxRjIx?=
 =?utf-8?B?TnlKSDFkRkR2UkhlSWtXK09WK05UeDhmRkF1M0ZmalhzRWJTSXFxeENtOUds?=
 =?utf-8?B?OGsrL0JyZGpwSTl4Rk1sbnByTUVIS3JvNXRLM3p0REh3blZuL3FVMXp0WkNi?=
 =?utf-8?B?YUdQTDNTbkJCYitSeW5SYVBmaG0vM2JFM2xQWEJMdWZJU2NSVkx6VFpoQ1VB?=
 =?utf-8?B?ZGp1V29hNlY1VlNQUEVlMGs3ZlhjY3UrQ0dRSlRUNG5ycEtiWGxWVG8zQUh5?=
 =?utf-8?B?OG5CbmJ6cnRWR2xRQkdtZ3lzdUg5QzcweU5zRVI3YUlPQnNpMFgzQVhaQ2ZK?=
 =?utf-8?B?SVpPSjlYUndQb3VaaWxIVzhQNEh2Q3NMbWpWTFEweWdMTFBKQWZ3cVJENEtY?=
 =?utf-8?B?NnRzM3o1Yi93dCtXcWhnZW9lU01aRFg5U3E4MGNHZlY1V0FrUnY3ZHFrT2Qw?=
 =?utf-8?B?V1hnVkpBM2U3ejRxVEJDZHBwcHBBQUlQVDNOTGY5Q0Z2RzVqRHJMRmxERXpT?=
 =?utf-8?B?ZFBQWWp6NzBvQmh2V3N1d1I0SHc1eGpybmdtUERxV0EwbzBac3RMaXVnaEw1?=
 =?utf-8?B?Wjc5bTIxQW1TY3JUY2RxK1JudVJSamliKzZvYmthcWh3YlpuS0JDTXpyTFFH?=
 =?utf-8?B?blI3Smc5WVRvQnprUTI3aEZXSlVtL2V4MUJ3eFM0VjBQbGdiTU0vb2xMSlJw?=
 =?utf-8?B?V3NJMjE0SCtrT29BOUFrQk9zMTJ6eTNLZFVXV0Q4bVpRWTROalpsT1Q3bklN?=
 =?utf-8?B?amdhUHAwUkVxYjZZWmpiakFRTkdSYTM1Uy9xUENsaW55Q0lYaHBUVlpCODFJ?=
 =?utf-8?B?SytoaGR3MXBQK3ZTcE9QRHlmczhRMzF2RHZ4blNySEkxak1oYTZuNStubWRj?=
 =?utf-8?Q?/W/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4218f585-e2b3-4964-b2bc-08da917756f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 08:51:37.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUYPqUBOVopdrT1V+wknIpxTyAsS/JHVt8N8fZPO3vufY/AE+cSzyR8xx7IHvuh8a4XNe2b48ME07dHvmx1RYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgOCwgMjAy
MiAyOjA2IFBNDQo+IFRvOiBQb3R0aHVyaSwgU2FpIEtyaXNobmEgPHNhaS5rcmlzaG5hLnBvdHRo
dXJpQGFtZC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6
eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsg
TWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBNaWNoYWwgU2lt
ZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgZ2l0DQo+IChBTUQtWGlsaW54KSA8Z2l0QGFt
ZC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSmFtZXMgTW9yc2UNCj4gPGphbWVz
Lm1vcnNlQGFybS5jb20+OyBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBzYWlrcmlzaG5hMTI0NjhAZ21haWwuY29tOyBSb2JlcnQgUmljaHRlciA8cnJp
Y0BrZXJuZWwub3JnPjsgbGludXgtDQo+IGVkYWNAdmdlci5rZXJuZWwub3JnOyBEYXR0YSwgU2h1
YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCB2NCAyLzJdIGVkYWM6IHp5bnFtcF9vY206IEFkZCBFREFDIHN1cHBvcnQgZm9yDQo+IFp5
bnFNUCBPQ00NCj4gDQo+IE9uIFNlcHRlbWJlciA4LCAyMDIyIDU6Mzk6NTYgQU0gVVRDLCAiUG90
dGh1cmksIFNhaSBLcmlzaG5hIg0KPiA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT4gd3Jv
dGU6DQo+ID5TeW5vcHN5cyBFREFDIGRyaXZlciBpcyB0YXJnZXRlZCBmb3IgRERSIE1lbW9yeSBD
b250cm9sbGVyIGFuZCB0aGlzDQo+ID5kcml2ZXIgaXMgZm9yIE9DTSAoT24gQ2hpcCBNZW1vcnkp
IENvbnRyb2xsZXIsIGJvdGggYXJlIGRpZmZlcmVudA0KPiBoYXJkd2FyZSBjb250cm9sbGVycy4N
Cj4gDQo+IEl0IHdvdWxkIGJlIGhlbHBmdWwgaWYgdGhlIGRyaXZlciBoZWxwIHRleHQgZXhwbGFp
bmVkIGEgYml0IG1vcmUgd2hhdCBodyB0aGlzDQo+IGRyaXZlciBpcyBmb3IuLi4NClN1cmUsIGkg
d2lsbCBhZGQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcw0KU2FpIEtyaXNobmENCg==
