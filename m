Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931326803D5
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jan 2023 03:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjA3Ccc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Jan 2023 21:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjA3Ccb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 29 Jan 2023 21:32:31 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72348166D3;
        Sun, 29 Jan 2023 18:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2+SxQxuIkWqjQYbv4SLWr3zzPoQMxKGSRZbsgeEYqKg59L2pZ32zWsrZQ7bPKllUsqY4ve0VeYuCO47TIS5kr63Ca5PnWyjSfgNuBYPlwQqDnzWvKB/QkSk1SJBJcAR05NPvTgnA7eTZhwtB/brxtIb3c5XpY9M0CuuGdO1LwsGrA9GD6EM/AgXQfeaY6szI/jVkX5Clo7IOiF7F0zpOGXmGjA1JOjVZh0kXf0F9/fXMiQRoIFFb7ju/f1wJHTMr6VFDAS8uxIcULtZtxzDwGTZiH1d+gxAoCk/mVGrF5JUUvEiaZJxPSsx06rj2BjN/VrmMXk48OMrMqg2ExBLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su+pPM3I19OaiTLWj/Pn0icaDbjOcH0IEnpZS+M4/Ro=;
 b=U5HCwLD39r6KXKCEqTpHRTcNXxDRxj8u5beq+EKEsdfNCAJ4CZsDfloR2t18W2897YNJXiIDQPlnGamVTUi4fFtLae8xPQWapM7lbeVSxaKBf9ntiH+4CFF3+aAyCMVnCSj9Pg+0etNKYYZs/IgZT6cdY4GVQ1SM7AFKWfZSxnDbnsvGKPg1/hsSZ2JkSup75CMnq1kz3K2wU/PZAeKPGtInp0cqG//qzKOc3nKoGj4gkUrrI/fcuwZyv3oMSI01h+66d7MvOopZWEWPoUMtUf+HyEbvDw543MIe+hEbr0uORmd5az8zzAPEgmQ11yRK1ZBXzCfz3HU7Ithk2WEMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su+pPM3I19OaiTLWj/Pn0icaDbjOcH0IEnpZS+M4/Ro=;
 b=ERgtyjDpDrSeBiMTAA4d3FBeL+UNaHMs3VKemhPUx8bT7M77wve1KHBmDKcD77+j8ViqaDgfb1BZ/pXgJaFG64xl5gisKRM3cukjo37DHOJK/RS09EV2Liw8IH1EU9d4neYHfJ+POO0B8ciLeSJV/+2XakEZl/IhjTCm53ZodLY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB5379.jpnprd01.prod.outlook.com (2603:1096:604:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:32:27 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b%3]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 02:32:27 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Tony Luck <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Thread-Topic: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Thread-Index: AQHZMfHKlFBLaxkfiUOM52KUXu/6vq62QkoA
