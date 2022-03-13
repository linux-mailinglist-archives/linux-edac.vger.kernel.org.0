Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF59B4D78CC
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 00:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiCMXnJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 19:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiCMXnI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 19:43:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2052.outbound.protection.outlook.com [40.107.114.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99528268;
        Sun, 13 Mar 2022 16:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeIpRK8EFILxo4hu7xOZ6mHVGAfxiJcnBODU1OLtTqHNJKiNKmjekfKvCw6cKI0Tf4FG+uzGGEibHgrfgSMoBwoOp1a0iDmOJ4PHlLDyoFvsStvj0WX2yfzSDqXKDi2OAmMVrpuLLwM7jPQ0q1TJ73KeqhJfe1G4+mgpHuSeSkG8cxpYMI4/OB7UKMby/gjQdnYidR+aREfcO+zAOWu4tCPIObUwx8mDVSvqLrcs12wt9coTPPBEngA+KIaAK5oLdMqELFdC7Om/SVYqB20jpBcQTTZtX9ZG4d+tD2IvAhHHLKiXtj0bg6YTNJ4A82yzcrD/JTrs+9Kiwp/luehxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBNZrXwbfQ00ZQcXGV2lErzgJ+oeyYWQYabAewlQgjU=;
 b=LY/01S7/LBGVnNvdz94oewLv/LKoDQN/2K23/URNYjjDFHFsplyMAGRsmjQxJOD7t3QwjJ2zY8eTSpIiUxZgUs2Ff562i/2vdEd7mtGZXUImujvTuOBROcJdKFK6OFbqFYrUaXfRWprxL//pxfqgq5NGBuNJgrNfPomgt+t61tH5St1oN79NuwBbqEcCRP7f+VPKavsn4nNV7Fhdg2N3DnimqZ+gY6YAWMWWMgK/o/laN0wCmxsYvHMvGd0DPoR6oQq5m60GRcEt+N52tqWf720uvExlHTKIpFcGPx8LtCed0hTtuNGjC3l80CIOIoyPlclT/Q8lKIBdziYg8A9uow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBNZrXwbfQ00ZQcXGV2lErzgJ+oeyYWQYabAewlQgjU=;
 b=O7bydtdlk20h4hAhsOXZFfNy1BK94Goip/KoKb8QjinS09QZchcMPffzikZeJioBJTDrb37yKM1XhY3sgkYlZBCZHrQD0XIcFLphDLl44Ph1dYbpBQ2wdgwzp8X7K3wgVs72KxzYRh0Y3w9bR17DbaM5QrtZ5dJQ0elC3lXpDVw=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2569.jpnprd01.prod.outlook.com (2603:1096:404:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 23:41:57 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Sun, 13 Mar 2022
 23:41:57 +0000
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
Subject: Re: [PATCH v2 2/3] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
Thread-Topic: [PATCH v2 2/3] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
Thread-Index: AQHYNeVndi6AuZZxXUGaRp3E70Yunay9/A+A
Date:   Sun, 13 Mar 2022 23:41:57 +0000
Message-ID: <20220313234157.GB3010057@hori.linux.bs1.fc.nec.co.jp>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-3-linmiaohe@huawei.com>
In-Reply-To: <20220312074613.4798-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c725317-1e55-4c1f-a77f-08da054b1016
x-ms-traffictypediagnostic: TY2PR01MB2569:EE_
x-microsoft-antispam-prvs: <TY2PR01MB25695194E03993AD155CD5C5E70E9@TY2PR01MB2569.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoJ/y1PSHgKMOvkmmH3e2Z7w0jKioC3Pj+/GF4GsMFpxIRCJgFq02iO+7rtovxvO9Aqc8suEx0/Svt6kAwZy8PtDyRPsbIohoxdeuZUm4O7UvOixXjUodwaxeFrFulsjN20uocBWuK5bYyxwfReTzcPW/cBwkxHgijkyVGEARFTJVco13ob865IHfydRDdIGK4WrJ+YEgBsUFacR9ANYSqPKcgij0CAdvDYUzU0346valfs7BOTnhLv9DeN3uAfPcbycrcweo5qy8KFHL10uIZIwdkftwUqx7RN5EyXQA/ZtgvMlZ5yqN71llcyyUmdL1rmhqGDwLnWhnMchmZM/osH2q1bPtUK9doRq39+krzHfeZE6ScbnXsARdhSAblAqyOM9MI7JHVkp8Ov58STGWFb5knyU+avkKKk+Z33W9ijkDk1SR+shEZH8citgnsmHAcERH4U+BkOkS1TAioRr0NrRF/nSUNvr0j6qK1dBR38Wf3KQI0+79AToshy8HMJB55OCu6v1WAvUHlWqcwbARZntDahww1aDHxHWKCJWwbBdNVdrJbcuwiKkKRF9crUUYaITHs+KDCu/HbuSau2hKtmVM5PzJOi6Jm4ahwgOmdKm9mvwKZmVnzXcOrq1KRgbgTEbcnMkPAsBwj5TEUMAfzY4gSDBvX7C4HFSOpoYoGAaI0RKOtQE8MmjQkGqDVTirvw2GhPKPAaJMO0HJbvEYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6506007)(55236004)(9686003)(6512007)(2906002)(38070700005)(6916009)(85182001)(316002)(38100700002)(122000001)(82960400001)(66446008)(66476007)(66556008)(33656002)(64756008)(508600001)(86362001)(5660300002)(8676002)(66946007)(4326008)(71200400001)(6486002)(76116006)(83380400001)(8936002)(186003)(1076003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODB1YnI0aGEzQTVDVk9LVHB5N2pZaEdqTG9UY3JIOVVxdjBta013QndMZUZx?=
 =?utf-8?B?WEFJclJBS1YyOFhFbU5rajFyOTZacmxWemtCNXlGb3VjcjBUYjdJc05vRU1H?=
 =?utf-8?B?clVXdnl6dk5teVVSZ3JxOWdyMTJEYVNSS2lCTi9NanF2aFV2ZytQc0l2Ymky?=
 =?utf-8?B?L3VaYXZEN0NVZUpUeElDbmFWdVpwb1BxbmRHbUVTZVQ3Vi9CeXBRcVp0clJs?=
 =?utf-8?B?clgvNlJiYkVHNGVXTlJDU0kwcys3QjJ0QzhWRFpMM2k5OWJlaEo1bGZtMFBs?=
 =?utf-8?B?OGtTSHkrbXZmejZEOUhOc1h1cEFWdFVoek40V09vRlJud1FaMHpvWFNDZXBN?=
 =?utf-8?B?WHl0WkVsT1VTem9Lc1lOcGxGTjhLUitQT0V3UEc5dUNaSGpTU0hheE9BMjJO?=
 =?utf-8?B?WVpqUnp5K0hlZnp6Z25ZSUxRZDY4R0dvZkFlV0FWdG9WQWVYQkhiQjhwOGta?=
 =?utf-8?B?N25YQTZQSythL1F0VWZOVy91aGtxT1BUamp0M2V3enFwcldVLzVCUkw3UWtQ?=
 =?utf-8?B?TWt3VVdsSzR5c2J0Y2xydWtRREdMaEZPTnNOZ3ZaZmVaSk1ZdFJLVk5wVjFy?=
 =?utf-8?B?MjcrbTlmakJQK0NvNHpMamZaMGpaUDZvVWF6Qy94L0QrcHZPZWxFYkZzdyti?=
 =?utf-8?B?bjZYbXcvSjRiZ0liVkxMWklZdlpKamNBM0lKQVdKVGdYeG83ZnJUbkhsQzJI?=
 =?utf-8?B?NUdHU08xL2dVNlJudnUzUEZJRGVkdW1sYWoyOUdReVh0bmN6aS83TjhteE53?=
 =?utf-8?B?NFdERFN6QVYrSTB3a0FmdEgyN2UzdkNRR2dIZU5oSXZkdG9RSU41ZHVZSGJT?=
 =?utf-8?B?VVhPTDhhUk9laDd3TFlWZTlmbkRySFE2MWlORm5OTnQwaUdEWVhpeTRSdzVR?=
 =?utf-8?B?NXpSZ1ZvOWNKcENvQmdjcUVDSzVldER4c1kxTkpCRCtzRHRuM1BZU3NhOTFi?=
 =?utf-8?B?ZGJQbXFIRlg5ODZoTmhNMjZuSXBzZkRVK2lxdWpxQllCT3dxUisvNlhkdlhH?=
 =?utf-8?B?UXBDM09TTnV6OFZhR3ZxenJndWQyYkVzS3BEUUJaVGlVUGY3allJU0lwcVNt?=
 =?utf-8?B?cHYrUUczSC9YQW1SNFNVeGkrTXQxa1cyRW1VbDVlQWxTbXdxL1ZyWVIrdHpi?=
 =?utf-8?B?ZmlmMktOeDBUc01BOE1KQU40WE9BbTBaQmJjeWV5a1BUSWo1L0NYcWVobHIy?=
 =?utf-8?B?dHdBcWVrS05PS3dIUmNZTTlwTHFBSmRVa0o0QTBnZDYvUGg4VnhkeU1Majhh?=
 =?utf-8?B?K2htd00xczRGKzJaRkNtMDNYV2VscW5UdDRTU3FHc25Xc2FZYm16aWVrWTBz?=
 =?utf-8?B?VlZQa0I0ekdOSStxaEdiM2R6ZWsvUjBTUEQ1ZmVzLzNsbjJXUkRhekJwMHE3?=
 =?utf-8?B?amYycHBjeUZrb0pQNVZtQXBJandMbUZ2STB4UlhON3BuSmF4UkxJdGlnZ1F2?=
 =?utf-8?B?SVkxa2t6YWUybndXKzlST0hETTBuNEpsUVl5YmVGb3kzZFo1YmkrcHBpRTMz?=
 =?utf-8?B?MmtNQzdSWldMWmRYVXkxQy9yYTIzaXNuNkZhOGx1VFFhTzZXT1NhNjEwZlNp?=
 =?utf-8?B?MUdhZGFiNm10VENkb09PRlRlVjVvYitVaFZSZGFFZXY1Wm5xd1pVdzdkS2E0?=
 =?utf-8?B?KzUrOXg3NVFYczhZano3TUg2OU9OaU05MUl5UXZIZTF5WWNidFB4aEdoUjNJ?=
 =?utf-8?B?c2x6TytKbDh6MUJGQjNpUWxUR3QzTmg3QmZ6d1gxczdYeEJhRVhZSzRHNm9R?=
 =?utf-8?B?UytoTytQdGl5dkEvSmlVWEZUZjE4U09JejRyNUNmNDBTUG82M2E1SUtDU0lQ?=
 =?utf-8?B?NUt0S0g5M2gvT3pkOHFTSTRYSjlVU2Q1aUpRSjJKOFBaZHRieXQ3a2Z2S0Jm?=
 =?utf-8?B?QW5WeGxRZmt1cG5WUnpyZFZRWExQV201d1lHSWlXVFoxSm12d01va3NrOGYw?=
 =?utf-8?B?OSs2dDJFNlo4b3M2L1lxb1FGZGRTMFJPYk9WeVRQRTVIMEhZTFlSU3hOVS9Y?=
 =?utf-8?B?MXJ4bjNSQ3N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA59C204493A74AB81BC6E256832701@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c725317-1e55-4c1f-a77f-08da054b1016
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 23:41:57.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3faahIHDBhU2PZZOh3ri2+rcZBWfNS6Su4yglK8ui1sVbxGgth9qiAOgVfzg4bnTH/yjj9BPvmUK8V0tGwP+7Q==
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

T24gU2F0LCBNYXIgMTIsIDIwMjIgYXQgMDM6NDY6MTJQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gU2luY2UgY29tbWl0IDA0MmM0ZjMyMzIzYiAoIm1tL3RydW5jYXRlOiBJbmxpbmUgaW52
YWxpZGF0ZV9jb21wbGV0ZV9wYWdlKCkNCg0KVGhpcyBjb21taXQgSUQgZG9lcyBub3QgZXhpc3Qg
aW4gbWFpbmxpbmUgKG9yIGluIHRoZSBsYXRlc3QgbW1vdG0/KSwNCnNvIHlvdSBjYW4ndCB1c2Ug
aXQgaW4gcGF0Y2ggZGVzY3JpcHRpb24uICBDb3VsZCB5b3UgdXBkYXRlIHRoaXMgcGFydD8NCg0K
VGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gaW50byBpdHMgb25lIGNhbGxlciIpLCBpbnZh
bGlkYXRlX2lub2RlX3BhZ2UoKSBjYW4gaW52YWxpZGF0ZSB0aGUgcGFnZXMgaW4NCj4gdGhlIHN3
YXAgY2FjaGUgYmVjYXVzZSB0aGUgY2hlY2sgb2YgcGFnZS0+bWFwcGluZyAhPSBtYXBwaW5nIGlz
IHJlbW92ZWQuDQo+IEJ1dCBpbnZhbGlkYXRlX2lub2RlX3BhZ2UoKSBpcyBub3QgZXhwZWN0ZWQg
dG8gZGVhbCB3aXRoIHRoZSBwYWdlcyBpbiBzd2FwDQo+IGNhY2hlLiBBbHNvIG5vbi1scnUgbW92
YWJsZSBwYWdlIGNhbiByZWFjaCBoZXJlIHRvby4gVGhleSdyZSBub3QgcGFnZSBjYWNoZQ0KPiBw
YWdlcy4gU2tpcCB0aGVzZSBwYWdlcyBieSBjaGVja2luZyBQYWdlU3dhcENhY2hlIGFuZCBQYWdl
TFJVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5j
b20+DQo+IC0tLQ0KPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21t
L21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IGRhYmVjZDg3
YWQzZi4uMmZmN2RkMjA3OGM0IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+
ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTIxOTAsNyArMjE5MCw3IEBAIHN0YXRp
YyBpbnQgX19zb2Z0X29mZmxpbmVfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gIAkJcmV0dXJu
IDA7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKCFQYWdlSHVnZShwYWdlKSkNCj4gKwlpZiAoIVBhZ2VI
dWdlKHBhZ2UpICYmIFBhZ2VMUlUocGFnZSkgJiYgIVBhZ2VTd2FwQ2FjaGUocGFnZSkpDQo+ICAJ
CS8qDQo+ICAJCSAqIFRyeSB0byBpbnZhbGlkYXRlIGZpcnN0LiBUaGlzIHNob3VsZCB3b3JrIGZv
cg0KPiAgCQkgKiBub24gZGlydHkgdW5tYXBwZWQgcGFnZSBjYWNoZSBwYWdlcy4NCj4gLS0gDQo+
IDIuMjMuMA==
