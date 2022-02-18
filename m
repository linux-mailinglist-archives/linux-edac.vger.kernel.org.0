Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B624BB002
	for <lists+linux-edac@lfdr.de>; Fri, 18 Feb 2022 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiBRDIe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Feb 2022 22:08:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiBRDId (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Feb 2022 22:08:33 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2068.outbound.protection.outlook.com [40.107.114.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A021A9E6E;
        Thu, 17 Feb 2022 19:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCDC1eib4d3VIcCQFpqyawvYXUL+Wg3wstH1F1MMFa0Vb3/ht70ygQQozWPCrD0WoH0vyCwF0G67w5MIm8fgUOFj3oHOsHQAKCc/fHSQzjsCm2N08HWFg6m0Gi7RV4i41HDwdT6TBOpu+WgjwztbX6mzFgZ0xMMYDDcq41y6Gzb1gFJwHb6wDVTFh+8b4WE9jU8YQRW0bS0JOC19+BeHG/bHvwOWLUdKL6+N4bPLw0AzuEyJX3R1RDTHt0rztuzd3YSyLJF4Ayg0ybXPTI9RY4wf5v+x/RapY7NnR/8MG+Goc60rVagCEtbUuE23tMytq4gPEC3sHVVX+L3TQkllyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWVLxDQN2qfo7QOHTw2/Xv8xkcHMxLTe6BZJ7EM81Q4=;
 b=XIrHjDH7XN3JY4HqpMHZM78mHxJ5R9G+al3Jola/5fAQcTunyg1LpNM/YRz4Dk8mixaHaHuUwpTPw8aRWmUPLaGnBVfKhZNM9PvoaQAEszZIxhe7FJX+ZUsJfW+AnTzFaTurrO/0Tp1aHIUg7sH1r61ST6THJmyn5Mak0ZJufWRf/tccigp6FhSKbiHfCAQvr4H4v7RH+QYRcktdUvJD4UWoLATCb8qst/4NLhyQKC9M2VQpNoCmO3EeyjojRxXpew0elO0kPm7KkThAG++EfVT6g97GSZOxpyEA1MSzpiG76s/cHx0FLt/McqOKpvFY2zWJEeMOj6ryUyaXL8umjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWVLxDQN2qfo7QOHTw2/Xv8xkcHMxLTe6BZJ7EM81Q4=;
 b=OHuP7PqUThZy2EpDUS0TSEq0/49LSGWgBOwS+gWXZ7lw41oJvMeMLXq1HRU7NtjA3EkmSWSCFemII6TPstTqvHO2Yybxzin02L2agqFZOS5gEtX1I7DQkC/f5LlmDpS5I5vKFNhm0PXqfBtxQUrCvEoHDBaah4OhJRujnbO64pA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2535.jpnprd01.prod.outlook.com (2603:1096:604:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 03:08:15 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 03:08:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     luofei <luofei@unicloud.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] hw/poison: Add in-use hugepage filter judgement and
 avoid filter page impact on mce handler
Thread-Topic: [PATCH v2] hw/poison: Add in-use hugepage filter judgement and
 avoid filter page impact on mce handler
Thread-Index: AQHYI6rs9MeKxk4DC0q9O8WjVGuCgayYojMA
Date:   Fri, 18 Feb 2022 03:08:14 +0000
Message-ID: <20220218030814.GA2955567@hori.linux.bs1.fc.nec.co.jp>
References: <20220217030038.1552124-1-luofei@unicloud.com>
In-Reply-To: <20220217030038.1552124-1-luofei@unicloud.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b73f6dd5-f722-48a1-2691-08d9f28be798
x-ms-traffictypediagnostic: OSBPR01MB2535:EE_
x-microsoft-antispam-prvs: <OSBPR01MB253597A3A3F840C693548237E7379@OSBPR01MB2535.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywEqtHomTDMy5O1litjqXgo0PNztbpp+ydgZ+Aht5ILMXDjR/B/Xe1kryEqlGWoNKhEEU8hFHC+nJxFIt3dKbqSkaiDif0X9DOX9O2Nm6aSH+ddd2GqMOJhuXNk8f8iT/4sO/ewqmDmN1YzGCy7Td4wx0/5ffLOZ4Gbm1pJkv29mLExkd+86rU0C8wGZK5aRdImaaQNRDrDKiuxhBY45WgC72w3vh49yGoyR4dnDqGLqlfZ+pU9v5oyW2JOAQO/dkcEIPRck92zc28SBpytD1K9W90Btr4Rz44W1l++/IjU93S0i+cnjhosj5Gh2SWkysX1oEc/fdos1l57xGUAZgmHWeFxdgM3HvjdJuvCBcqyu1TfOv9CzEtumtxml8zf/5U0R0Ezci6GZAMXnk/55Wxh0TVjTvm9vWCfWql8CtEKzVeBo/VGLAmfqW8FliXqLOcA2E0d2f5KhjVieUJTvTs98k2sz8jiUK8u3hFEC4xy1zyEs6cfCKzuctAWs5VzpHzgwU5kHnoOpxfrjQEVdboKU/4NfbXjl4g0CPGCHXZJUPBzlwnKogrG3mHinQcwctcpmgH35c7n64Fmdz35IgZRI1lUsoG/wZa2PAmlVgAVsI1G/ROPrdqGbUOBWcV0zRgEmbjtHfE5rj4ehW3aNzaf4zt6ncy+9JqDvzQd1/2nvup8oJ9puEyijBlroqBsxvGrRQ8Sdq2PfoMop/CDKdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(76116006)(66946007)(6486002)(66476007)(4326008)(64756008)(66446008)(8676002)(33656002)(38100700002)(54906003)(83380400001)(122000001)(82960400001)(6512007)(6506007)(38070700005)(9686003)(86362001)(5660300002)(7416002)(8936002)(71200400001)(1076003)(186003)(26005)(508600001)(2906002)(316002)(55236004)(6916009)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlEwTC9wbGhvUGFiK1ZYbzRoQS9FcEJnQWxrK0xyK2IrZWJyMmNwa2Q4alpQ?=
 =?utf-8?B?ZmpBVUJkcjJZR1BkQnBaQlNQNG0yeHJpV0JWcy94ZXdYVW40cmVsZUhwSnJF?=
 =?utf-8?B?YndFNWJRNlpEcnBGNzRSdmNra1NBYmhrRWluNXNlQngzdEkvektVWjFtMkcw?=
 =?utf-8?B?K2ZjLzJKaC9pWU5qcFlzUHdRTUFQTU9WNWpXcUZYd1NzaUhHdWhpYm9hVC9I?=
 =?utf-8?B?RjhUNVNENjRuYnpQY1FYb3A1dmt1ZVFBQVVyZ1hCNlgva0lXK2ZSRkNMT3BP?=
 =?utf-8?B?cWtiQkV6UDN6Yk5TejVGT2VDZDB6azRIR0xQUjlPQi9GUnBET24rTzVSNk9Y?=
 =?utf-8?B?a1RJZkNWKzROQTBWdlp6TE52NUJleUJ4WVpZNDRMMHczNFF6RmpEdndmS2RM?=
 =?utf-8?B?Y2ZwVkYwczdGRUtpbVdvMVA1N1FLUlY5bkw1Nit3Uk5Fek14bzJtbnBDa0g1?=
 =?utf-8?B?cTJMa0NjS0RPRk5STmtmZERxQUF5WEw5L2pJS1c1cXMyZzltZ0dJaDBqb051?=
 =?utf-8?B?QzY1dnJZbXNHQ21OaURxcGZwNFBMR0xBUFBUVVU5aEZDOTlqUzNFU29XdEZM?=
 =?utf-8?B?Z0doYis3VG42WVBNWWFibEQrRndJNWRCSEhMRE8vd2hjaFI2SFc4cW1yd2l1?=
 =?utf-8?B?eE92cFhHcllCR0FLamxaamxXSzRSSUtzeGRyaUc1Q1NQZ2xndDNLeFhlSEQ2?=
 =?utf-8?B?NVlNRi9xQnA3ZEFERFVtczNka0FiTlpnMGVzcng5eTgrWFQ2TytoRDRqSXFD?=
 =?utf-8?B?V2xBWFkrT2ZyK04zZGI2dTNoWXVMY2tkQldSMzBxMUlBbk51bzhXZkh0Z21O?=
 =?utf-8?B?eGg1RGRWeUxsTllxK0JualM4RmlNNUFkM0Y2RnNlS1NVdnNKT0M5L0dkVzRP?=
 =?utf-8?B?RVFLaW41emt2K1BraE5ZaHVPREFxbWhqb3pCVzdWMmVQeitIbGVQQnBJSXZO?=
 =?utf-8?B?ZlQ1TVhpcU1KR0ZDcFhaMFQwVXlZaFBDT2c0WEhIWWdoNUQwN29UcTdIREo3?=
 =?utf-8?B?RGFhTkFiSGV4dmtSSEdoS3FIa1NuMTBLeW1aZkRwYWdoSVptU3NOVng3c3o4?=
 =?utf-8?B?RzV1VnRsMkU2dU0xL05XSHlPZXA4OWRWdlhKeVllclBpMW5zaS9qcXU1VkQr?=
 =?utf-8?B?S2Qwc1U0bjRjZExpLzRnc2phdGZDNzl0dzZCMWtzc0FlVHJyUkNZTXZCNlZk?=
 =?utf-8?B?WjIyWmV0d29MMzBWak9MWjB1VitBRjFHNUdhcklRSUIvbkd5eEI3SU9WdVpt?=
 =?utf-8?B?ZCtwdXoxSm5WcnAyN1UvRWJvb2pQdEtHRnAyb3RRSG1lU3pHc0VDQXYvMVU4?=
 =?utf-8?B?N1hnQmNUU0NSeUZMb29XMkRMeUVzc0VNYi9sMCtpU3ZtRGlNNXVVUTh2MmxB?=
 =?utf-8?B?alI4dms3NVdRSEFFa1FtWlBGV2tOK3dlOGVTemVhSFFqMXlzSUdCSXYwN2x6?=
 =?utf-8?B?R2VxdkJackhNZkxOaFlsbHpSeGhNeXRTMmkrempxTnRXeVJEL0FLSVRjdnVR?=
 =?utf-8?B?dEtNZExDOTRpMmtwN3lIYUt6T3dscXlab1pwNWI1bEt6SkltTFFXRWxocTFv?=
 =?utf-8?B?Y3BXcitIQVBuVnVrVjJEUHRmWExVdzErUDVtSTZocCswdExOb0EvLzBycWJG?=
 =?utf-8?B?UHYzSVBLMmVGSDFhRU1qT0FNNEM4UnRBWGt5bXp4YjRjcjk3VHRrRHpzZzRF?=
 =?utf-8?B?ZXZsRTE1LzZRZUl2ZTFyQWZYSStZTHVYYjZ3THU0Uzc1a05xdENwUVpGM0JS?=
 =?utf-8?B?V3Z4dFlSL0FEcVhpbCswc1VCVWhPeGUzc0tCaW4wY3UveEdZTTNNakR4S1ht?=
 =?utf-8?B?TU0rVElaemlEa2N2ZjF6TDVqWGlLaHlMTUI5ODg0NkRzTnJqUXBmUlRxa0R0?=
 =?utf-8?B?K0RtMWhsOHczbUcyRm1ReXpmL1V2UFNCaEh5Ym16WDV1L1c4VVlNVzY0cjhU?=
 =?utf-8?B?RjZrajYyLzJLTXVaQVp5Z1JUb2ZEN0ZnMDB4S2ZhaWxEVUhleGxUMzlOWWlB?=
 =?utf-8?B?YzYvczYxVHpLZElicGdaT3JKUHNwWFFwN0pyeUp1K2o2WG1zNXpyUkVCWXNp?=
 =?utf-8?B?UkM3c3c1VlYyUUlTb05JenB3dXcxT25kaGNsSTJWbEZtVFQrSDNZTmpHVy82?=
 =?utf-8?B?UDVZb3VyczN3WXZGeEk5d3Rja1ZjNTRhdmtQNkNGK085aWZBNVBHTEN3R2d0?=
 =?utf-8?Q?n/IhsZ4KsrEGjPJNaRYd75c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B6A0D9E5C0248438D069CD0500BD1A1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f6dd5-f722-48a1-2691-08d9f28be798
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 03:08:14.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuba9JKqsOSulJL7ABVRkiL8BRimpCnP/CVLe9xc8/hZn+CJQLzpUor7ebXl5Muu/lm+fzxahiFHMkq0mH49oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gV2VkLCBGZWIgMTYsIDIwMjIgYXQgMTA6MDA6MzhQTSAtMDUwMCwgbHVvZmVpIHdyb3RlOg0K
PiBBZnRlciBzdWNjZXNzZnVsbHkgb2J0YWluaW5nIHRoZSByZWZlcmVuY2UgY291bnQgb2YgdGhl
IGh1Z2UNCj4gcGFnZSwgaXQgaXMgc3RpbGwgbmVjZXNzYXJ5IHRvIGNhbGwgaHdwb2lzb25fZmls
dGVyKCkgdG8gbWFrZSBhDQo+IGZpbHRlciBqdWRnZW1lbnQsIG90aGVyd2lzZSB0aGUgZmlsdGVy
IGh1Z2VwYWdlIHdpbGwgYmUgdW5tYXBlZA0KPiBhbmQgdGhlIHJlbGF0ZWQgcHJvY2VzcyBtYXkg
YmUga2lsbGVkLg0KPiANCj4gQWxzbyB3aGVuIHRoZSBodWdlIHBhZ2UgbWVldHMgdGhlIGZpbHRl
ciBjb25kaXRpb25zLCBpdCBzaG91bGQNCj4gbm90IGJlIHJlZ2FyZGVkIGFzIHN1Y2Nlc3NmdWwg
bWVtb3J5X2ZhaWx1cmUoKSBwcm9jZXNzaW5nIGZvcg0KPiBtY2UgaGFuZGxlciwgYnV0IHNob3Vs
ZCByZXR1cm4gYSB2YWx1ZSB0byBpbmZvcm0gdGhlIGNhbGxlciwNCj4gb3RoZXJ3aXNlIHRoZSBj
YWxsZXIgcmVnYXJkcyB0aGUgZXJyb3IgcGFnZSBoYXMgYmVlbiBpZGVudGlmaWVkDQo+IGFuZCBp
c29sYXRlZCwgd2hpY2ggbWF5IGxlYWQgdG8gY2FsbGluZyBzZXRfbWNlX25vc3BlYygpIHRvIGNo
YW5nZQ0KPiBwYWdlIGF0dHJpYnV0ZSwgZXRjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogbHVvZmVp
IDxsdW9mZWlAdW5pY2xvdWQuY29tPg0KDQpUaGlzIHBhdGNoIHNlZW1zIHRvIGRvIHR3byBzZXBh
cmF0ZSB0aGluZ3MgKGludHJvZHVjaW5nIE1GX01DRV9IQU5ETEUsDQphbmQgYWRkaW5nIGh3cG9p
c29uX2ZpbHRlcigpIGluIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSksIHNvIGNvdWxkIHlvdQ0K
c2VwYXJhdGUgdGhlIHBhdGNoIGludG8gdHdvPw0KDQo+IC0tLQ0KPiAgYXJjaC94ODYva2VybmVs
L2NwdS9tY2UvY29yZS5jIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9s
aW51eC9tbS5oICAgICAgICAgICAgIHwgIDEgKw0KPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyAgICAg
ICAgICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAzNSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9j
b3JlLmMNCj4gaW5kZXggNTgxOGI4MzdmZDRkLi5jMmI5OWM2MDIyNWYgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9jb3JlLmMNCj4gQEAgLTYxMiw3ICs2MTIsNyBAQCBzdGF0aWMgaW50IHVjX2RlY29k
ZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLCB1bnNpZ25lZCBsb25nIHZhbCwN
Cj4gIAkJcmV0dXJuIE5PVElGWV9ET05FOw0KPiAgDQo+ICAJcGZuID0gbWNlLT5hZGRyID4+IFBB
R0VfU0hJRlQ7DQo+IC0JaWYgKCFtZW1vcnlfZmFpbHVyZShwZm4sIDApKSB7DQo+ICsJaWYgKCFt
ZW1vcnlfZmFpbHVyZShwZm4sIE1GX01DRV9IQU5ETEUpKSB7DQo+ICAJCXNldF9tY2Vfbm9zcGVj
KHBmbiwgd2hvbGVfcGFnZShtY2UpKTsNCj4gIAkJbWNlLT5rZmxhZ3MgfD0gTUNFX0hBTkRMRURf
VUM7DQo+ICAJfQ0KPiBAQCAtMTI4Niw3ICsxMjg2LDcgQEAgc3RhdGljIHZvaWQga2lsbF9tZV9u
b3coc3RydWN0IGNhbGxiYWNrX2hlYWQgKmNoKQ0KPiAgc3RhdGljIHZvaWQga2lsbF9tZV9tYXli
ZShzdHJ1Y3QgY2FsbGJhY2tfaGVhZCAqY2IpDQo+ICB7DQo+ICAJc3RydWN0IHRhc2tfc3RydWN0
ICpwID0gY29udGFpbmVyX29mKGNiLCBzdHJ1Y3QgdGFza19zdHJ1Y3QsIG1jZV9raWxsX21lKTsN
Cj4gLQlpbnQgZmxhZ3MgPSBNRl9BQ1RJT05fUkVRVUlSRUQ7DQo+ICsJaW50IGZsYWdzID0gTUZf
QUNUSU9OX1JFUVVJUkVEIHwgTUZfTUNFX0hBTkRMRTsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJ
cC0+bWNlX2NvdW50ID0gMDsNCj4gQEAgLTEzMDAsMTQgKzEzMDAsMTQgQEAgc3RhdGljIHZvaWQg
a2lsbF9tZV9tYXliZShzdHJ1Y3QgY2FsbGJhY2tfaGVhZCAqY2IpDQo+ICAJCXNldF9tY2Vfbm9z
cGVjKHAtPm1jZV9hZGRyID4+IFBBR0VfU0hJRlQsIHAtPm1jZV93aG9sZV9wYWdlKTsNCj4gIAkJ
c3luY19jb3JlKCk7DQo+ICAJCXJldHVybjsNCj4gLQl9DQo+IC0NCj4gLQkvKg0KPiAtCSAqIC1F
SFdQT0lTT04gZnJvbSBtZW1vcnlfZmFpbHVyZSgpIG1lYW5zIHRoYXQgaXQgYWxyZWFkeSBzZW50
IFNJR0JVUw0KPiAtCSAqIHRvIHRoZSBjdXJyZW50IHByb2Nlc3Mgd2l0aCB0aGUgcHJvcGVyIGVy
cm9yIGluZm8sIHNvIG5vIG5lZWQgdG8NCj4gLQkgKiBzZW5kIFNJR0JVUyBoZXJlIGFnYWluLg0K
PiAtCSAqLw0KPiAtCWlmIChyZXQgPT0gLUVIV1BPSVNPTikNCj4gKwl9IGVsc2UgaWYgKHJldCA9
PSAtRUhXUE9JU09OIHx8IHJldCA9PSAxKQ0KPiArCQkvKg0KPiArCQkgKiAtRUhXUE9JU09OIGZy
b20gbWVtb3J5X2ZhaWx1cmUoKSBtZWFucyB0aGF0IGl0IGFscmVhZHkgc2VudCBTSUdCVVMNCj4g
KwkJICogdG8gdGhlIGN1cnJlbnQgcHJvY2VzcyB3aXRoIHRoZSBwcm9wZXIgZXJyb3IgaW5mbywg
c28gbm8gbmVlZCB0bw0KPiArCQkgKiBzZW5kIFNJR0JVUyBoZXJlIGFnYWluLg0KPiArCQkgKg0K
PiArCQkgKiAxIG1lYW5zIGl0J3MgYSBmaWx0ZXIgcGFnZSwgbm8gbmVlZCB0byBkZWFsIHdpdGgu
DQo+ICsJCSAqLw0KDQpUaGUgbmV3IHJldHVybiBjb2RlIDEgc2VlbXMgdG8gYmUgaGFuZGxlZCBp
biB0aGUgc2FtZSBtYW5uZXIgYXMgLUVIV1BPSVNPTiwNCnNvIGhvdyBhYm91dCBzaW1wbHkgdXNp
bmcgLUVIV1BPSVNPTiBhcyByZXR1cm4gY29kZSBmb3IgdGhlIG5ldyBjYXNlPw0KVGhlbiwgdGhl
IG1lYW5pbmcgb2YgLUVIV1BPSVNPTiBhdCB0aGlzIGNvbnRleHQgd291bGQgY2hhbmdlIGxpa2Ug
YmVsb3c6DQoNCiAJLyoNCi0JICogLUVIV1BPSVNPTiBmcm9tIG1lbW9yeV9mYWlsdXJlKCkgbWVh
bnMgdGhhdCBpdCBhbHJlYWR5IHNlbnQgU0lHQlVTDQotCSAqIHRvIHRoZSBjdXJyZW50IHByb2Nl
c3Mgd2l0aCB0aGUgcHJvcGVyIGVycm9yIGluZm8sIHNvIG5vIG5lZWQgdG8NCi0JICogc2VuZCBT
SUdCVVMgaGVyZSBhZ2Fpbi4NCisgICAgICAgICogLUVIV1BPSVNPTiBmcm9tIG1lbW9yeV9mYWls
dXJlKCkgbWVhbnMgdGhhdCBtZW1vcnlfZmFpbHVyZSgpIGRpZA0KKwkgKiBub3QgaGFuZGxlIHRo
ZSBlcnJvciBldmVudCBmb3IgdGhlIGZvbGxvd2luZyByZWFzb246DQorCSAqICAgLSBTSUdCVVMg
aGFzIGFscmVhZHkgYmVlbiBzZW50IHRvIHRoZSBjdXJyZW50IHByb2Nlc3Mgd2l0aCB0aGUNCisJ
ICogICAgIHByb3BlciBlcnJvciBpbmZvLCBvcg0KKwkgKiAgIC0gaHdwb2lzb25fZmlsdGVyKCkg
ZmlsdGVyZWQgdGhlIGV2ZW50LA0KKwkgKiBzbyBubyBuZWVkIHRvIGRlYWwgd2l0aCBpdCBtb3Jl
Lg0KIAkgKi8NCg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiAgCQlyZXR1cm47DQo+
ICANCj4gIAlwcl9lcnIoIk1lbW9yeSBlcnJvciBub3QgcmVjb3ZlcmVkIik7DQo+IEBAIC0xMzIw
LDcgKzEzMjAsNyBAQCBzdGF0aWMgdm9pZCBraWxsX21lX25ldmVyKHN0cnVjdCBjYWxsYmFja19o
ZWFkICpjYikNCj4gIA0KPiAgCXAtPm1jZV9jb3VudCA9IDA7DQo+ICAJcHJfZXJyKCJLZXJuZWwg
YWNjZXNzZWQgcG9pc29uIGluIHVzZXIgc3BhY2UgYXQgJWxseFxuIiwgcC0+bWNlX2FkZHIpOw0K
PiAtCWlmICghbWVtb3J5X2ZhaWx1cmUocC0+bWNlX2FkZHIgPj4gUEFHRV9TSElGVCwgMCkpDQo+
ICsJaWYgKCFtZW1vcnlfZmFpbHVyZShwLT5tY2VfYWRkciA+PiBQQUdFX1NISUZULCBNRl9NQ0Vf
SEFORExFKSkNCj4gIAkJc2V0X21jZV9ub3NwZWMocC0+bWNlX2FkZHIgPj4gUEFHRV9TSElGVCwg
cC0+bWNlX3dob2xlX3BhZ2UpOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gaW5kZXggMjEzY2M1NjliMTkyLi5mNDcw
M2Y5NDhlOWEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L21tLmgNCj4gQEAgLTMxODgsNiArMzE4OCw3IEBAIGVudW0gbWZfZmxhZ3Mgew0K
PiAgCU1GX01VU1RfS0lMTCA9IDEgPDwgMiwNCj4gIAlNRl9TT0ZUX09GRkxJTkUgPSAxIDw8IDMs
DQo+ICAJTUZfVU5QT0lTT04gPSAxIDw8IDQsDQo+ICsJTUZfTUNFX0hBTkRMRSA9IDEgPDwgNSwN
Cj4gIH07DQo+ICBleHRlcm4gaW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBp
bnQgZmxhZ3MpOw0KPiAgZXh0ZXJuIHZvaWQgbWVtb3J5X2ZhaWx1cmVfcXVldWUodW5zaWduZWQg
bG9uZyBwZm4sIGludCBmbGFncyk7DQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5j
IGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBpbmRleCA5N2E5ZWQ4Zjg3YTkuLjFhMGJkOTFhNjg1
YiAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1vcnkt
ZmFpbHVyZS5jDQo+IEBAIC0xNTI2LDcgKzE1MjYsMTAgQEAgc3RhdGljIGludCBtZW1vcnlfZmFp
bHVyZV9odWdldGxiKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ICAJCQkJaWYgKFRl
c3RDbGVhclBhZ2VIV1BvaXNvbihoZWFkKSkNCj4gIAkJCQkJbnVtX3BvaXNvbmVkX3BhZ2VzX2Rl
YygpOw0KPiAgCQkJCXVubG9ja19wYWdlKGhlYWQpOw0KPiAtCQkJCXJldHVybiAwOw0KPiArCQkJ
CWlmIChmbGFncyAmIE1GX01DRV9IQU5ETEUpDQo+ICsJCQkJCXJldHVybiAxOw0KPiArCQkJCWVs
c2UNCj4gKwkJCQkJcmV0dXJuIDA7DQo+ICAJCQl9DQo+ICAJCQl1bmxvY2tfcGFnZShoZWFkKTsN
Cj4gIAkJCXJlcyA9IE1GX0ZBSUxFRDsNCj4gQEAgLTE1NDUsNiArMTU0OCwxNyBAQCBzdGF0aWMg
aW50IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykN
Cj4gIAlsb2NrX3BhZ2UoaGVhZCk7DQo+ICAJcGFnZV9mbGFncyA9IGhlYWQtPmZsYWdzOw0KPiAg
DQo+ICsJaWYgKGh3cG9pc29uX2ZpbHRlcihwKSkgew0KPiArCQlpZiAoVGVzdENsZWFyUGFnZUhX
UG9pc29uKGhlYWQpKQ0KPiArCQkJbnVtX3BvaXNvbmVkX3BhZ2VzX2RlYygpOw0KPiArCQlwdXRf
cGFnZShwKTsNCj4gKwkJaWYgKGZsYWdzICYgTUZfTUNFX0hBTkRMRSkNCj4gKwkJCXJlcyA9IDE7
DQo+ICsJCWVsc2UNCj4gKwkJCXJlcyA9IDA7DQo+ICsJCWdvdG8gb3V0Ow0KPiArCX0NCj4gKw0K
PiAgCS8qDQo+ICAJICogVE9ETzogaHdwb2lzb24gZm9yIHB1ZC1zaXplZCBodWdldGxiIGRvZXNu
J3Qgd29yayByaWdodCBub3csIHNvDQo+ICAJICogc2ltcGx5IGRpc2FibGUgaXQuIEluIG9yZGVy
IHRvIG1ha2UgaXQgd29yayBwcm9wZXJseSwgd2UgbmVlZA0KPiBAQCAtMTYxMyw3ICsxNjI3LDEw
IEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfZGV2X3BhZ2VtYXAodW5zaWduZWQgbG9uZyBw
Zm4sIGludCBmbGFncywNCj4gIAkJZ290byBvdXQ7DQo+ICANCj4gIAlpZiAoaHdwb2lzb25fZmls
dGVyKHBhZ2UpKSB7DQo+IC0JCXJjID0gMDsNCj4gKwkJaWYgKGZsYWdzICYgTUZfTUNFX0hBTkRM
RSkNCj4gKwkJCXJjID0gMTsNCj4gKwkJZWxzZQ0KPiArCQkJcmMgPSAwOw0KPiAgCQlnb3RvIHVu
bG9jazsNCj4gIAl9DQo+ICANCj4gQEAgLTE4MzcsNiArMTg1NCwxMCBAQCBpbnQgbWVtb3J5X2Zh
aWx1cmUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gIAkJCW51bV9wb2lzb25lZF9w
YWdlc19kZWMoKTsNCj4gIAkJdW5sb2NrX3BhZ2UocCk7DQo+ICAJCXB1dF9wYWdlKHApOw0KPiAr
CQlpZiAoZmxhZ3MgJiBNRl9NQ0VfSEFORExFKQ0KPiArCQkJcmVzID0gMTsNCj4gKwkJZWxzZQ0K
PiArCQkJcmVzID0gMDsNCj4gIAkJZ290byB1bmxvY2tfbXV0ZXg7DQo+ICAJfQ0KPiAgDQo+IC0t
IA0KPiAyLjI3LjA=
