Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2412D0CB8
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLGJME (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Dec 2020 04:12:04 -0500
Received: from alln-iport-3.cisco.com ([173.37.142.90]:62370 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgLGJMD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Dec 2020 04:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3158; q=dns/txt; s=iport;
  t=1607332323; x=1608541923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FM8D9WWXq8XKkFePPjToPMCTPNcM39cG01rJ2CfSU28=;
  b=mYJFFgnvffdbZ85xEFT6BDxTr0l79B8Dy8o8/hxWczVHWBEj/9928RZ6
   c9dU4qkfq05U0jWs/8PwnVRVotnTohcwi1O92QaUS/WEHtyQofTjT35Q6
   6dzP8JNTVBqDptrYIowU2bhseo7eLqouH5oTwk9ibQKcBJPedQ0Ra7vuQ
   Y=;
X-IPAS-Result: =?us-ascii?q?A0CSBQCF8M1f/5xdJa1iHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BUlEHgVAvLoQ8g0gDjV+ZCIJTA1QLAQEBDQEBLQIEAQGESgIXgX4CJTgTA?=
 =?us-ascii?q?gMBAQEDAgMBAQEBBQEBAQIBBgRxhWEMhXMBAQECARIRBA0MAQE3AQQLAgEIG?=
 =?us-ascii?q?gImAgICMBUQAgQBDQUigwSCVgMOIAGhHQKBPIhpdn8zgwQBAQWFPRiCEAmBD?=
 =?us-ascii?q?iqCc4N2gkSEFBuBQT+BESccgicuPoEEgzoXgwAzgiyCSHcUgjYFknI/pQIKg?=
 =?us-ascii?q?nSbPAMfoiyTcpxfhD8CBAIEBQIOAQEFgW0jgVdwFWUBgj5QFwINjiEYg1mKH?=
 =?us-ascii?q?QE6dDcCBgoBAQMJfIwFAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AcTp4lRLULPY4lQIvF9mcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeGv6k/hUTRUIjX9/9Pi6zdtKWzEWAD4JPUtncEfdQMUh?=
 =?us-ascii?q?IekswZkkQmB9LNEkz0KvPmLklYVMRPXVNo5Te3ZE5SHsutbkbKr3C+8TMZGl?=
 =?us-ascii?q?P0Mg8mbujwE5TZ2sKw0e368pbPYgJO0Ty6Z746LBi/oQjL8McMho43IacqwR?=
 =?us-ascii?q?yPqXxNKOk=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.78,399,1599523200"; 
   d="scan'208";a="605213258"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Dec 2020 09:11:22 +0000
Received: from XCH-ALN-001.cisco.com (xch-aln-001.cisco.com [173.36.7.11])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 0B79BM9Q007622
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 7 Dec 2020 09:11:22 GMT
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by XCH-ALN-001.cisco.com
 (173.36.7.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Dec
 2020 03:11:22 -0600
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by xhs-rtp-002.cisco.com
 (64.101.210.229) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Dec
 2020 04:11:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-003.cisco.com (64.101.210.230) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 7 Dec 2020 04:11:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8poGC1mOO+3J0iW63dTj4YT7UHDdL5Z/6nq2kcQBuT5uQN/AoOXmnyuPbZ3sCfRCKrGmjrcerDmxUMGgkBfgk2+nmEz3P3xTLBkP6w5XHaLBxv6ZdiVdeU/9SbQkv8IJlrnW084K0AQAYdNcGxI0jqpJ5vZlG4vnrNJg0H4+BVPImKyTMIjnOevhd7K5pISomSKcp8cFpYXLrcUdA0YjBA6FGiOQowKx8/vFpaAuamBefQa07gCecidILyoe6qdX9udeVxFwLbJk48L7O5Juuoc3Z8N4hZhy6BmAiDWpmyrq6zCPSJACNDH47qeTPl0fGpDlFU5hiCAAFaxJxN38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM8D9WWXq8XKkFePPjToPMCTPNcM39cG01rJ2CfSU28=;
 b=QlVMTPxQnG6eUiLhDZyL/SjCa2Ba0ox92jUfDWiY6wIo+zlLmODelzKttrqbgQ+ZOUjdk7IWkMWiu/7FGeEv0GleMabqNXbe9/k92HeoP2Da8+2QwkznvzMttJSIjNelPFQlEBPedxZ3wW3vZwOreUv7EpkibVAZegCUTQzGp/pBxckf0/4YOjNLxwzSqxRuBhrZMpRkvoFrJmAOcLaSvTGxsKI5wB4LJu8ecChzyCLXl98uJb2WEy8rBwXAqAafTf+eur/hNhcE3/41BPJTGccY7NdYLrS1Vj22NSXeoGRVqMbzhH4FYsAjRj7l+D8o9SLr2pu2DV4DiL1C3JVDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM8D9WWXq8XKkFePPjToPMCTPNcM39cG01rJ2CfSU28=;
 b=Vr7lUe604WBtHxwNz/ti63Ef3+vwtceeWhw11g8DwCi27HoXm7mJC8NWrY/HZAplBsVfHE1cfj+Y4eP5VYRIIuX0TriZw6p9tKtUaklcjAriRJ8Os5oGyWsAIhT6RNDFf2pTTBGRC1YIrQz4Jr22wp+nKFjyVNfMe+44mVujdAU=
Received: from BYAPR11MB3112.namprd11.prod.outlook.com (2603:10b6:a03:85::13)
 by BYAPR11MB3669.namprd11.prod.outlook.com (2603:10b6:a03:f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 09:10:06 +0000
Received: from BYAPR11MB3112.namprd11.prod.outlook.com
 ([fe80::1d73:ab72:dce5:430e]) by BYAPR11MB3112.namprd11.prod.outlook.com
 ([fe80::1d73:ab72:dce5:430e%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 09:10:06 +0000
From:   "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>
To:     Troy Lee <troy_lee@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Borislav Petkov" <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
CC:     "leetroy@gmail.com" <leetroy@gmail.com>,
        "ryan_chen@aspeedtech.com" <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v4 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Topic: [PATCH v4 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Index: AQHWzHedahvoTUgX+E2GFSQPqxjBJanq0nWA
Date:   Mon, 7 Dec 2020 09:10:05 +0000
Message-ID: <1B46140C-F028-42C4-8FEA-F1561CFB37BE@cisco.com>
References: <20201207090013.14145-1-troy_lee@aspeedtech.com>
 <20201207090013.14145-3-troy_lee@aspeedtech.com>
In-Reply-To: <20201207090013.14145-3-troy_lee@aspeedtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.43.20110804
authentication-results: aspeedtech.com; dkim=none (message not signed)
 header.d=none;aspeedtech.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2003:c6:2f0a:6e00:8072:30f2:2ac4:6def]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc1919cb-aec8-4433-57a9-08d89a8fe379
x-ms-traffictypediagnostic: BYAPR11MB3669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3669F72F55737553F368CA57C7CE0@BYAPR11MB3669.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epG9TNBt0eSjiNpvI7f5cpFI5MK8leUC4Qd9O56Jddbp5pesmwG9Y6XUkNP+cN+PzzXoE3H6Y+SBFz4n/yB4BOUW4pobqgVnxyxmLu6Dp7wrlwRKw04l+fxUu12doJ0ET2UuKTu8rP6WbY5cg8aPTho4fpmGAUL8MEZX3+9wV9N6sjYh4srHAqCuDDIpMMD7PKw5K0k+bcyD+5scftNMOH8x5RS8RIIKF1frL30CLAu18oxYVg67vljMAvdbuiPIAb/t7J9WJq1RH3xLrlamdgvnl09FnEmWxqm9z9tFGrbbSgSCvT3Ek/00sG0yuX2ISsxlxDwAPdt0s2cXbzjQVvJuFi4B/YsbUZ7lh5ab0JoZLoX57GHdZFOZlipCPHrqqrkTF22zfQpzj25RiaFaKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(66946007)(76116006)(2616005)(110136005)(8676002)(91956017)(66556008)(71200400001)(66446008)(8936002)(64756008)(6486002)(66476007)(86362001)(36756003)(478600001)(6506007)(54906003)(33656002)(2906002)(7416002)(316002)(83380400001)(5660300002)(6512007)(4326008)(921005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OXBjV1pFTWw0YWFwN0RzZ1phUFk3cXNWTmU1eElvS3dzeHcrV0xVUUxpcTVx?=
 =?utf-8?B?ZXVKdkRubzhSc2VSWFV6aXV2RlNGMjlBMWJUZGVSR2dDbW9JeVVRdnZranJp?=
 =?utf-8?B?akJ3LzVhTmM2cFprdnFzL0RPUmVKS01UZXBzTlBMZ1pCbEhVR3hkSkhSeXNn?=
 =?utf-8?B?N2k0ZDloQlBpUlRSL01Zajg3NVdLUDBScGRaZ0o1dmoyMGV1bmdjTmtXVTJ0?=
 =?utf-8?B?VGI4SXE4TTBXbFc0VEpTUzFVa1JGcTJVVkpuSkZ5M2JLSmQ0YVN1WnI0KzBV?=
 =?utf-8?B?R2dyangxN244b1ZUNUpLZ2I5eU9pV0t4VU1vY1VIOWY5TEZJcGVMdjZPKzVD?=
 =?utf-8?B?M0VISVdmS2R2UXJxTkpjWlIvWlZwWVRESThmdmk0UUc2bVdmUjVyRlpWaWNK?=
 =?utf-8?B?eXlNYVJ2RE1kM3YzLzhDRDAyZldieE1yZFBaT3VQZ0d2RHcvMjExMTRKeXBF?=
 =?utf-8?B?OXRpcWgxQ2p1QmlmeU5BRkQvR0FUU0hXYVBMRmxrcUJzN0daSHBYWVlZQUUv?=
 =?utf-8?B?TDc1Q1E1K21IdGFJNWtlVVFkVVMwcWZMWnpDeWJRVHhBT29MeVEva3A0WXQ5?=
 =?utf-8?B?cGtqN1k0UVcrN2RZeUR0VEJaOGZUVWlGQXpuMXJISHhFREZPbk5iWVNXSjc2?=
 =?utf-8?B?TjJQNTd0Szc2TGM4eWRqeTlUWmZubkE3YzVrTk9iYkltT3EyZkdXeHd4ZEQz?=
 =?utf-8?B?NVdDKzUxNXZJV2VQZHUzN0ZYUmRYTk9uVllpcUxFQUdsRkhQZlFUczdqSncy?=
 =?utf-8?B?K2hTdFV3OWxVUllyK2Ftb1pLN01Qa3MrdExXM3pDQ2J5K2dCK1JoSUlBVGZE?=
 =?utf-8?B?NTloU2doZFFPckwwRlEvYmp3bysyTGNUZDBGbUtiYlY5VysyYXZ3eVU1elBP?=
 =?utf-8?B?aENhT3pUUTdsZEo3VmNKVXNkanFvckxZMUl4Q1BCOWZoNmdJemlySWdaTzVK?=
 =?utf-8?B?ZEphZEFBZU50TEtWaHdGUUJuTkJqdUNPODAwRWp0R3ZZcUxpeDZBMTBCd1Ro?=
 =?utf-8?B?SWNzcXFmUXNwdEc5anVHVlI1ZFg2NjNTcUs0U0Mxa2RyRG9iM2JmQm1TRWM2?=
 =?utf-8?B?WmIyaXpTKzl2REY0SHl0UTJKOTNkKzM2ZWlQWlZMRVgvUElMd3FlamlHSG5M?=
 =?utf-8?B?VnlVU1VkdFU1QUpDckQwUzhHcjdwM1FTNndTdWYrdXdQWlJCZkszWG5HY3dU?=
 =?utf-8?B?K2E4YlpxRXVpTmFvbGt2d0MwVzVSamRtQmtjbGdBc1ZxRjhnekFOSjFnTmxD?=
 =?utf-8?B?cEFjSjhRQWt5RUsxeGFOSFovMkVYTEVvaGdWYkxqUUNuZE04a05rOFZSOG1C?=
 =?utf-8?B?czQreWllbXlJTTVHeElqR2kwSWtxN1AvVHgya2srN0ROUzRDK3pSZ1AvWGtB?=
 =?utf-8?B?ZUNkZmZBS1dwWG9hTzBlUjdlSmlWWW1iWGc5S0lON2x2S2pOK2FsWTBlYlRT?=
 =?utf-8?Q?VWUP0j0e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11BA36DEB666D7479804513EC8A00EDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1919cb-aec8-4433-57a9-08d89a8fe379
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 09:10:05.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37aUaJsLtgLKsSsEH7IEcw0Up7ePMcM/1uoBDDBtYe8K8emodAWNr1GaavO4iq1VyQ1ZCn1lg5Nc/KyPb8v8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3669
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.11, xch-aln-001.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBBZGRpbmcgQVNUMjQwMCBhbmQgQVNUMjYwMCBlZGFjIGRyaXZlciBzdXBwb3J0Lg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQoNClJldmll
d2VkLWJ5OiBTdGVmYW4gU2NoYWVja2VsZXIgPHNzY2hhZWNrQGNpc2NvLmNvbT4NCg0KDQo+IC0t
LQ0KICAgICBkcml2ZXJzL2VkYWMvS2NvbmZpZyAgICAgICB8IDYgKysrLS0tDQo+ICBkcml2ZXJz
L2VkYWMvYXNwZWVkX2VkYWMuYyB8IDcgKysrKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRh
Yy9LY29uZmlnIGIvZHJpdmVycy9lZGFjL0tjb25maWcNCj4gaW5kZXggN2E0NzY4MGQ2ZjA3Li5j
NDEwMzMxZThlZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+ICsrKyBi
L2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+IEBAIC01MTUsMTAgKzUxNSwxMCBAQCBjb25maWcgRURB
Q19RQ09NDQo+ICAJICBoZWFsdGgsIHlvdSBzaG91bGQgcHJvYmFibHkgc2F5ICdZJyBoZXJlLg0K
Pg0KPiAgY29uZmlnIEVEQUNfQVNQRUVEDQo+IC0JdHJpc3RhdGUgIkFzcGVlZCBBU1QgMjUwMCBT
b0MiDQo+IC0JZGVwZW5kcyBvbiBNQUNIX0FTUEVFRF9HNQ0KPiArCXRyaXN0YXRlICJBc3BlZWQg
QVNUIEJNQyBTb0MiDQo+ICsJZGVwZW5kcyBvbiBBUkNIX0FTUEVFRA0KPiAgCWhlbHANCj4gLQkg
IFN1cHBvcnQgZm9yIGVycm9yIGRldGVjdGlvbiBhbmQgY29ycmVjdGlvbiBvbiB0aGUgQXNwZWVk
IEFTVCAyNTAwIFNvQy4NCj4gKwkgIFN1cHBvcnQgZm9yIGVycm9yIGRldGVjdGlvbiBhbmQgY29y
cmVjdGlvbiBvbiB0aGUgQXNwZWVkIEFTVCBCTUMgU29DLg0KPg0KPiAgCSAgRmlyc3QsIEVDQyBt
dXN0IGJlIGNvbmZpZ3VyZWQgaW4gdGhlIGJvb3Rsb2FkZXIuIFRoZW4sIHRoaXMgZHJpdmVyDQo+
ICAJICB3aWxsIGV4cG9zZSBlcnJvciBjb3VudGVycyB2aWEgdGhlIEVEQUMga2VybmVsIGZyYW1l
d29yay4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9hc3BlZWRfZWRhYy5jIGIvZHJpdmVy
cy9lZGFjL2FzcGVlZF9lZGFjLmMNCj4gaW5kZXggZmRlODA5ZWZjNTIwLi5hNDZkYTU2ZDZkNTQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZWRhYy9hc3BlZWRfZWRhYy5jDQo+ICsrKyBiL2RyaXZl
cnMvZWRhYy9hc3BlZWRfZWRhYy5jDQo+IEBAIC0yMzksNyArMjM5LDcgQEAgc3RhdGljIGludCBp
bml0X2Nzcm93cyhzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2kpDQo+ICAJaW50IHJjOw0KPg0KPiAg
CS8qIHJldHJpZXZlIGluZm8gYWJvdXQgcGh5c2ljYWwgbWVtb3J5IGZyb20gZGV2aWNlIHRyZWUg
Ki8NCj4gLQlucCA9IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCIvbWVtb3J5Iik7DQo+ICsJbnAgPSBv
Zl9maW5kX25vZGVfYnlfbmFtZShOVUxMLCAibWVtb3J5Iik7DQo+ICAJaWYgKCFucCkgew0KPiAg
CQlkZXZfZXJyKG1jaS0+cGRldiwgImR0OiBtaXNzaW5nIC9tZW1vcnkgbm9kZVxuIik7DQo+ICAJ
CXJldHVybiAtRU5PREVWOw0KPiBAQCAtMzc1LDEwICszNzUsMTMgQEAgc3RhdGljIGludCBhc3Bl
ZWRfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+DQo+DQo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhc3BlZWRfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5j
b21wYXRpYmxlID0gImFzcGVlZCxhc3QyNDAwLXNkcmFtLWVkYWMiIH0sDQo+ICAJeyAuY29tcGF0
aWJsZSA9ICJhc3BlZWQsYXN0MjUwMC1zZHJhbS1lZGFjIiB9LA0KPiArCXsgLmNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI2MDAtc2RyYW0tZWRhYyIgfSwNCj4gIAl7fSwNCj4gIH07DQo+DQo+ICtN
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhc3BlZWRfb2ZfbWF0Y2gpOw0KPg0KPiAgc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXNwZWVkX2RyaXZlciA9IHsNCj4gIAkuZHJpdmVyCQk9IHsN
Cj4gQEAgLTM5Miw1ICszOTUsNSBAQCBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGFzcGVlZF9kcml2
ZXIpOw0KPg0KPiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiAgTU9EVUxFX0FVVEhPUigiU3Rl
ZmFuIFNjaGFlY2tlbGVyIDxzc2NoYWVja0BjaXNjby5jb20+Iik7DQo+IC1NT0RVTEVfREVTQ1JJ
UFRJT04oIkFzcGVlZCBBU1QyNTAwIEVEQUMgZHJpdmVyIik7DQo+ICtNT0RVTEVfREVTQ1JJUFRJ
T04oIkFzcGVlZCBCTUMgU29DIEVEQUMgZHJpdmVyIik7DQo+ICBNT0RVTEVfVkVSU0lPTigiMS4w
Iik7DQo+IC0tIA0KPiAyLjE3LjENCg0KDQo=
