Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C14D7979
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 03:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiCNCvr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 22:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNCvq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 22:51:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2058.outbound.protection.outlook.com [40.107.113.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBD939173;
        Sun, 13 Mar 2022 19:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtexlcecEuYR2VZXSTc6oVphMDvkSis7qXiKVIuwrgxsFS66ak/H4n84lAo2kjvKld3VMTl9gSqfqAvjSd277aYy35xeJgLI9kjiddM2XfBDWRGDuTvqzsEZTjMV2ilqrJ8V+Ic4snSF6hccMWepDJ/MfooOe6Sj2MZtvE14BIxJ6cKHYaxOBDA218stwFcowk+duavzS/ZLDe2lnQlSYv3sgmIPcMPUUHyPFJnNPWe+Cx3gEaTej9pl2RLB4cJLmiRDZwHslu1cwEISPciriEWkFBwgWfJSvp+6oCcPlHtdyqsWwPBQW1rzBkQWv9NfKxrrp03HDL+3qQFTv974qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXAq3LoWlDMfpXx8tsQaTyjYZBXeNk359xrSREUGI5s=;
 b=DvfgbLvnH25hc5PvLqh8C02rlS7YSvaAbJyNENEbs3mfnTJaGPQf70dIYKGcjAroiayDhxoWLbflcADlXfmij/V8/YlGDOgy/saJ97mX+X025enfnqyjvggVQ8mUnFW1yC6CgNLARaigFbQdFwV/n/Qmr8za5L8eh3lhlxGlWhhzZjxfMZGqn2Rwm4FBvXF307WoK4vFJMH2Uvg0iujeRde/AgjQyfBzKjKopPOHif151W8uHmY60xrGAcywRhmfmopgOLS9p/56l//Em7DL/ZE44NdqdykYRjQ45k+1FVEfJHXyH2xVnts07lzje6J/02tFhY4coyLL2kZVcZqeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXAq3LoWlDMfpXx8tsQaTyjYZBXeNk359xrSREUGI5s=;
 b=LXUv7k09w0NyLdRF7UlOOTb9aLKQsVRSd2c6xerOHFIqBa+xevZ2EwiI/Vcn3Q4dpr3nK9lbAOHMEA7vDtM4j3t6AJ/EG19CXBLe6Zqp9lIjaOX/xQgfC3YOd0xCjv+2WuWni59JsvcWCuQutAeztwSnHWfR5/rE6mBR3Tzonlc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10255.jpnprd01.prod.outlook.com (2603:1096:400:1ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 02:50:35 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 02:50:35 +0000
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
Thread-Index: AQHYNeVndi6AuZZxXUGaRp3E70Yunay9/A+AgAAmPoCAAA51AA==
Date:   Mon, 14 Mar 2022 02:50:35 +0000
Message-ID: <20220314025034.GA3061370@hori.linux.bs1.fc.nec.co.jp>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-3-linmiaohe@huawei.com>
 <20220313234157.GB3010057@hori.linux.bs1.fc.nec.co.jp>
 <8aa7cdd9-8104-2fea-879d-61519f6489d1@huawei.com>
In-Reply-To: <8aa7cdd9-8104-2fea-879d-61519f6489d1@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd78ec55-6364-411b-5906-08da05656a0f
x-ms-traffictypediagnostic: TY3PR01MB10255:EE_
x-microsoft-antispam-prvs: <TY3PR01MB1025555648621E77901FFAE2BE70F9@TY3PR01MB10255.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sLkgGu6WOmjG0NE8IMt87U/Rm9tXjSSskIEJGIhaCYjF2yu2OhXxtFWp2d+RizS/fgu+P2pBXKynrmr1ZMXQt7bUxd9ksTpqZiUuHj1/KuVYyD/D/vgY9h+8g+KHLDz2huG/fcJ+HZ66aFf0KJsYhSdtHiK9enGReXmc1ghGXHuv9Cg8L1wRd95tYr5UIhNlvFJ1bApmh0V7kKjkVAyB00aEBJYMXeSh3m+vkctZ5AZMsSDAYui59YI+JyatR1T3ca1k6sJ88BLXfrtz5Dxmu+yepMLDNKP+CdvI/Ws+sM6PquamboQ2sr7tMs4jyL5COf7V5rmMkJ0yfF15e5M6ZgBaP6CIfUiYFmOvpoY/6d5RpCGMX4HjB7ycKTnIZRyK/+UzdnWA3Zy+XwxJuGTsoKseSb2amUmM7AS9jsEVgWDudgIU7e8PgncynVSupXiviCq6zr1Ac/Kp4zr7zpeC+Gh4FXnPATUNQMt81YGWXjv3uoEUPu3G/cuqUAht5p6gAYQmsclC4DbcPPl4PqvcHQhsHZSxonXxX9bhqGl+7DED1o61scafpXFZOimIR0YMm29E6TR+9dQRCAH73tKaFlTKcLa8OyNkmo4vvCQ1QmmZrqMxWnmpTqd+OPlZ+o6i4/JRNnOYgTmGguwlOIaJmzDkXYFQLswwKcMav4qZiaK2QczZ9W7PTnWtvg5gvjz4pFBgbxKS+zZN0ISPtcB1u9N8mSzADJ65sdJPvVYdT58+8ifdFIQNTxp0QFm8DUnXvfTctdHKjB8H++nNVcX8aA2zliPEJ4toyseX7Q/t5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(82960400001)(4326008)(64756008)(66446008)(122000001)(53546011)(55236004)(9686003)(6512007)(8676002)(5660300002)(6506007)(85182001)(76116006)(66476007)(66556008)(66946007)(8936002)(38070700005)(86362001)(83380400001)(1076003)(186003)(26005)(316002)(71200400001)(54906003)(6916009)(966005)(508600001)(6486002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1RoeG4xaXpsOGp0OFIrQUVldnJaL09FTDFEUXJQVjkvTzJwbThDYjd5TGoy?=
 =?utf-8?B?UytlcGdHVlZBN1Fvd0JrbWwvc0lDUlR0Z3dFUzkwNEFyTUx6TkJJVW9kR2Fm?=
 =?utf-8?B?M3FwOHpTZmdLMTFLOEJ6OW5SOFF0VVZpS3FUNVpkV0hxYU50OGs3TEhyM24v?=
 =?utf-8?B?M3Jkcm1RdHgrYjZ4KzdqeGxGOEdSZUllQ1RBS2dQeGJEaTNlTTF1Y1lVQmZq?=
 =?utf-8?B?bjRITTRQOGVTaU1FdHNKZTVXUUYrVVY1TUtOVVcydG5KeXc1TUtGSU5kOFpu?=
 =?utf-8?B?NUZ2OGlmQ2tUMEMveGp0bnlxajYxR1pLVmd0UXFnV1d4cnFUUW91US9PUFBS?=
 =?utf-8?B?c3d4dWFWMVY5akRzZU5xVS8wN3ZNT2tFMy9sMlQ5cnN0anZFNlUrUWVMK1F1?=
 =?utf-8?B?T3lrdDcyTGsxbjg1cW5TTWdEM3MvaTczRldjc1UxQVY5TjBYSjBVbGZraW1U?=
 =?utf-8?B?bm95M2FDZU1kT0lOWFVaQURrNVdsWEUyeXZEcTB1OGJraU51OGZpOXN5MHVC?=
 =?utf-8?B?MHBhMkF6RGpVUjZ5dXNsRFpsdHJMb2p1aE1QZHh3TktiODlsWG9Vc2kwMGln?=
 =?utf-8?B?dmVjMWxJMnRVZWJrbDArbk9kODh3NWJIV1c1OGNTR1hQM0FxbVRwaVJvd3Zy?=
 =?utf-8?B?MnB5NTF3a3liS2p3Z0tpSWlsUXd2ODJNbjFGQU54VFVEaUNBVy9XY2Y2Ymx1?=
 =?utf-8?B?ek5INURndlhBV25VdWFXQzVWb1RGVDJBbUYwQm5NRmtYTGhXOUoyT3ZFTzAr?=
 =?utf-8?B?MmorUVBIZ21nSC83TFI1d0NCcGorK3lzaytYZnFWOGJ0RnpUTHAwbWxpU3Z4?=
 =?utf-8?B?R29MWVVwajhoeVVDVldRZjhPalNJUlhqRUdsclV0dHFCbmJiWXk3aCt4am1n?=
 =?utf-8?B?c2dCNzBpUXBxendUSWVHMHNERWN5NVkvZk1jRGZMMEJxNTNtZ09nVkZzSEJk?=
 =?utf-8?B?ZFdlcmM5R1N6eWlzaWJVd2NTYkhiY2NsY1FnYnhnR3h0QzA1RG5aSFV5aGFq?=
 =?utf-8?B?QmhPclNpSEJ1aWUwRlh6NGM3RTBISmV6RUYwOTFNQzdkVWNmK3Q0SkRTWU5v?=
 =?utf-8?B?U2ZkeEZEeE81REc3RUFBSUVmWUUxUEtvQ2hQY1B4UkJPS3YvNUxTRktQMUVT?=
 =?utf-8?B?elNVQTg3Z1ZCNkZsTmprdnJidWs4d21aME5XUkdpeEhUSTVwd25SYmthMjNn?=
 =?utf-8?B?eU04bzJ2V3Q4a3FsMjRsb0pnMnVLMXhQNmJ0MGNMbmxhekdWU1RwUm8xTmpU?=
 =?utf-8?B?bkdsR0ZYRzRPNmE4NytiTkRkcjJUYy93YlBmZkZocEptcjVhZXpiSW05OVNo?=
 =?utf-8?B?VFROSnRwb0xzN0g0NFN4QU16UDAyRjg0TVpKMFZaVlQvUTJhczVXVTIycDVL?=
 =?utf-8?B?NWlIMFFZdEFiVHNFWlZ2Sk9HaTVNWnNvUmpaRHB5WHZNMStFTjl6bXgwdEtM?=
 =?utf-8?B?NGhtUTRDOEtXSDhDbjZyZjJvZEk3WStFaCtTLzh6dEFxUXI2ZVhRakNRNnZE?=
 =?utf-8?B?YWd1bHpHREtlckVQZGx5Wjg2YTQ1dUZTS3dwT1ZJT0J2bW1MSlZPK28wbDc1?=
 =?utf-8?B?RlQzcDNYbVNLcHoyOVc5cnA0bStPTi9Oekp6VWJvWkUzOU5UbnY4SWhLMGth?=
 =?utf-8?B?ZTliTGtZZEx4UFFrclo2Q0hoWlZlTlNnZi8xd3pxTENydDRIdGtmTndnditG?=
 =?utf-8?B?MXJoYXRTdXJqb2ZhRFppTXA3NjJoc2RuWkhPMlNmR1lCSkVFNDZNWG1xQzVL?=
 =?utf-8?B?YlJtYm9KRndkTURxTmYxd2VCTWhoZkFOb3dhaytrZTN6c1kxaVBKblAyME1h?=
 =?utf-8?B?SG9TNW40QzZHOWQwc3VGWklyUVBZMDhNY1A5MDZyNWl5eHJEcDlvSjAyamZ5?=
 =?utf-8?B?Nm9hRkRUNnBiZGhlOFNyVTZpRllEVEt1cC9ZaSszNkNFL3NDY1djYkM0SHA0?=
 =?utf-8?B?ZnJyNlp1ODdZVktJVjc4LzRIbEM4alltV00rdlVING1YQ291dnl6UzF1Zm00?=
 =?utf-8?B?K2s5d0UrSmVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB32EF732DC95C48840BFA7B8245E219@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd78ec55-6364-411b-5906-08da05656a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 02:50:35.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4VZ3xO9b/G6uHS9rObrSs7DlR/8b/BkAjHInhE16y359qSojM3MJzH7Yt0B2r8fd4574o/B521Hy3/KJ6J3FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uLCBNYXIgMTQsIDIwMjIgYXQgMDk6NTg6NDlBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8zLzE0IDc6NDEsIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3
cm90ZToNCj4gPiBPbiBTYXQsIE1hciAxMiwgMjAyMiBhdCAwMzo0NjoxMlBNICswODAwLCBNaWFv
aGUgTGluIHdyb3RlOg0KPiA+PiBTaW5jZSBjb21taXQgMDQyYzRmMzIzMjNiICgibW0vdHJ1bmNh
dGU6IElubGluZSBpbnZhbGlkYXRlX2NvbXBsZXRlX3BhZ2UoKQ0KPiA+IA0KPiA+IFRoaXMgY29t
bWl0IElEIGRvZXMgbm90IGV4aXN0IGluIG1haW5saW5lIChvciBpbiB0aGUgbGF0ZXN0IG1tb3Rt
PyksDQo+ID4gc28geW91IGNhbid0IHVzZSBpdCBpbiBwYXRjaCBkZXNjcmlwdGlvbi4gIENvdWxk
IHlvdSB1cGRhdGUgdGhpcyBwYXJ0Pw0KPiA+IA0KPiANCj4gVGhpcyBjb21taXQgaXMgaW4gdGhl
IG1tb3RtIGJ1dCBub3QgaW4gbWFpbmxpbmUgeWV0Og0KPiANCj4gY29tbWl0IDA0MmM0ZjMyMzIz
YmViMjgxNDZjNjU4MjAyZDNlNjk4OTllNGYyNDUNCj4gQXV0aG9yOiBNYXR0aGV3IFdpbGNveCAo
T3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gRGF0ZTogICBTYXQgRmViIDEyIDE1OjI3
OjQyIDIwMjIgLTA1MDANCj4gDQo+ICAgICBtbS90cnVuY2F0ZTogSW5saW5lIGludmFsaWRhdGVf
Y29tcGxldGVfcGFnZSgpIGludG8gaXRzIG9uZSBjYWxsZXINCj4gDQo+ICAgICBpbnZhbGlkYXRl
X2lub2RlX3BhZ2UoKSBpcyB0aGUgb25seSBjYWxsZXIgb2YgaW52YWxpZGF0ZV9jb21wbGV0ZV9w
YWdlKCkNCj4gICAgIGFuZCBpbmxpbmluZyBpdCByZXZlYWxzIHRoYXQgdGhlIGZpcnN0IGNoZWNr
IGlzIHVubmVjZXNzYXJ5IChiZWNhdXNlIHdlDQo+ICAgICBob2xkIHRoZSBwYWdlIGxvY2tlZCwg
YW5kIHdlIGp1c3QgcmV0cmlldmVkIHRoZSBtYXBwaW5nIGZyb20gdGhlIHBhZ2UpLg0KPiAgICAg
QWN0dWFsbHksIGl0IGRvZXMgbWFrZSBhIGRpZmZlcmVuY2UsIGluIHRoYXQgdGFpbCBwYWdlcyBu
byBsb25nZXIgZmFpbA0KPiAgICAgYXQgdGhpcyBjaGVjaywgc28gaXQncyBub3cgcG9zc2libGUg
dG8gcmVtb3ZlIGEgdGFpbCBwYWdlIGZyb20gYSBtYXBwaW5nLg0KPiANCj4gICAgIFNpZ25lZC1v
ZmYtYnk6IE1hdHRoZXcgV2lsY294IChPcmFjbGUpIDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiAg
ICAgUmV2aWV3ZWQtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4NCj4gICAg
IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQo+IEFtIEkg
Im5vdCIgc3VwcG9zZWQgdG8gdXNlIHRoaXMgY29tbWl0IGlkIGFzIGl0J3Mgbm90ICJzdGFibGUi
IG5vdz8NCg0KTm8sIGl0J3Mgbm90IHN0YWJsZSB5ZXQuIEluIHdoYXRldmVyIHdheSB5b3UgZ2V0
IHRoZSBhYm92ZSBjb21taXQgKEkgZ3Vlc3MNCnlvdSBnZXQgaXQgZnJvbSBodHRwczovL2dpdGh1
Yi5jb20vaG5hei9saW51eC1tbSksIGFsbCBhY2tlZCBtbS1yZWxhdGVkDQpwYXRjaGVzIGFyZSBz
ZW50IHRvIExpbnVzIGJ5IEFuZHJldyAqYnkgZW1haWwqLCBzbyB0aGUgZXZlbnR1YWwgY29tbWl0
IElEcw0Kc2hvdWxkIGJlIGRldGVybWluZWQgd2hlbiB0aGV5IGFyZSBhcHBsaWVkIHRvIG1haW5s
aW5lLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
