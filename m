Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415F661E94
	for <lists+linux-edac@lfdr.de>; Mon,  9 Jan 2023 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjAIGJK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Jan 2023 01:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjAIGJI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Jan 2023 01:09:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFC101E3;
        Sun,  8 Jan 2023 22:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpQ5E11ot7nBGrEFsO7/NfxM9a1nRST+ONUv7sGQmST5ySBZoIENqDPafFPKsc8O30zMPFA1UAlB4eaiknzrK4zpnrVhBRFIqAHsCLpAzRQ3c1QjNXW0ShZsm7DATBwWnsi+YILPKgDsT3slONexz+hvAmJrBcJaHhTmoUWNAgoCvBVWsq3tqj8GdHp2IrVBFhvjf2U/CR+blYj2qvJCm0P/rn75FPW1A4SHTufwa+FZS2qKFbsWE2NXbq/pP7Hd992X5rpQ64e0hauLa9qv1PYvq2a2ZhpdBEV+AMlMwZBtnnepr614wqKt4xOz68FF6PmKf1Hjzt4pmuk24XwcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo1gwsi0OXQV2IXPkxFXwfjfnqcwlXqkSON67GJNBk4=;
 b=g3sTafw4MC7E6CZ00eijh63kk7jYFPb2BX9nO4DByi7IbJYJ3LI5rhxchhAbeX4Huvfa+a48g/0wEEKQQPGRmmmpkNPjLoE4WSL8qZEOBIqVrV8ihbJKb6lIwhRzrG1OiSI94JI9WjFN95AhtHK1G62Xzo5ZojFWYNmKqQ5CxCxVuODLhBzjSDaDbT+kY7Qn6mliSOHWWgfLGr504f8ejYddJ9gMdOrTUlNrqcnfxN0O7FVsJjHOd9kb3UxOAm2imzeLs1+Kww3BWGWXoz1HHUg2/U9G8Al8tmM9gsRrZ2ExmJ9ewbrp9aCfVGqA/JCOi6iDr5OqETVx3bvSMzm+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo1gwsi0OXQV2IXPkxFXwfjfnqcwlXqkSON67GJNBk4=;
 b=Y4LNaVzpxpj9WYn/CCopBgllGjV7JYBk2tPwTA4oOKN9CC8iwtmiXHkVS0XiPxC2/VtsMw6Ya/gjfGiPAOD5zIMbDraQj4DK5BionEz21lNG5W2ky3iMRGAXIGcT6Tf5smTGbYAMJ78SRTFRq9aMpSSVRzZjEsFgLjDD3kHv168=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 06:09:02 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::57a1:a9f3:9a61:e2c1]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::57a1:a9f3:9a61:e2c1%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 06:09:02 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v7 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Thread-Topic: [PATCH v7 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Thread-Index: AQHZIBka5zNC+nV2206D+abwYbRsS66UxJWAgADKYFA=
Date:   Mon, 9 Jan 2023 06:09:02 +0000
Message-ID: <BY5PR12MB42589C326796149216AA84D6DBFE9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
 <20230104084512.1855243-3-sai.krishna.potthuri@amd.com>
 <Y7r2I5Ij3x8/rMjS@zn.tnic>
In-Reply-To: <Y7r2I5Ij3x8/rMjS@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|CH3PR12MB8233:EE_
x-ms-office365-filtering-correlation-id: 3630a89e-567e-4023-0598-08daf2080189
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xtpsb1SGhtaWpc2FjQejvd97JfQTvCEmBHDqrUvvrURf9k390FmE4zI1CFW4hGv0clgy8o6fW4QZnnrfh6+lJVXQ8aK1QCb1qIdkKMaWoi81wnoQP6Yz6vUfrrdroKZstpyo0mdSRfi3NAi82p8hCea5963c2Fd5umGqsZ4r/7YjOxSMoZPzYYcIaoR49+gRzk9hN7DifoHL9dqHdAvqV0wu11f4PEc+gMvyUfPxyIqji7JKsen//Egfv0S/L0FVgLi28gnNcsPmmmRSt3HEhYdnjziBdX18GpVHwz572Ryv+5M+Rq/qQedbFwC76GJzMx6inrsmxvKVlW11Ch9r4IF3KTaR2j9VETpxRczKIVqeJp9yvsM+hvAmNwxUm1AMWy+p1Nddqz9zGUYU8QxhogqI6UNZPLh6dem+KDxX2drSJDLX5mhwlfiVjIhsONiQ/ZBSJ0GN1/eIzd1pbTdZjez6mJmbdm3U1ASj83KME/F8PlUj3Zqug2uhmdgOOXYB0waWis4cQZ1AhUrbCT0CWJUS12h0FxYgTpW2hGSTHnMOlOpr+1tzzWz2b5qYELZE3BLY3Rt2n1sEVhtWc0oSID0l7XEP5vs2iO+imDkYrT82hSeKt+r37vXyh7074fkGfs4cZ2rdYSucy+933u0jQvhASpLr85gNqts0qq1p/hM3Ka+yskfTHEIeCz20E4pe0TKH2E0fWEjHYmrRT/3jXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(52536014)(41300700001)(8936002)(5660300002)(7416002)(2906002)(8676002)(66476007)(76116006)(6916009)(64756008)(66446008)(66556008)(66946007)(316002)(7696005)(71200400001)(54906003)(33656002)(53546011)(6506007)(478600001)(26005)(9686003)(4326008)(186003)(55016003)(86362001)(83380400001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWtQZWtQMkVjN3ZoL2tYcXNrUkJ2Z3hnc1cyZTVRZzgycTkyaFo5ZjFTOStG?=
 =?utf-8?B?WlM5VC9jOFZiYXFPUUx2eWdielFhZEVmdUVYTHg4dkJRWVdrSjRMYll2aS9C?=
 =?utf-8?B?MzlzbUptLzQrL3JiMHNqakYweU5HNmordmV4RjRuSG1McFlSTkJlQW1WYWIw?=
 =?utf-8?B?MjhnQnpldDl4a2FIZlMvODRCYkFOUFNLUUVUWHNiT201MC82OXZjWmJ0T1FN?=
 =?utf-8?B?R3RrQmZFa3JqNG1WMDRsWlE2eG9VZTBRTzdnNTd5ZitpT0dELzBWQmFwY1Za?=
 =?utf-8?B?V2FLVTdRTnlkdWNmOWhyZ1NJeHBsMGV3TGFCcHNxUUVkM2F6d3NwRlN3L0xt?=
 =?utf-8?B?bkhZV3dwWlpkZ0ZlU1BsbEkyTUtjOVk3QnBEbk9CTStlQ3B0REtWME9WMk90?=
 =?utf-8?B?c053ZjZvdWJ5RmRuMGtEcHNVL1NNWDRMTVdoeWduUWpMa1ZZWDQ5R1ZvZUwy?=
 =?utf-8?B?ei8yZnNkdVg0Mmx1YzR4dUZ1bXAvVUdJQkJBNExCdkpRRkE3NkhIdlNQdXdG?=
 =?utf-8?B?SUQ0TTRRMDhGU2l1Sk9sV0xrQ3c5eEgwQjZEOWZHOENraFRKY3J1d1R0WFEr?=
 =?utf-8?B?NnRxMWFxbjFhK3BLR1dLbnJ0SG5hQkU2Vmc2UlZaS0MwYU4weGJNOXltV3JY?=
 =?utf-8?B?cWNFV1ROWTNOSGYwOHUzZ0ZlQis0V0FqL0l1ek1GWEMvYWM4U1d1aWk2QnF5?=
 =?utf-8?B?SGlwVjNOYkJmSXQ3OHJDNGc3azE3QitsTU9wODlPK2VHWUs5bHd6VlIwdTRk?=
 =?utf-8?B?ZEpjc3hxcG9aNGVhdHh3dEhWL3loTmkrb3pKaldPaE9ZeXRGR0lRUFZ6U1dj?=
 =?utf-8?B?R1IzYmtHQU8wbEE2cS9OWEFvU2dJUXpTZHd5cm1JWE50RVNUSzhXaVhUemp5?=
 =?utf-8?B?ZEprRG5CNlNXUjFSZzVGVWROb0ZTa0xTeUlzaWhSbURmclFvM3ZvM0kxVUEr?=
 =?utf-8?B?Uk9SQmtQUWxlajMrK1J4THcvcEtyS3ZQY3JER202eHlLNWpPTnkwa2V6Tmw4?=
 =?utf-8?B?SHR4cVBCeThUR3FqMGU1Wnp5LzIvRUMzWUdEK1pCVW0zWEp0V1dGbUhscmJo?=
 =?utf-8?B?L1htZGxPd05URUNIWDBuVVRMaVV0T3dnMFUxVnNVS1A0NGJrYVBUVUhhV0Rk?=
 =?utf-8?B?UStQQVdmbjVsMllnMm1MK2lFWDJ3K011eGdqVFpPZFdmUXNNWkNQYVNDUFpV?=
 =?utf-8?B?bUc0ZWd2dStKU1BIYUlTWHpkK3A4TzFPeGNxZmRXUC8xNis0aTVTbHNRcUNU?=
 =?utf-8?B?dXpkQy9Va29aSFVkbjUzek1ZREZBTnArckhxdjh6ZVZGb2ZOdFJseHZaZC9h?=
 =?utf-8?B?a3ROTlVweHU1Njh5YThrSHA4MFpyRGlENm55Rk0wVWsxK2hOZERvZGhPd2Rx?=
 =?utf-8?B?TWlQNzRLREZtMFFpMllkTnJUajkzejdLS21DUFdpcFc4TDJPTGFGSHRLeTBj?=
 =?utf-8?B?NkNacUl6VXJzT29ObGgwNGVMR1hsbXBEb2JJdGRhV2NuUkt2ZDAyTHpZalJs?=
 =?utf-8?B?b1ozcjdIUytmeUdlT0dYS21OVis3NkFoM0x4bHFwU1VEWTNsa3Yxb3YzdmxU?=
 =?utf-8?B?dzVvbVoyaVBoQWtaTjgveCtFMEJOL04zWUtSK1RRWG1CaVAyM2J2NXlRam4z?=
 =?utf-8?B?cUZXVjF0dWxQN0dVY3pBeHkrMWc3amE3L1JLcUYwYWVRSkxqOFZRK1NrdnJS?=
 =?utf-8?B?ZTlZWmVKQkhnM0ZVcGJZMjMyMWtQQzIvdUtKZGNWUlpMbDFlK2ZUSjI1bWRD?=
 =?utf-8?B?K0txK2pnaTlRMWcyZy95YTYwcndUZ29HMHp2cE9EQ212cEp6ZXQ5cFJmbnpi?=
 =?utf-8?B?em4zZjQ1V0k1Zk9wN3l0bURzZjRvOG1qZG41SlB3dXMxWXlvQWJHMWlNQkRX?=
 =?utf-8?B?U0hmUGY3Y0l5NGFWSDljZjRIdWJ1R2pBVDFTZlZUVzVkd3lFQllLMmg4Tzd0?=
 =?utf-8?B?VkFxZ3IwUGJ0ZDBvcEYxbHV2L1ZYcmZJK3M1Q2pwb0RaUHkranNqeURQSnJq?=
 =?utf-8?B?aytkLzdmTlovTVNVTnR5TWU1NUJUaWdCSUJQcFJ5RFNCMGRMemhlNEZ1akhl?=
 =?utf-8?B?ZktGMXo5ZzNLL3k2WUExQVRqdnN1MTFnUkNUNEIydTFWbkJuOEd0ejBDTDBZ?=
 =?utf-8?Q?hUqI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3630a89e-567e-4023-0598-08daf2080189
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 06:09:02.5295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnYAnJeSrRvbVqX+EV47DL9OHE+yBhdHiktkAsAJQegueefQKavPijJkIwLrS+Zn6QIkXJWwwh6bGMvKzFDeSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNs
YXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSA4LCAyMDIz
IDEwOjI4IFBNDQo+IFRvOiBQb3R0aHVyaSwgU2FpIEtyaXNobmEgPHNhaS5rcmlzaG5hLnBvdHRo
dXJpQGFtZC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6
eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsg
TWljaGFsIFNpbWVrDQo+IDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IE1hdXJvIENhcnZhbGhv
IENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50
ZWwuY29tPjsgSmFtZXMgTW9yc2UNCj4gPGphbWVzLm1vcnNlQGFybS5jb20+OyBSb2JlcnQgUmlj
aHRlciA8cnJpY0BrZXJuZWwub3JnPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOw0KPiBzYWlrcmlzaG5hMTI0
NjhAZ21haWwuY29tOyBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IERhdHRhLA0KPiBT
aHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPjsga2VybmVsIHRlc3Qgcm9i
b3QNCj4gPGxrcEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBFREFD
L3p5bnFtcDogQWRkIEVEQUMgc3VwcG9ydCBmb3IgWGlsaW54DQo+IFp5bnFNUCBPQ00NCj4gDQo+
IE9uIFdlZCwgSmFuIDA0LCAyMDIzIGF0IDAyOjE1OjEyUE0gKzA1MzAsIFNhaSBLcmlzaG5hIFBv
dHRodXJpIHdyb3RlOg0KPiA+IEFkZCBFREFDIHN1cHBvcnQgZm9yIFhpbGlueCBaeW5xTVAgT0NN
IENvbnRyb2xsZXIsIHNvIHRoaXMgZHJpdmVyDQo+ID4gcmVwb3J0cyBDRSBhbmQgVUUgZXJyb3Jz
IHVwb24gaW50ZXJydXB0IGdlbmVyYXRpb24sIGFuZCBhbHNvIGNyZWF0ZXMNCj4gPiBVRS9DRSBk
ZWJ1Z2ZzIGVudHJpZXMgZm9yIGVycm9yIGluamVjdGlvbi4NCj4gPiBPbiBYaWxpbnggWnlucU1Q
IHBsYXRmb3JtLCBib3RoIE9DTSBDb250cm9sbGVyIGRyaXZlcih6eW5xbXBfZWRhYykgYW5kDQo+
ID4gRERSIE1lbW9yeSBDb250cm9sbGVyIGRyaXZlcihzeW5vcHN5c19lZGFjKSBjby1leGlzdCB3
aGljaCBtZWFucyBib3RoDQo+ID4gY2FuIGJlIGxvYWRlZCBhdCBhIHRpbWUuIFRoaXMgc2NlbmFy
aW8gaXMgdGVzdGVkIG9uIFhpbGlueCBaeW5xTVANCj4gPiBwbGF0Zm9ybS4NCj4gPg0KPiA+IEZp
eCBmb2xsb3dpbmcgaXNzdWUgcmVwb3J0ZWQgYnkgdGhlIHJvYm90Lg0KPiA+ICJNQUlOVEFJTkVS
UyByZWZlcmVuY2VzIGEgZmlsZSB0aGF0IGRvZXNuJ3QgZXhpc3Q6DQo+ID4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VkYWMveGxueCx6eW5xbXAtb2NtYy55YW1sIg0KPiA+DQo+
ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFqeW90aS5kYXR0
YUBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNodWJocmFqeW90aSBEYXR0YSA8c2h1Ymhy
YWp5b3RpLmRhdHRhQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgUG90
dGh1cmkgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+DQo+ID4gUmVwb3J0ZWQtYnk6IGtl
cm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBNQUlOVEFJTkVS
UyAgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4gIGRyaXZlcnMvZWRhYy9LY29uZmlnICAgICAg
IHwgICA5ICsNCj4gPiAgZHJpdmVycy9lZGFjL01ha2VmaWxlICAgICAgfCAgIDEgKw0KPiA+ICBk
cml2ZXJzL2VkYWMvenlucW1wX2VkYWMuYyB8IDQ2NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0ODIgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9lZGFjL3p5bnFtcF9lZGFjLmMNCj4g
DQo+IFNvbWUgdG91Y2h1cHMgb250b3AsIHNlZSBiZWxvdy4NCj4gDQo+IEkgaGFkIHRvIHJldmVy
dCBiYWNrIHRvIHRoZSAjaWZkZWZmZXJ5IGJlY2F1c2UgSVNfRU5BQkxFRCBkb2Vzbid0IHByZXZl
bnQNCj4gdGhlIGNvbXBpbGVyIGZyb20gbG9va2luZyBpbnNpZGUgdGhlIGNvbmRpdGlvbmFsLi4u
DQo+IA0KPiBBbnl3YXksIGludGVyLWRpZmYgYmVsb3cuIEhvbGxlciBpZiBzb21ldGhpbmcncyBz
dGlsbCBhbWlzcy4NCj4gDQo+IFRoeC4NCj4gDQo+IC0tLQ0KPiANCj4gIGRpZmYgLS1naXQgYS9k
cml2ZXJzL2VkYWMvS2NvbmZpZyBiL2RyaXZlcnMvZWRhYy9LY29uZmlnIC1pbmRleA0KPiA1OGFi
NjM2NDJlNzIuLjc5NDRlNDBjNjdkYSAxMDA2NDQNCj4gK2luZGV4IDRjZmRlZmJkNzQ0ZC4uNjhm
NTc2NzAwOTExIDEwMDY0NA0KPiAgLS0tIGEvZHJpdmVycy9lZGFjL0tjb25maWcNCj4gICsrKyBi
L2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+IC1AQCAtNTM5LDQgKzUzOSwxMyBAQCBjb25maWcgRURB
Q19ETUM1MjANCj4gK0BAIC01NDIsNCArNTQyLDEyIEBAIGNvbmZpZyBFREFDX0RNQzUyMA0KPiAg
IAkgIFN1cHBvcnQgZm9yIGVycm9yIGRldGVjdGlvbiBhbmQgY29ycmVjdGlvbiBvbiB0aGUNCj4g
ICAJICBTb0NzIHdpdGggQVJNIERNQy01MjAgRFJBTSBjb250cm9sbGVyLg0KPiANCj4gLStjb25m
aWcgRURBQ19aWU5RTVBfT0NNDQo+ICsrY29uZmlnIEVEQUNfWllOUU1QDQo+ICArCXRyaXN0YXRl
ICJYaWxpbnggWnlucU1QIE9DTSBDb250cm9sbGVyIg0KPiAgKwlkZXBlbmRzIG9uIEFSQ0hfWllO
UU1QIHx8IENPTVBJTEVfVEVTVA0KPiAgKwloZWxwDQo+ICArCSAgVGhpcyBkcml2ZXIgc3VwcG9y
dHMgZXJyb3IgZGV0ZWN0aW9uIGFuZCBjb3JyZWN0aW9uIGZvciB0aGUNCj4gLSsJICBYaWxpbngg
WnlucU1QIE9DTSAoT24gQ2hpcCBNZW1vcnkpIGNvbnRyb2xsZXIuDQo+IC0rCSAgVGhpcyBkcml2
ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlDQo+IC0r
CSAgd2lsbCBiZSBjYWxsZWQgenlucW1wX29jbV9lZGFjLg0KPiArKwkgIFhpbGlueCBaeW5xTVAg
T0NNIChPbiBDaGlwIE1lbW9yeSkgY29udHJvbGxlci4gSXQgY2FuIGFsc28gYmUNCj4gKysJICBi
dWlsdCBhcyBhIG1vZHVsZS4gSW4gdGhhdCBjYXNlIGl0IHdpbGwgYmUgY2FsbGVkIHp5bnFtcF9l
ZGFjLg0KPiAgKw0KPiAgIGVuZGlmICMgRURBQw0KPiAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRh
Yy9NYWtlZmlsZSBiL2RyaXZlcnMvZWRhYy9NYWtlZmlsZSAtaW5kZXgNCj4gMmQxNjQxYTI3YTI4
Li40N2NiZGEwNmQ3YjAgMTAwNjQ0DQo+ICtpbmRleCAyZDE2NDFhMjdhMjguLjliMDI1YzViMzA2
MSAxMDA2NDQNCj4gIC0tLSBhL2RyaXZlcnMvZWRhYy9NYWtlZmlsZQ0KPiAgKysrIGIvZHJpdmVy
cy9lZGFjL01ha2VmaWxlDQo+ICBAQCAtODQsMyArODQsNCBAQCBvYmotJChDT05GSUdfRURBQ19R
Q09NKQkJCSs9DQo+IHFjb21fZWRhYy5vDQo+ICAgb2JqLSQoQ09ORklHX0VEQUNfQVNQRUVEKQkJ
Kz0gYXNwZWVkX2VkYWMubw0KPiAgIG9iai0kKENPTkZJR19FREFDX0JMVUVGSUVMRCkJCSs9IGJs
dWVmaWVsZF9lZGFjLm8NCj4gICBvYmotJChDT05GSUdfRURBQ19ETUM1MjApCQkrPSBkbWM1MjBf
ZWRhYy5vDQo+IC0rb2JqLSQoQ09ORklHX0VEQUNfWllOUU1QX09DTSkJCSs9IHp5bnFtcF9lZGFj
Lm8NCj4gKytvYmotJChDT05GSUdfRURBQ19aWU5RTVApCQkrPSB6eW5xbXBfZWRhYy5vDQo+ICBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL3p5bnFtcF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvenlu
cW1wX2VkYWMuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NCAtaW5kZXggMDAwMDAwMDAwMDAwLi42
OTA2OTAyODQ1N2INCj4gK2luZGV4IDAwMDAwMDAwMDAwMC4uYjExZjExNTdkNGJiDQo+ICAtLS0g
L2Rldi9udWxsDQo+ICArKysgYi9kcml2ZXJzL2VkYWMvenlucW1wX2VkYWMuYw0KPiAtQEAgLTAs
MCArMSw0NjUgQEANCj4gK0BAIC0wLDAgKzEsNDY5IEBADQo+ICArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gICsvKg0KPiAgKyAqIFhpbGlueCBaeW5xTVAgT0NNIEVDQyBE
cml2ZXINCj4gQEAgLTIyMCwxMiArMjI0LDE0IEBAIGluZGV4IDAwMDAwMDAwMDAwMC4uNjkwNjkw
Mjg0NTdiDQo+ICArCQlwLT5jZWluZm8uZmF1bHRfaGkgPSByZWFkbChiYXNlICsgQ0VfRkZEMV9P
RlNUKTsNCj4gICsJCXAtPmNlaW5mby5hZGRyID0gKE9DTV9CQVNFVkFMIHwgcmVhZGwoYmFzZSAr
DQo+IENFX0ZGQV9PRlNUKSk7DQo+ICArCQl3cml0ZWwoRUNDX0NUUkxfQ0xSX0NFX0VSUiwgYmFz
ZSArIE9DTV9JU1JfT0ZTVCk7DQo+IC0rCX0gZWxzZSB7DQo+ICsrCX0gZWxzZSBpZiAobWFzayAm
IE9DTV9VRUlOVFJfTUFTSykgew0KPiAgKwkJcC0+dWVfY250Kys7DQo+ICArCQlwLT51ZWluZm8u
ZmF1bHRfbG8gPSByZWFkbChiYXNlICsgVUVfRkZEMF9PRlNUKTsNCj4gICsJCXAtPnVlaW5mby5m
YXVsdF9oaSA9IHJlYWRsKGJhc2UgKyBVRV9GRkQxX09GU1QpOw0KPiAgKwkJcC0+dWVpbmZvLmFk
ZHIgPSAoT0NNX0JBU0VWQUwgfCByZWFkbChiYXNlICsNCj4gVUVfRkZBX09GU1QpKTsNCj4gICsJ
CXdyaXRlbChFQ0NfQ1RSTF9DTFJfVUVfRVJSLCBiYXNlICsgT0NNX0lTUl9PRlNUKTsNCj4gKysJ
fSBlbHNlIHsNCj4gKysJCVdBUk5fT05fT05DRSgxKTsNCj4gICsJfQ0KQXMgd2UgYXJlIHJhaXNp
bmcgYSB3YXJuaW5nIG1lc3NhZ2UgaW4gaW50cl9oYW5kbGVyKCkgaWYgdGhlIGZsYWdnZWQgaW50
ZXJydXB0DQppcyBub3QgVUUgb3IgQ0UgYW5kIHdlIHJldHVybiBmcm9tIHRoZXJlLCBzbyBkbyB3
ZSByZWFsbHkgbmVlZCBlbHNlIGlme30gYW5kDQpXQVJOX09OX09OQ0UoKSBpbiBlbHNle30gaGVy
ZT8NCg0KUmVnYXJkcw0KU2FpIEtyaXNobmENCg0K
