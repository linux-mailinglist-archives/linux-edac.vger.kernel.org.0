Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1944D78CA
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiCMXmQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiCMXmP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 19:42:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2053.outbound.protection.outlook.com [40.107.114.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552ACB18;
        Sun, 13 Mar 2022 16:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEkfmLCig1oujvv4JwVs8rY0v1UoMCCAsaQ3Gzp6zBCJ0lX96nnwmtP2e+2vSDwnVpP/kGur18bEU1zCilqDKhwyLel0npMDwwsxJL6ybtF1XjmT/wJYec8ttRzo81D6pRYCI2yx0zX5rKCqcNRAFqiINtPTnHeGOeF+f53JOeK3Hi9XUK3xRZ4iVi0Jnn4jPR0KOVCw8NfV6z4ZR+9QvwG/LAHs+bxmWTB4vGZDiSFU8lJaQNBmIGBr8p9eM/J7I/OVx2MPBIoxY4NfTifqEFk3YM82ZTG3WzMc+e1hkoA1uw8iuCCUQA4H2MWZiHGDmssaJFSnRaPrTydBauAsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u13R8T+h2mK1AHp8g4oO18fpTbjWmOO/fAasuecXRRs=;
 b=fzMEtBHO9xfhUzKuP+6e2ylRhalnKV1JcJ5wNQTl6PTHVXHt3D+L/MQBPtm5aCug8bqy92BKdeeYHsOgu/JHnATS4mT8GL5Lj6YSy90TwDAsQqqA4XQuVvJPzEa2LdtlSctsY5O2PwbgONoIkShuklrZKfGsqQXy8RKRjLoFFfu7udh1bzkj8P95ygUYxXoFxNhNAQnnFqM4FP0yI80BBp0Rqtiwfsk2v1BNfO/uG0ynOKYXMuRjPsUzSR0SSYsOCyTMxkiLxUDwEbUvsW7uaNHuAiA2BAAhZdI4EzpKWhotNllCxns4GBkSGwn0tD/r4W9yGl1ScckIk256j762Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u13R8T+h2mK1AHp8g4oO18fpTbjWmOO/fAasuecXRRs=;
 b=dMYdkML3mhJnLpihpP1ToSxxCCwNJERqOLDn2ycQxrdiCz0emZGxLHUFydpHrhErUxRXMurEQtWlAnQcyS8bDhGl3cRzCoqJfTuamfVGptIe5c+uuRoj38SEdCIJ3AUcc7pBcPWwUtcu0rLYvobcWpdYwqiGx4soo4qcLrYrrI8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2569.jpnprd01.prod.outlook.com (2603:1096:404:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 23:41:04 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Sun, 13 Mar 2022
 23:41:04 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Topic: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Index: AQHYNeVlxzESbmOcrEmeH57axmkwkqy9+8sA
Date:   Sun, 13 Mar 2022 23:41:03 +0000
Message-ID: <20220313234100.GA3010057@hori.linux.bs1.fc.nec.co.jp>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-2-linmiaohe@huawei.com>
In-Reply-To: <20220312074613.4798-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a86e1a59-c53c-4d98-22ca-08da054af02c
x-ms-traffictypediagnostic: TY2PR01MB2569:EE_
x-microsoft-antispam-prvs: <TY2PR01MB25697923D44F9E6EB04415BEE70E9@TY2PR01MB2569.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUMH+Awy3gYZVlQIAqXwRbKXMuiXI9KKhhURwZSmmbCAUvADEOzEdwCDmyzwZc3g9K0Yat4qydrf4cX+MlAdWEHYPYz2raE3nsDCHKo7gAFutAwEnJeMSCgLlezPDn+99LQhd31a7+z088iuN7UwSdMVYvUorZrBxDBBm7wyuKQXyxS/wpYHlXqUmkhH70WZ7t1/pqOvSS9NKskDJkSoKBhjT8gPg98zR/LCN9VmYyLXQg3bI1Rddv6/tbxEIjtRCktVKtiWRHtcOvhMifkhdgFtx+tCA++jhXESwDjmLZ2V+mqBs0glgEmlvzKLgvsUWe+IMJwANtzm4t9phbUqGaSzSpaSqLXXTk/KfPg/b2BxD707qDyLKINLcxglwH41Tloiwyu2B4wVuif/qWD5j6G2DN93VpSMucHuVK5Lp25zMjLzJttDbUOt/HHy4/QwiTVi9Clpspfhjuh1Ir6I+3QCsSfQooyMNQ1Xthib5/dU4MOSY9SIASOfgg9yd4fw8yGrrbDAin3pRy3XpV+mUBMaNQWTRf1utwc4Y3Lzr8YgdruXLM8tg3janKBUXRHzarDdREOvST7rQe0/s2BE1RF5wjase04M6VtcE5b5hzSyKegk5KedEZzhKRM3Iv8o+8DAWOoW0cUYGrAcsqcYSMSsfhtKgh1kWS8eKfyfVBnaF5pH6muLnIzK3jEVr4e80g/b/si6wtvh+7PIRihcTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6506007)(55236004)(9686003)(6512007)(2906002)(38070700005)(6916009)(85182001)(316002)(38100700002)(122000001)(82960400001)(66446008)(66476007)(66556008)(33656002)(64756008)(508600001)(86362001)(5660300002)(8676002)(66946007)(4326008)(71200400001)(6486002)(76116006)(83380400001)(8936002)(186003)(1076003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?US9uV0hwZTl1S2hRMElicHI2NkIxRWJielRrQTE5NEpYMkxQRVIxTnVMUjk1?=
 =?utf-8?B?WFc0TllzOE5RWGxJK0tXZ05teTlwMG5JYnBqYlRucVQ0Vmt4VHRGSnFtdlJu?=
 =?utf-8?B?YjhTVXFDVlR4ZEpPTkdJQnE1YTdjS3pTUWNxeDRDWkRpWkJvNjZkZ3E0U0Jv?=
 =?utf-8?B?ZW1VUXY0eGN4ZVVmU25SVUxKU0NSMVNWaGdxMFFkY3YwN1U5YVkzeWJKN2cv?=
 =?utf-8?B?ZTVsTEw2MWs0ZVB3NEMwTVVKVldXQTkyMEhONFpMcmhBSVd6anVySk00djJu?=
 =?utf-8?B?S3Y3Y0hnMXFBbVZIOS9sM2pEdGdXZ3RnQVBHa0NHcEFKcDRFaTNDYmgzZmVD?=
 =?utf-8?B?dFZ6WEZmZGlhYkwvWVN0SnV5Tjc2NHVYWUdmaVVwSU9ERnlhcnh6MUpNa1pV?=
 =?utf-8?B?Z0dnaTBuc01qYmFyZ3NQMjh1Y3ZrNVkvVy9SRHlweEU0bnRVVHNoOVNWamdX?=
 =?utf-8?B?eDdLZUVCL0tQcnk5NHZRakhnOENrQ2ZSTnZQOEphR0RoL3I1TmFjVUowcXJE?=
 =?utf-8?B?VmgydVp2Ni9taGhSdlF4R0RscjZXRTdOQVFDT084RG1pWHdTZXJpRWxzK29l?=
 =?utf-8?B?OVQwMTROSnUxWXU4eUM4NmwvZUZoMVZ3YktYQU1TS2hVUDNNUnBoUVd5ejBW?=
 =?utf-8?B?V1l4WklNeUZMSFZkMWQrY1djQmNXYzVoc0FoQUJtdVBjVnpHejFnbXAzYlFX?=
 =?utf-8?B?bDZEeDEwRWtYT0NyM3M0NjNxUEFQZXlQMlNNVVVOTWhUNkgvOU13UHorVkJB?=
 =?utf-8?B?M09oSkVBYVBtL3p5UGlrWWFnQ3I3NnBNWUlHMFI5VVJ5QXFyUC9iS0RtL2Ux?=
 =?utf-8?B?Q2dGakN4TEVNK1NFeTQwSzFldmV2ZTFhUW9hdzFZdGUwdGEzLzlLQ0Z5a3Yw?=
 =?utf-8?B?dll4bUwxUm9ydXV3S1A1Mk5uQ2hFeHBObkZqNU5ySlZlL1hWRDF5b1hQbUNL?=
 =?utf-8?B?czR0UHRQVC9ZbWxnWWsyS3F3SzM3Vm92Uzh4elJ2Y2RQYmdnV3JkU0VQQTBL?=
 =?utf-8?B?NFhHUHNlZ2RNcXdSeHFKeVFDSzBsNnlvd1lHdmx6QnAzOUp2VEx3OHNJQjlB?=
 =?utf-8?B?WmZpUnFIMFlNLzA1TEs1Ri9KNDVzYVFMM2t1WUF3VWY1aFB3bFhDdHNjZ2ZY?=
 =?utf-8?B?UTVQOElFa0gwcTQ1VkYxbytaQnBjc29NTm9pbURsNU12L3hVM2FBcEk2cnFZ?=
 =?utf-8?B?SlpDaWFTOHBQSVgvZHJPbGp3dGlnLzZsUUM2ZHBJU0dQMXk3dmRvOE5NeDVD?=
 =?utf-8?B?dGMvcXhueWM4R0E3anVrYSs2eUpZaVlTYndhMFg5VlRNYzd6Y2NOK3VsTjFl?=
 =?utf-8?B?bVZEeTlmZTJQL29wYTR6N0Q3MzUxWE9aUCs0bjloNzJBWlRYbEg3c2c4ZnJo?=
 =?utf-8?B?S0ZtVDc4aE1qRzA3Rnk0YUdCQlp0RkQwbEhiZkNibXAwdnN1SCswZXRKMnZl?=
 =?utf-8?B?R1B4Zk14djRVR1hCYWp4V0RhSlo3eFVvQkNQZVFNQ2RwWlFZYTBja3JxOTlK?=
 =?utf-8?B?d3VLMzUxVm8zVWVhM1BEcENrdGJUUFZHMFhRMURwQzRIelFtc3pSV01zc0xP?=
 =?utf-8?B?YkVtbEc4cGhZK1o4SkJtOHM5Zm5RTkIrbm1uWDBTUVYyUUhEVGtpTnVQWnZr?=
 =?utf-8?B?cjlZcmIvbWdFWUY4bVZ5cmcwMWwrc0dwbnJta05iTUpUb3dKdnN4bE45MkVt?=
 =?utf-8?B?N1lJeXo2UWMrVkY2NmQzVEIxYkZYbDhRaVF4dHhoeFQ5ZmJDQ2FEMkc0M3NN?=
 =?utf-8?B?TlAzNWZ6aFFiR3lpclNER2plZytTVUVVRDhLOFlMMHRoR2h6c3BxUkRIcEp6?=
 =?utf-8?B?WVRFR0RQcmVmVS9qczZnM2V0VjBualB1NmxlcDB5US9SVm5zWEU4dndZdkp1?=
 =?utf-8?B?ZFdjOXFNUWw0U0pTSmg1V2ZZU1BGSjhrTVorOFRveURiTk0rOSthVjQzMS8x?=
 =?utf-8?B?VC91V3RlWC9PSHQzemVycVZpUXR1VkxmR0JPSmpYRlIzMVpEbmd1UlkzR2Qw?=
 =?utf-8?B?UlpNbzg4V0N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D33D6C38276944E92A330EAAACD9680@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86e1a59-c53c-4d98-22ca-08da054af02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 23:41:03.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTYhuXZGWOWjSdlgz+VnBJSfi9eufCr720aPmXcy80LeJhMXyMRzP31BqpAQaYlNOzYoAg66v7+Tyec4BrlXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gU2F0LCBNYXIgMTIsIDIwMjIgYXQgMDM6NDY6MTFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlcmUgaXMgYSByYWNlIHdpbmRvdyB3aGVyZSB3ZSBnb3QgdGhlIGNvbXBvdW5kX2hl
YWQsIHRoZSBodWdldGxiIHBhZ2UNCj4gY291bGQgYmUgZnJlZWQgdG8gYnVkZHksIG9yIGV2ZW4g
Y2hhbmdlZCB0byBhbm90aGVyIGNvbXBvdW5kIHBhZ2UganVzdA0KPiBiZWZvcmUgd2UgdHJ5IHRv
IGdldCBod3BvaXNvbiBwYWdlLiBUaGluayBhYm91dCB0aGUgYmVsb3cgcmFjZSB3aW5kb3c6DQo+
ICAgQ1BVIDEJCQkJCSAgQ1BVIDINCj4gICBtZW1vcnlfZmFpbHVyZV9odWdldGxiDQo+ICAgc3Ry
dWN0IHBhZ2UgKmhlYWQgPSBjb21wb3VuZF9oZWFkKHApOw0KPiAJCQkJCSAgaHVnZXRsYiBwYWdl
IG1pZ2h0IGJlIGZyZWVkIHRvDQo+IAkJCQkJICBidWRkeSwgb3IgZXZlbiBjaGFuZ2VkIHRvIGFu
b3RoZXINCj4gCQkJCQkgIGNvbXBvdW5kIHBhZ2UuDQo+IA0KPiAgIGdldF9od3BvaXNvbl9wYWdl
IC0tIHBhZ2UgaXMgbm90IHdoYXQgd2Ugd2FudCBub3cuLi4NCj4gDQo+IElmIHRoaXMgcmFjZSBo
YXBwZW5zLCBqdXN0IGJhaWwgb3V0LiBBbHNvIE1GX01TR19ESUZGRVJFTlRfUEFHRV9TSVpFIGlz
DQo+IGludHJvZHVjZWQgdG8gcmVjb3JkIHRoaXMgZXZlbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xp
bnV4L21tLmggICAgICB8ICAxICsNCj4gIGluY2x1ZGUvcmFzL3Jhc19ldmVudC5oIHwgIDEgKw0K
PiAgbW0vbWVtb3J5LWZhaWx1cmUuYyAgICAgfCAxMiArKysrKysrKysrKysNCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiBpbmRleCBjOWJhZGE0MDk2YWMuLmVmOThj
ZmYyYjI1MyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvbW0uaA0KPiBAQCAtMzI1Myw2ICszMjUzLDcgQEAgZW51bSBtZl9hY3Rpb25fcGFn
ZV90eXBlIHsNCj4gIAlNRl9NU0dfQlVERFksDQo+ICAJTUZfTVNHX0RBWCwNCj4gIAlNRl9NU0df
VU5TUExJVF9USFAsDQo+ICsJTUZfTVNHX0RJRkZFUkVOVF9QQUdFX1NJWkUsDQo+ICAJTUZfTVNH
X1VOS05PV04sDQo+ICB9Ow0KPiAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Jhcy9yYXNfZXZl
bnQuaCBiL2luY2x1ZGUvcmFzL3Jhc19ldmVudC5oDQo+IGluZGV4IGQwMzM3YTQxMTQxYy4uMWU2
OTRmZDIzOWI5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3Jhcy9yYXNfZXZlbnQuaA0KPiArKysg
Yi9pbmNsdWRlL3Jhcy9yYXNfZXZlbnQuaA0KPiBAQCAtMzc0LDYgKzM3NCw3IEBAIFRSQUNFX0VW
RU5UKGFlcl9ldmVudCwNCj4gIAlFTSAoIE1GX01TR19CVUREWSwgImZyZWUgYnVkZHkgcGFnZSIg
KQkJCQlcDQo+ICAJRU0gKCBNRl9NU0dfREFYLCAiZGF4IHBhZ2UiICkJCQkJCVwNCj4gIAlFTSAo
IE1GX01TR19VTlNQTElUX1RIUCwgInVuc3BsaXQgdGhwIiApCQkJXA0KPiArCUVNICggTUZfTVNH
X0RJRkZFUkVOVF9QQUdFX1NJWkUsICJkaWZmZXJlbnQgcGFnZSBzaXplIiApCVwNCj4gIAlFTWUg
KCBNRl9NU0dfVU5LTk9XTiwgInVua25vd24gcGFnZSIgKQ0KPiAgDQo+ICAvKg0KPiBkaWZmIC0t
Z2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXgg
NTQ0NGE4ZWY0ODY3Li5kYWJlY2Q4N2FkM2YgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWls
dXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtNzMzLDYgKzczMyw3IEBA
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgYWN0aW9uX3BhZ2VfdHlwZXNbXSA9IHsNCj4gIAlb
TUZfTVNHX0JVRERZXQkJCT0gImZyZWUgYnVkZHkgcGFnZSIsDQo+ICAJW01GX01TR19EQVhdCQkJ
PSAiZGF4IHBhZ2UiLA0KPiAgCVtNRl9NU0dfVU5TUExJVF9USFBdCQk9ICJ1bnNwbGl0IHRocCIs
DQo+ICsJW01GX01TR19ESUZGRVJFTlRfUEFHRV9TSVpFXQk9ICJkaWZmZXJlbnQgcGFnZSBzaXpl
IiwNCj4gIAlbTUZfTVNHX1VOS05PV05dCQk9ICJ1bmtub3duIHBhZ2UiLA0KPiAgfTsNCj4gIA0K
PiBAQCAtMTUzNCw2ICsxNTM1LDE3IEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfaHVnZXRs
Yih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiAgCX0NCj4gIA0KPiAgCWxvY2tfcGFn
ZShoZWFkKTsNCj4gKw0KPiArCS8qKg0KDQpUaGlzIGNvbW1lbnQgc2VjdGlvbiBzdGFydGluZyB3
aXRoICcvKionIGlzIGNvbnNpZGVyZWQgYXMga2VybmVsLWRvYyBjb21tZW50LA0KbWF5YmUgdGhh
dCdzIG5vdCBleHBlY3RlZCBiZWNhdXNlIGl0IGp1c3QgZGVzY3JpYmVzIGFuIGltcGxlbWVudGF0
aW9uIGRldGFpbC4NClNvIG5vcm1hbCBjb21tZW50IHNlY3Rpb24gd2l0aCAnLyonIHdvdWxkIGJl
IGJldHRlci4NCg0KT3RoZXJ3aXNlLCBsb29rcyBnb29kIHRvIG1lLg0KDQpBY2tlZC1ieTogTmFv
eWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCg0KPiArCSAqIFRoZSBwYWdl
IGNvdWxkIGhhdmUgY2hhbmdlZCBjb21wb3VuZCBwYWdlcyBkdWUgdG8gcmFjZSB3aW5kb3cuDQo+
ICsJICogSWYgdGhpcyBoYXBwZW5zIGp1c3QgYmFpbCBvdXQuDQo+ICsJICovDQo+ICsJaWYgKCFQ
YWdlSHVnZShwKSB8fCBjb21wb3VuZF9oZWFkKHApICE9IGhlYWQpIHsNCj4gKwkJYWN0aW9uX3Jl
c3VsdChwZm4sIE1GX01TR19ESUZGRVJFTlRfUEFHRV9TSVpFLCBNRl9JR05PUkVEKTsNCj4gKwkJ
cmVzID0gLUVCVVNZOw0KPiArCQlnb3RvIG91dDsNCj4gKwl9DQo+ICsNCj4gIAlwYWdlX2ZsYWdz
ID0gaGVhZC0+ZmxhZ3M7DQo+ICANCj4gIAlpZiAoaHdwb2lzb25fZmlsdGVyKHApKSB7DQo+IC0t
IA0KPiAyLjIzLjA=
