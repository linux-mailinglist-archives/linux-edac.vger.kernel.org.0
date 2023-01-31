Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848FB682387
	for <lists+linux-edac@lfdr.de>; Tue, 31 Jan 2023 05:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAaEuQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Jan 2023 23:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaEuP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Jan 2023 23:50:15 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84045CA03;
        Mon, 30 Jan 2023 20:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjkaPFMJpVGNtn5WFHzdF4SF4LvF2bJK2jnFRIQ2JlmDVsbFLX/QpwkliVzV5Dh4+cUbbI/d+kFBaOzV3meyOr54FpNUOug8tcD0YVmTVf4zg8y8j8jFSOSF+8SFPGpQBOEpggwjo227xNrUa/6NekmuGcBzLAoqIZt0FgQe15zvzFP5mg491aZ6o0Yq1qguU8klXpB6voGOjzt8TS96WXa7drCXOw6zQDLh4EiMySr/OW3owUOdrLVr0Xws8xojMoyTjr3ejYfOpMqxZTBzzoDu5L+PB73cwViKJYnnARPebX90rjcuEOmB791AoJu8nGDZNsAy8jcdEnxbuzHO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFfwTRK/96CsKwbnL3OOhxTMFIiMVGik+JWaIwwmy4I=;
 b=Zc5Pgd6q38K/MZhm8ScPdtIPy3mW2UFts6Q7DVpA+jXe8aiH+gQOAGMSyRMmbbHLfJ/VMBwxvV7GU4dB8vU5sFVHcvhM8qNLWJ2Ct7QgYUC/3L6iDGQSzMbUlDYeV4fMjVAyzTL7AIArzCOXIIl/XOpIOt8sjIZgJiZCyWz57qM9Oc1F1LOJp8BHnp9+JtpCp6cGrb8zlbTWOIWsZYVQHczhqkrAznrPXNtZmoVHF5L7BcTYufPWlyvYgR+tVSvlIsRcfDz9HQ280b1jDJhzWhzKGXQhfHBEZ5nUszoDzQxnDarg17P/jXMq1MFMLcxibnBQWCBn5B9tfedHftQVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFfwTRK/96CsKwbnL3OOhxTMFIiMVGik+JWaIwwmy4I=;
 b=CVvckjKor+Un2HZMaM0uLUSJ1YnzhOSCSSIHptZ2uBm7cXJ064onPOr5KgAQ2yNtM8ul0ZMSc99pw1h9Oqye16cD9SSUltcx4BYN7ZyC4k5GDiEGI/h1DcWFnbiHl1P03OgmlxFIcjoblv5JTMGfwRUWpUr4JCJ9L5Za0IdBYNM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB9893.jpnprd01.prod.outlook.com (2603:1096:400:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 04:50:12 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 04:50:12 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Song, Youquan" <youquan.song@intel.com>
Subject: Re: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Thread-Topic: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Thread-Index: AQHZMfHKlFBLaxkfiUOM52KUXu/6vq62QkoAgAEZ3ICAAJ72gA==
Date:   Tue, 31 Jan 2023 04:50:12 +0000
Message-ID: <20230131045011.GB3997492@hori.linux.bs1.fc.nec.co.jp>
References: <20230127015030.30074-1-tony.luck@intel.com>
 <20230130023226.GA3955454@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB6083B06E5B75E429E5143B76FCD39@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083B06E5B75E429E5143B76FCD39@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB9893:EE_
x-ms-office365-filtering-correlation-id: 60a122f8-3878-4f6b-70b5-08db0346a343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHs9117BPXsswxUpwHboeUmHOXPMJE6KoGVd7qQAt+5uwRF/DrUDRVOJ1gT+1VxK6DYs/1wxnwW9KJAe3tTk1jn9+2td7mdCLFa3o31maK15Kb3Qm/tlcjHurQi69gjjiUJOpCA7m+k3mdXTWNr7QBTxmvc5EqMcWPAyF5rrYRpfG4MQf31SJdbrpUChVHuj8EXSFitkt7sGfg8V785RJkaYquwMhJbS4rMeMTivNihsiPV3sKSu947ro2fk+kIFl/py4ssRhe/79YtfKDTG14tVAuBOxtx7Yp3Ns/pdOc/1TGep4pySJAyncBe2FLK2ryDKork2Xz/y/9eAziAKVbJdUgfBA49rU9wTq9G+mNDqrYhiytX0jvK/dN7N6f+Lpv4HlBRPnrieo7LAVbrX6XBkPI9oYiP26W3Cedgs0J7UAiZvE90yo1GRXI/cb6mcnvBeWoX+buJ/ov7s/WrVLE6rvsU57IxdL/92J3tlUa0+4Y9GTqN3ZD67jqZhSHfreCWZKyg7bRqvlrtFjawrzsFQV8g1poxtOYc/L/BTAGvBk9P209KlZYt7hUKwMCOEU3dTVoZptWmZPIOR7gj9pzCz7xwWDm0O5mt7nBdlp4rVlgygfq32yY6vIMcWnlCd6O6jXIEImV58Hz+QbrGfydmfSwAnM3kNLKJLX3w5MJuYtPBEZnlrNJl9ktBqXiL/CwMrVJnWUNRSafIdjXwYYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199018)(4326008)(66946007)(76116006)(41300700001)(64756008)(6916009)(66556008)(8676002)(66446008)(66476007)(33656002)(8936002)(316002)(5660300002)(54906003)(6486002)(85182001)(71200400001)(2906002)(186003)(6512007)(9686003)(26005)(478600001)(6506007)(1076003)(55236004)(38070700005)(86362001)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVN4WUlmQVVORjZSTWFlMjBnUzEwektsbEpGVFRCMDFxT2dvVEZneGhDaEM1?=
 =?utf-8?B?a2pDZ2VZZ0ZyWGdPbXE2c256NU5GeTRCc0NNTEVVRWVpZTI3OUNwOExjTjdC?=
 =?utf-8?B?S1JQM0JqNGV6Rk1jYVk1YjN4ZkxwdFQ0djVFNmlKaEZvWTk2YkRpSTN2VlV5?=
 =?utf-8?B?WHFxNXV0bEI0WlpML0R5bC9SSFJGRmdma2tCUWNaWVVkQlU5bWxvQ2swUndo?=
 =?utf-8?B?UHdwSStvcU9IUDFrNmpydjFBTFYwMHFFc1RDS0I3QnlrOVpjdnhyWll4WGcv?=
 =?utf-8?B?UjRiYjR6eVNZQXVKMElMYS9Dd3BrOGM3dmJlSmFpVWhMMTZBemNyVk5Lem52?=
 =?utf-8?B?NXpNQzFjRXlGSE1rOUV6TFg2K0pLTGFNSFkvTTFsNENRNkRYNTNuYVBFenFM?=
 =?utf-8?B?T05lQ2FkREIweHhDWXhiK01JWVE4MnduaTBzMUJndzlhR3hDckVaZVdFWHp5?=
 =?utf-8?B?S3BjUEJwTVdPbUptd0paWUc4S1ZJMFVacUZaNmZxMUx5aDNRSk0yY2QvQlVK?=
 =?utf-8?B?ZGlJemUyUnRvWjArd2RkbjhuZEcvK1QxZFd5bFlaQk5MSHlZSkRmdStBTmd1?=
 =?utf-8?B?WmJ1R2o0VzFHVS9QZUFtUmlYTWgwWU9hRmpnNUVUSFBvQ0hQYzVDRHo3TTNB?=
 =?utf-8?B?aExtRXkyK29TZ2ZvekVRRk9HcEVSdmJJN0kzbXl4RTVERlBwaERCdW9ocTA1?=
 =?utf-8?B?M3JGeS83NUxQcGNyRkVwS051UTU4eVNYaDVzc0JLVXMzTDNlK3dpeTkvdTVh?=
 =?utf-8?B?UVFkaHRKZ2ZkSSsrSHVtN1ppVElVS1ZUczA3djhxcFB2WEtEM3lQTmFyM2Z4?=
 =?utf-8?B?M3pyWVZjRjUyTGFlTk13NVRodFRFUTZsNlRmWGdvWCsxOXBINWpQZ0xONHox?=
 =?utf-8?B?SXU4bkN3WUVnV0NZREtkYWQ0aVBFVS9vNkFRYitnQkVnVm9YTjhtd2NDOHNS?=
 =?utf-8?B?c1ptNnlPZWNTSy8xQUVJTEl3bjcvT3hKRlZJbmRQMjQrTTFGclB1Ly9wVFly?=
 =?utf-8?B?K2plUTBoY0QvQWFkVE9xek1Xd0FOTnJrc2FLTmcxdUZKV2s4VHdZWWlMN2g2?=
 =?utf-8?B?YUNjTnN6OE44NWVBL3dJNXhKVzA5V0VJcnRQOTVjSG5hM2t1Y21DSlJtNzNJ?=
 =?utf-8?B?eXY4NHd0V1YwUzV3dVlaTmNGT3dDVGlHZmxQUk5JZDAzcEVJb25tUTZmcVp2?=
 =?utf-8?B?WTlRajdFMWFrOFlwTzRHOW1DR2prZ1daNGhiOTVMNnVEeEg5dVpGc0lwT2VD?=
 =?utf-8?B?YXNoeVdPd3NDU0pVWTY2R0xnVzlhT0ZwMGtKMnZscjAwZzZZOUNmSTZZRW9E?=
 =?utf-8?B?QVZ1M1VONXZpK0FTOE1OY0E4RzVnZ1RWY0VTM1RsUTNjczdjQ0xUR01YR2pn?=
 =?utf-8?B?U3RkdWN5YzFjK3dEUXpCNzRJUUVVdzhGVFNBWXIzVFNCRHJLSmF2ZVRCaXVo?=
 =?utf-8?B?Tkx5Yk80ZzVWRkovWTZoeTBGdy96KzJlbStSVjlTUjdrZUFJc0xnZGRPQzFC?=
 =?utf-8?B?SjRjblhWRElDTEg2T1JYb0IydGFlUnB0bkRCVHVRSXJnOC9iSmtKQWJFVmtl?=
 =?utf-8?B?ZzlweTVoKzBGYWNHWkljVUdsakN5aGRCMVBFbjIxK1JRVmhjdWxPL2dLT1RT?=
 =?utf-8?B?d3ZicENuYUNvbjlOQUtjUk9SVUhXTFdZVUxCRWdaZEJ6RkliTVNQSTR4VEhP?=
 =?utf-8?B?aVlLL3F4V05HVGxQSnM0UVREVXFGelJGQWJ1UkRzcElrUGc3Tk9QSWk1eDQx?=
 =?utf-8?B?QXphaEtvbDJDVXpMS0RJT1B2RzBMSjJpSHJYdGM3Rnc2TmJXT04rbTFjWXhp?=
 =?utf-8?B?ditmMm0xdDA2aVltbUtYVmE2UXpTd0ZXWC9kUUwrL1BqV3Y3UkV2N0FoM1NK?=
 =?utf-8?B?a1kxRXJCeDF0RlVnN3JpZXltZ2lNaUZPaUNXeVlnTHRQZmtMUUYrTk1ZQkVy?=
 =?utf-8?B?Y01SSVZ3NE5wODE1Y3hPVEVaS1VhcmV3VDBZYnNaQ3B1N2h4N1k4MGtyRlZT?=
 =?utf-8?B?M0JPVzhRWW5Jak5kaFdzVzFqQUllTDRXS3FSSnN5Y3FJeW9VWWVHbmkvNkxG?=
 =?utf-8?B?MzJ3WWo1VytrNGpVb1BJalV3N1F5a0JJbkFoTFd2Y211UVhkQkhJWmwrYU52?=
 =?utf-8?B?L1Rob0xycmtoMmd4ZnQvaDl1U1N0enpDK2VPN1RTYkFHT3JrUTJjaVFLL3o1?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F249A6E9421C0488847AB9EBFB9CF3E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a122f8-3878-4f6b-70b5-08db0346a343
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 04:50:12.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2/Vr/CQ9KFzo9W3vPV0RDVdX9iaY/8cAsnPDsxChPBXVk47MynTEEg1DEcjdSA/B3qUn9kI4+3w8MyMmGq69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMDc6MjE6MTVQTSArMDAwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gPiBBbHRob3VnaCBJJ20gbm90IHN1cmUgdGhhdCBTR1ggbWVtb3J5IG9yIFBNRU0gcGFn
ZXMgYXJlIGV4cGVjdGVkIHRvIGJlDQo+ID4gaW5jbHVkZWQgaW4ga2R1bXAsIGJ1dCBzaW1wbHkg
c2V0dGluZyBQYWdlSFdQb2lzb24gZG9lcyBub3Qgd29yayBmb3IgdGhlbT8NCj4gPiAoTWF5YmUg
dGhhdCBkZXBlbmRzIG9uIGhvdyBrZHVtcCBoYW5kbGVzIHRoZXNlIHR5cGVzIG9mIG1lbW9yeS4p
DQo+IA0KPiBTR1gvVERYIHBhZ2VzIGNhbid0IGJlIGR1bXBlZC4gVGhleSBhcmUgZW5jcnlwdGVk
IHdpdGggbm8gd2F5IGZvciBrZHVtcCB0bw0KPiBnZXQgdGhlIGtleS4NCj4gDQo+IFBNRU0gc2Vl
bXMgcG9pbnRsZXNzIChidXQgSSBkb24ndCBrbm93IHdoYXQga2R1bXAgZG9lcyBoZXJlKS4NCj4g
DQo+ID4gQXMgZm9yIEh1Z2VUTEIsIGtkdW1wIHV0aWxpdHkgc2hvdWxkIHBhcnNlIHRoZSBzdHJ1
Y3QgcGFnZSBhbmQgYmUgYXdhcmUgb2YNCj4gPiBIdWdlVExCIHBhZ2VzLCBzbyBtYXliZSBzZXR0
aW5nIFBhZ2VIV1BvaXNvbiBvbiB0aGUgaGVhZCBwYWdlIGNvdWxkIHdvcmsuDQo+IA0KPiBPciBt
YXliZSBrZHVtcCBjYW4gdGFrZSBub3Qgb2YgdGhlIFBhZ2VIV1BvaXNvbiBmbGFnIG9uIHRoZSBz
dWItcGFnZSBvZiB0aGUNCj4gaHVnZSBwYWdlPyBJdCBkZXBlbmRzIG9uIHdoZXRoZXIgdGhlcmUg
aXMgYW55IGJlbmVmaXQgdG8gdGhlIGR1bXAgdG8gaW5jbHVkZSB0aGUNCj4gbm90LXBvaXNvbmVk
IHBhcnRzIG9mIGEgaHVnZSBwYWdlLg0KDQpJIHRoaW5rIHRoYXQgbWFueSBrZHVtcCB1c2VycyBm
aWx0ZXIgb3V0IEh1Z2VUTEIgcGFnZXMgKHNldHRpbmcgZHVtcF9sZXZlbA0KdG8gZmlsdGVyICJV
c2VyIHBhZ2VzIikgdG8gcmVkdWNlIHRoZSBzaXplIG9mIGtkdW1wLiAgVXNlciBwYWdlcyBhcmUg
bm90DQptdWNoIGhlbHBmdWwgdG8gaW52ZXN0aWdhdGUga2VybmVsIHByb2JsZW1zLCBzbyBmaWx0
ZXJpbmcgYWxsIHN1Yi1wYWdlcyBpbg0KaHdwb2lzb25lZCBodWdlcGFnZSBzZWVtcyB0byBtZSBu
b3Qgc28gaGFybWZ1bC4NCg0KSSBkb24ndCBzYXkgdGhhdCBzYXZpbmcgaGVhbHRoeSBzdWJwYWdl
cyBoYXMgbm8gYmVuZWZpdCwgYnV0IEkgZG9uJ3Qga25vdw0KbXVjaCBhYm91dCB1c2VjYXNlcyB3
aGVyZSB1c2VyIHBhZ2VzIGluIGtkdW1wIGZpbGUgaGVscC4NCg0KVGhhbmtzLA0KTmFveWEgSG9y
aWd1Y2hp