Date:   Mon, 30 Jan 2023 02:32:27 +0000
Message-ID: <20230130023226.GA3955454@hori.linux.bs1.fc.nec.co.jp>
References: <20230127015030.30074-1-tony.luck@intel.com>
In-Reply-To: <20230127015030.30074-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS0PR01MB5379:EE_
x-ms-office365-filtering-correlation-id: 5a64aaa5-0ff1-44f4-108b-08db026a3a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: orhQhcIeJrCbf5Rlz793kvaFdjDOud86DeYfO9oYl34dq2jqWunfBw68t1Ew/j9ikgoK9Z7ZZCaVh/PYWRFUOWX4kwG6lEKl35SCaHoVGIs1ED5qNg0cRtHyUzVnGEf31gkT/tjTmaJYhddVkUH781LYD+53WRRZ/rR9XoouBPTwpqZb24ACQ8n50Z+HSv3atNDtoZdOEElN9ziQ+hOnL7WvduEFjzQKqznnc0tfo/zJ9+XytF+WZvz3Psu/ljxx4rxxmENoQZRl/g2rmAH7yu9Uft3/z1XwRUyTbUGIvkzvl7GWzxhcNiBYOOg9Zqk2wR6QwvFia3EbTOP0/MjW3m4+P6vMWHSKpyyjeb4hPjCMaelHdXQk6MDYza/Q1uBH0pvVPkb9Ao9XYQWBREEqlamy/2nfgFtfUn6NP1O7HqO128Cn7tPzga/F+6W3hmkin3Kly0gIDvpNa3bR25yuw8ofAZFdnFCa361WIAincoWgLEqQw2DuQ2GFK2LN5/nZpBG/JKEE4DUXcauos8swJeazGG+5avKx/8bp6/vt6uqU+dPn5FUBoTItgxWnfTPQ+awaj10Ej2i5Lse4IhjWaPu5Fozz1ZXAEu1Mqm4oxVFWlfUsPfXpxkTlm5lfey2gXYAT9xH2rJ0miLhi9qUdfsLs1sPEwlSiiXPCzaWHH33DMbAN8sek37PVgC3o+uiG7Wr4+P3MyzSso2GRdLhClg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(2906002)(5660300002)(38070700005)(86362001)(82960400001)(83380400001)(8936002)(41300700001)(71200400001)(478600001)(6486002)(1076003)(6512007)(26005)(9686003)(85182001)(6506007)(186003)(33656002)(66556008)(66946007)(38100700002)(66476007)(6916009)(66446008)(64756008)(76116006)(4326008)(8676002)(54906003)(122000001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0JjaU0yZXM3OVBpU2UwWkZkZ0FpN0FicnhqWDRXNC9EckJpcWg2ejEzZ0I4?=
 =?utf-8?B?d3hjUW9CVHpQK283V24yVUQ2Y0FJNlBVOTdoak9ZSThlSEhOallUc3JVNFVX?=
 =?utf-8?B?dDl0S3Y4V0UrbjZVNjcwQmpHTzZrR25aRzZzSThGVVlWZ3ZrOEdMNGhjWVpl?=
 =?utf-8?B?Qm1NK0RpRG5YQ1pDMVhNbWcxZkpFQjdzM3M2YUlIRE54UHpxamZrOUVweGJX?=
 =?utf-8?B?SW94bGtPKzBheU0vOEl0R2hXSkhVZDI2RCtkSDZRd3JuVWZwS0FVWXBsSzYy?=
 =?utf-8?B?RS94L1czNzFtdlRFN2VFMnY0NVJZcFlPWkYyemFVWUQzWUhnc3FQRlhreWJo?=
 =?utf-8?B?Mk92M0dUV3U2bXFkVWU3S2phYkFtdXY1R3RKVTZEeFVkTVlQRmtzS0lsNkF3?=
 =?utf-8?B?VDJadk1LSlQwaGZ5UERFNkNaZ1JZVXR2QUFibjRmNkloSmpJVUUyb1JFczNt?=
 =?utf-8?B?QWs1aUhmOUFtM3M5NjdKN05QaTEydU1xSXZWekRtZ1pxV3dvUzQ4Zkppd2s0?=
 =?utf-8?B?b09zMVZNd2ZHK01ZM3dTY005alFYQXd4bDJLNk1UUkxMTXRxSCtQQUIyMHlM?=
 =?utf-8?B?VU9iM2lWbWhYMTJDb3pPazJ2VG41ZG9qQStqYkFVRmxGcTMxYnlhLzlXTzkw?=
 =?utf-8?B?VjJROHQrWWFUNVhMK2xHMDFiQU1jVGRsWFdSeWdMMWtQNFNHNHhScEJvbmNX?=
 =?utf-8?B?bmFSTkZzcFhhMzE4YUEwcm54NEtOY3RySkgxR3QyUmV6UzlHcWY0UmhsY211?=
 =?utf-8?B?UTg1T3BCa0ZxUncyN3JSTkFRUDEvTEU3TTlhL0RadUZVVWNGZTVsSEhUQ2Ix?=
 =?utf-8?B?RTJIYkMwRWNjWGhocXpOMUFLVWJiSUZBZXpJZzVSakxiRUNFSytDZFhlK241?=
 =?utf-8?B?OFk4d29vRUdxQXNLVGZ4eEhFb09sL1ByUitOWXpSbUxPVkd5amlpQm1MV1hy?=
 =?utf-8?B?bDVSZnBRd3ViajZzbTdVOEdiVG00Ym9LdDBSMkRiVkVsdGUwTEpnN056TCtq?=
 =?utf-8?B?MFFXVW05bi9GTUZXNUVZRkZGbGk2T000eWZHblg5T1RFTkZpWSs0RTMram5Y?=
 =?utf-8?B?bENPcmxOTklsMkRmVmkxb0p4WTFQK0Jwd0ZiL3JYT0t1UVk4RzBFaEtKWnRQ?=
 =?utf-8?B?Rmg5bVdDQ3dBVENGZGcwZnh4WDdFam5UOTc2cnpsMzNCd3F6dHdzZEdjV1cv?=
 =?utf-8?B?a0k5V2o2WTJlc2lUdDJqSzFibEMyemFrRnludFFBWkdnUGRyb3AvdXk2a2N6?=
 =?utf-8?B?L29aOHBzVlNyRnEzb0N1TVJjTk1nNURnNHRPclZDbGVlcWlhdEx1T01vZEhO?=
 =?utf-8?B?MVpDTGNFdWRKTCtueUUxNUI0UjZZQTZDRFZhMGQ2cnpBVTN3WHV5T3BJZWlv?=
 =?utf-8?B?Z2Jic1RvOVR4VkFKRUJOeTFobTZtaksyNlN4TXFrYU9zdGNwVWh6UlJJSXJl?=
 =?utf-8?B?clBRODVaOFJZQVdjZW5Kdk9UQlczbFMweUR2V1VTWmJWTzRZVmp0R3I2ancy?=
 =?utf-8?B?WmVBNlBYZytOaGNpaHpEeC8vSXpOUStCSGs5cHAzM2I0NzErVUdzUUI5SlZB?=
 =?utf-8?B?ZlEzU3BxTXBoWTRRdDZWNmJoQjZwempKMWdNNDRramlFMnNBUjkyVTNOOFY4?=
 =?utf-8?B?NlZZbDFPRU9JanlzZ284N0QvV2hqeWRJTXkyanFQbXl0TjVaSDZQeGJJV1NY?=
 =?utf-8?B?aHQ2YUh3L2ZNOVFseTB6eEFCRDhubVBUL1ZoSHpjdkF4N0c0aVRhWG5FTE5V?=
 =?utf-8?B?SDNzd2hqdHRjY29hWmlxY25VSmUxOXVNOTlyWlpTQXVOYUw0amF2ZWdNSXY0?=
 =?utf-8?B?MFJ5bUFzeTJXazlLYVFVMEtRUkFER0YzY3ZvWUY4YmwxdjQ2azhyQVlrOXds?=
 =?utf-8?B?TWJIZmVScDVuY1k5dUVZK205UE5pdFNab3F5Z2tVYm5GSEwvNU9OM2QrRVRq?=
 =?utf-8?B?OVlnT0NmQWVMYmI4MlEzckYzeE5Fd0lZajdxS0RTSWZDcFg5VTI2V0pMeExR?=
 =?utf-8?B?bzJEcTcyb2tRU0tHYUowVzB0YTVRd1JQVWVHanZuYlpiZUdtWHozOTRGQVI1?=
 =?utf-8?B?RDlUR0VnVVVackJGSTJPNEx6L2YyUGptdmlvSUUxNnRSd0ZxelVtYUoyUW5q?=
 =?utf-8?B?ZThFM0M5ajB1K20wMm1QM29SMkVURGhsZjkxWURZM1R2U3pqcURsSXoxQzNI?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <751AD2C82DE89742AE2057F4B26B469B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a64aaa5-0ff1-44f4-108b-08db026a3a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:32:27.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBVTs/7+tPTQRpClYLaKZVo0+7naEjbrYSggc93PEP6iR9EBsUkr3m643CmFJQBWwfUuhjJP0aUrYiz3HVMjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVGh1LCBKYW4gMjYsIDIwMjMgYXQgMDU6NTA6MzBQTSAtMDgwMCwgVG9ueSBMdWNrIHdyb3Rl
Og0KPiBGcm9tOiBaaGlxdWFuIExpIDx6aGlxdWFuMS5saUBpbnRlbC5jb20+DQo+IA0KPiBLZHVt
cCBjYW4gZXhjbHVkZSB0aGUgSFdQb3Npb24gcGFnZSB0byBhdm9pZCB0b3VjaCB0aGUgZXJyb3Ig
cGFnZQ0KPiBhZ2FpbiwgdGhlIHByZXJlcXVpc2l0ZSBpcyB0aGUgUEdfaHdwb2lzb24gcGFnZSBm
bGFnIGlzIHNldC4NCj4gSG93ZXZlciwgZm9yIHNvbWUgTUNFIGZhdGFsIGVycm9yIGNhc2VzLCB0
aGVyZSBhcmUgbm8gb3Bwb3J0dW5pdHkNCj4gdG8gcXVldWUgYSB0YXNrIGZvciBjYWxsaW5nIG1l
bW9yeV9mYWlsdXJlKCksIGFzIGEgcmVzdWx0LA0KPiB0aGUgY2FwdHVyZSBrZXJuZWwgdG91Y2hl
cyB0aGUgZXJyb3IgcGFnZSBhZ2FpbiBhbmQgcGFuaWNzLg0KPiANCj4gQWRkIGZ1bmN0aW9uIG1j
ZV9zZXRfcGFnZV9od3BvaXNvbl9ub3coKSB3aGljaCBtYXJrIGEgcGFnZSBhcw0KPiBIV1BvaXNv
biBiZWZvcmUga2VybmVsIHBhbmljKCkgZm9yIE1DRSBlcnJvciwgc28gdGhhdCB0aGUgZHVtcA0K
PiBwcm9ncmFtIGNhbiBjaGVjayBhbmQgc2tpcCB0aGUgZXJyb3IgcGFnZSBhbmQgcHJldmVudCB0
aGUgY2FwdHVyZQ0KPiBrZXJuZWwgcGFuaWMuDQo+IA0KPiBbVG9ueTogQ2hhbmdlZCBUZXN0U2V0
UGFnZUhXUG9pc29uKCkgdG8gU2V0UGFnZUhXUG9pc29uKCldDQo+IA0KPiBDby1kZXZlbG9wZWRk
LWJ5OiBZb3VxdWFuIFNvbmcgPHlvdXF1YW4uc29uZ0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFlvdXF1YW4gU29uZyA8eW91cXVhbi5zb25nQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWmhpcXVhbiBMaSA8emhpcXVhbjEubGlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBU
b255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQoNCkhpLA0KVGhhbmsgeW91IGZvciB0aGUg
cGF0Y2guDQoNCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgfCAyMCAr
KysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gaW5kZXggMmM4ZWM1YzcxNzEyLi4wNjMwOTk5
YzYzMTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gQEAgLTE2Miw2ICsxNjIsMjQg
QEAgdm9pZCBtY2VfdW5yZWdpc3Rlcl9kZWNvZGVfY2hhaW4oc3RydWN0IG5vdGlmaWVyX2Jsb2Nr
ICpuYikNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKG1jZV91bnJlZ2lzdGVyX2RlY29kZV9j
aGFpbik7DQo+ICANCj4gKy8qDQo+ICsgKiBLZHVtcCBjYW4gZXhjbHVkZSB0aGUgSFdQb3Npb24g
cGFnZSB0byBhdm9pZCB0b3VjaCB0aGUgZXJyb3IgcGFnZSBhZ2FpbiwNCj4gKyAqIHRoZSBwcmVy
ZXF1aXNpdGUgaXMgdGhlIFBHX2h3cG9pc29uIHBhZ2UgZmxhZyBpcyBzZXQuIEhvd2V2ZXIsIGZv
ciBzb21lDQo+ICsgKiBNQ0UgZmF0YWwgZXJyb3IgY2FzZXMsIHRoZXJlIGFyZSBubyBvcHBvcnR1
bml0eSB0byBxdWV1ZSBhIHRhc2sNCj4gKyAqIGZvciBjYWxsaW5nIG1lbW9yeV9mYWlsdXJlKCks
IGFzIGEgcmVzdWx0LCB0aGUgY2FwdHVyZSBrZXJuZWwgcGFuaWMuDQoNCnMvcGFuaWMvcGFuaWNz
LyA/DQoNCj4gKyAqIFRoaXMgZnVuY3Rpb24gbWFyayB0aGUgcGFnZSBhcyBIV1BvaXNvbiBiZWZv
cmUga2VybmVsIHBhbmljKCkgZm9yIE1DRS4NCg0Kcy9tYXJrL21hcmtzLw0KDQo+ICsgKi8NCj4g
K3N0YXRpYyB2b2lkIG1jZV9zZXRfcGFnZV9od3BvaXNvbl9ub3codW5zaWduZWQgbG9uZyBwZm4p
DQo+ICt7DQo+ICsJc3RydWN0IHBhZ2UgKnA7DQo+ICsNCj4gKwkvKiBUT0RPOiBuZWVkIHRvIGhh
bmRsZSBvdGhlciBzb3J0IG9mIHBhZ2UsIGxpa2UgU0dYLCBQTUVNIGFuZA0KPiArCSAqIEh1Z2VU
TEIgcGFnZXMqLw0KDQpBbHRob3VnaCBJJ20gbm90IHN1cmUgdGhhdCBTR1ggbWVtb3J5IG9yIFBN
RU0gcGFnZXMgYXJlIGV4cGVjdGVkIHRvIGJlDQppbmNsdWRlZCBpbiBrZHVtcCwgYnV0IHNpbXBs
eSBzZXR0aW5nIFBhZ2VIV1BvaXNvbiBkb2VzIG5vdCB3b3JrIGZvciB0aGVtPw0KKE1heWJlIHRo
YXQgZGVwZW5kcyBvbiBob3cga2R1bXAgaGFuZGxlcyB0aGVzZSB0eXBlcyBvZiBtZW1vcnkuKQ0K
DQpBcyBmb3IgSHVnZVRMQiwga2R1bXAgdXRpbGl0eSBzaG91bGQgcGFyc2UgdGhlIHN0cnVjdCBw
YWdlIGFuZCBiZSBhd2FyZSBvZg0KSHVnZVRMQiBwYWdlcywgc28gbWF5YmUgc2V0dGluZyBQYWdl
SFdQb2lzb24gb24gdGhlIGhlYWQgcGFnZSBjb3VsZCB3b3JrLg0KDQo+ICsJcCA9IHBmbl90b19v
bmxpbmVfcGFnZShwZm4pOw0KPiArCWlmIChwKQ0KPiArCQlTZXRQYWdlSFdQb2lzb24ocCk7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIF9fcHJpbnRfbWNlKHN0cnVjdCBtY2UgKm0pDQo+ICB7
DQo+ICAJcHJfZW1lcmcoSFdfRVJSICJDUFUgJWQ6IE1hY2hpbmUgQ2hlY2slczogJUx4IEJhbmsg
JWQ6ICUwMTZMeFxuIiwNCj4gQEAgLTI5Miw2ICszMTAsOCBAQCBzdGF0aWMgbm9pbnN0ciB2b2lk
IG1jZV9wYW5pYyhjb25zdCBjaGFyICptc2csIHN0cnVjdCBtY2UgKmZpbmFsLCBjaGFyICpleHAp
DQo+ICAJaWYgKCFmYWtlX3BhbmljKSB7DQo+ICAJCWlmIChwYW5pY190aW1lb3V0ID09IDApDQo+
ICAJCQlwYW5pY190aW1lb3V0ID0gbWNhX2NmZy5wYW5pY190aW1lb3V0Ow0KPiArCQlpZiAoZmlu
YWwgJiYgKGZpbmFsLT5zdGF0dXMgJiBNQ0lfU1RBVFVTX0FERFJWKSkNCj4gKwkJCSBtY2Vfc2V0
X3BhZ2VfaHdwb2lzb25fbm93KGZpbmFsLT5hZGRyID4+IFBBR0VfU0hJRlQpOw0KPiAgCQlwYW5p
Yyhtc2cpOw0KDQpJIHRoaW5rIHRoYXQgc2V0dGluZyBQYWdlSFdQb2lzb24gb3V0c2lkZSBod3Bv
aXNvbiBzdWJzeXN0ZW0gaXMgT0sgaGVyZSwNCmJlY2F1c2UgdGhpcyBpcyBjYWxsZWQganVzdCBi
ZWZvcmUgY2FsbGluZyBwYW5pYygpIHNvIGl0J3MgZXhwZWN0ZWQgdG8gbm90DQpjb25mbGljdCB3
aXRoIG90aGVyIGh3cG9pc29uLXJlbGF0ZWQgY29kZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1
Y2hp
