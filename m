Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2240F2C123A
	for <lists+linux-edac@lfdr.de>; Mon, 23 Nov 2020 18:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgKWRk2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Nov 2020 12:40:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:46440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbgKWRk1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Nov 2020 12:40:27 -0500
IronPort-SDR: wwrYMVUcv7MBjTEgpm+VeX4Fv4H8HwmlQ3VWU0glO159zMrdArceIcQBBAkqpJltw9xEhFdiS5
 AFOsNboaPadA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171907624"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="171907624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:40:25 -0800
IronPort-SDR: yNm5gOdJC8+VtvpVQ0f8D4w1lqW7COkcw2LqLpAVIVBL+m5OM0kc9XFQnJ9PYI2OXGua2eyDfe
 52wq914PZ/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="370116661"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2020 09:40:25 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 09:40:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 09:40:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 09:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhxAsbS7k0Z+ow9xgYM5MCX8OqShROAhN4i7KkroTQ75IPrXCjX3qOOWbKbFcBD1BjoELbTenTcl9hrgH6+pBUsD5U0JqH8sJuqt1NIXWrxo4HmXk0wtQ+tjaTiVtuU6F+/NzacehXlfayxlll2hNp0WDblGA0K95etXrgl9YISH0mNguVVuQ6FY4NUrZ2JC9jPIU/6UhWzgCRg7yXITIdd5teJ3EXz4ZhstBgVBYi+slXMle2q4PpUyrvAl91VsmqBK293Stzc6k//ZGTkoES0PMGuI7HzqKwZPd7ObJhpkriG3KkD0PqFU2lWmqrBQLnNlh/vLfNVy7iUicDYF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VgtCjH87lg5iQuZXzQB7HBPuxS9Dg0MYywEfhgV6S8=;
 b=RuLebn3Yl6X6Xqe4bzMatBxZbs08PyzpQVABNPqunf6CfwPgw9wx+ErotzEWrHNildTDz6Ga5j/uEc1gqw2s+3vq5Ly+7I6A0RQ/X/tmeWogRqhfF9ltBZsy4b0Pub3rsjfG/7PYNWz4l6rucGzPkujkGcNx41kAC1mNk6r3YW08PxDKNllMg9mOmZT1frNY06WeEIFn8qNDStC1tg+Laa3JG8bvdKqPCE6nFcmK/lGguhUpEf+eEm5sd7p6xyLmx0tpqmouUIf46Y+yCmhDbSe9zcEYhAjZAvdeoQdJpJJR5Hh6yxXyJ/xoSK97G3cmtZGvLDqANATRm14vBv/kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VgtCjH87lg5iQuZXzQB7HBPuxS9Dg0MYywEfhgV6S8=;
 b=Q2znDdEmn5yczAy9n1qaxyzWLMSAp26EHQBb3GKFvsxevEVMZ3MSHqx7jcbhZxOI+xXwdN4f699IETozRS/jYUgxB00SzfrkrOj0yRLABI19ZrGPg2Nw5u+6ROGDW9zoAMSGkgaM49LZIjp1PhtBGUVgfnyhefQvoPrkP0q3rhc=
Received: from MN2PR11MB4158.namprd11.prod.outlook.com (2603:10b6:208:155::14)
 by MN2PR11MB4629.namprd11.prod.outlook.com (2603:10b6:208:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 17:40:21 +0000
Received: from MN2PR11MB4158.namprd11.prod.outlook.com
 ([fe80::7c1f:8c42:4ed6:240e]) by MN2PR11MB4158.namprd11.prod.outlook.com
 ([fe80::7c1f:8c42:4ed6:240e%3]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 17:40:21 +0000
From:   "Paoloni, Gabriele" <gabriele.paoloni@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
Subject: RE: [PATCH 2/4] x86/mce: move the mce_panic() call and kill_it
 assignments at the right places
Thread-Topic: [PATCH 2/4] x86/mce: move the mce_panic() call and kill_it
 assignments at the right places
Thread-Index: AQHWvb3H/nsuzmxiaU6OIZYJNsFeCKnVziQAgAAmnPCAAAlHAIAABYqw
Date:   Mon, 23 Nov 2020 17:40:21 +0000
Message-ID: <MN2PR11MB4158D04F8ABD74C313667CF088FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-3-gabriele.paoloni@intel.com>
 <20201123142746.GC15044@zn.tnic>
 <MN2PR11MB4158162EBECE1AEA80D5EC0288FC0@MN2PR11MB4158.namprd11.prod.outlook.com>
 <20201123171910.GF15044@zn.tnic>
In-Reply-To: <20201123171910.GF15044@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [93.57.250.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 518b15ae-0b30-4da8-09e6-08d88fd6da1a
x-ms-traffictypediagnostic: MN2PR11MB4629:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB462937CE04DFF7A04952381F88FC0@MN2PR11MB4629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 08DlcYYAXpe6x/d6qQ0IDM9iIezky13YKFX5UmKvYBXNHDKOUpr/Szw8Pe+nx/ZZ/U/9rpCKH4/K8B8jvc7cloCs+UgYjg64f/qPc1Eky7rch24hd1OnH4Blj8PHxF2+poWoe5zgosXb+M4RxIqbKuGHMOOHLiz6zO5Pzzn67QP1hs1bkxni+HB6l2mbo8FVVsob5iMfdjCzO5qjppfDzYsFFnuKD1GhAP60fFgoiE90MpaR+XSGj/5mY1xpY2pyTmWCvvRutP9MMbfPO8i/d9+PU1GO+TY04xTZwaZqP/vxMWyeSswBlQzmcbJngPxtgo5AE7n2vA/jZJzhqBzuKmSoY90vvTtA2UAtoE/VDLXHN+5pIGMb0flzfyAt64zNTSrp0VGWUu4P838fkwTFXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4158.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(7696005)(6916009)(66476007)(966005)(66446008)(76116006)(66946007)(478600001)(66556008)(64756008)(52536014)(5660300002)(71200400001)(2906002)(33656002)(4326008)(55016002)(9686003)(8936002)(53546011)(6506007)(54906003)(8676002)(26005)(83380400001)(316002)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dTNYSUp0ak9MZHRDWXA2UUN2Z0lFQUI2ZkE0K3pjaE9LSUNKd2xwSTNqeXJ3?=
 =?utf-8?B?UzBKSDY5aUtWcXZ4emxaMGErNnNaWlpKTmhQOXBqaFBadTZMeDArZjVGNlpp?=
 =?utf-8?B?QXRlYlhhZ3dqMS8xbmlpS0VyUisrenRhZ1lMU0NkdFdlenpSd1RiWU9DNG9G?=
 =?utf-8?B?ekx5SW5YVEVEdmlqZnloMUlUNlMwU3NZcWhoU3FnQjFKYmxmclBKeWlHOVNY?=
 =?utf-8?B?citxTGRnOXBvYzJtVWgyTkxmb25PNjRhMTBjVHJ1L0FVUERMdGdRbU91L0Fm?=
 =?utf-8?B?dWF2RVl5UkpFWWZudEozWXRSQ0FpbE9TRXhZRm9nY21EREQzTm9xeEkwSXN5?=
 =?utf-8?B?YWRaaTBuZ2NDaDU2MWdMMTVFNDQ4SWRySVczRkVocnJsWFJkbHNySFBkaVRw?=
 =?utf-8?B?ODg2SnNvR241K3Y1ZlZ4S1ZkbVBSa3VhakNUUk12MHcrQnlBZ2VzVVQzM1l5?=
 =?utf-8?B?cXNIQW9pcG84c0hQdmxMclFoYk4vSE8wUW1vSFVEREZYM1VmMU00MEVCMTBS?=
 =?utf-8?B?ZWVCaHc5MDRQMjFnTlZLaWRodk1Yd3RBb2trS25qVmtudUVDNi8rek9rc1RD?=
 =?utf-8?B?aUt5QVN1NHA4dlFTSW16MVp4UUQxYmlaWW1IcW1oYU1oTC9ab3lXa0lXVGYw?=
 =?utf-8?B?Q1ZIZi9tM1lmeEE0RXJDK2x5YTk0QjR6TjNGNDU0aXVWNVA1SmVrcVlOelNC?=
 =?utf-8?B?VnBmQ1JwOEJBUEpsTzhIMkd1elJRZFhoOExITW9GQWxoNzgvemZ5YmhrRXZk?=
 =?utf-8?B?T3lxcU9KZkZZNDRoanVIK0tvcUtEVzBJRHNTWmVUMUQyZ3dCUWVTRnhybmJF?=
 =?utf-8?B?QWczRjg5cjFJM1lVdWVscTN4c2FNTnNkYkpYOFhOUHZrSUpMMjZraWw0eGQx?=
 =?utf-8?B?b1VJYnpjR09qSWoraTFONWhvVU1ycW9LU0NicHNURjJHTmVwcEV0YmlmKy9Y?=
 =?utf-8?B?eHROZHhJbHBkUEIzMk5GRTVvZlpBeEUxN1Y1OVBMRWZHOXA5ait5Y09OQVhT?=
 =?utf-8?B?bzEvOS9BbjBPdGFRclpTOG1QM3Q4ZjQzRCtWNVd3VVQreE1ucEdQVmtqbGZa?=
 =?utf-8?B?Z2ZMT1ZaTnBSS3Nxb3Y0V2lVOTJBaXNVTkJSVHpqT0FEdWtLWnR2Zlg4Sjhp?=
 =?utf-8?B?VzhHNkMxTUhoRGtPekwxR3loTmx4bjlRaWV6M2tzN01SV3hCanFZKzNJUXR3?=
 =?utf-8?B?cXdhOEJlbkdtMHFQY3VXMUN4MFpvRDROU2dNWEF0Qmp1SXlGOGtiSlVJK0or?=
 =?utf-8?B?M0xKRjBEQWVKZW9xQlo0VXJwR1NhRWRtSXhMWXpSVWc3MXpEQU5OZUtkaHFI?=
 =?utf-8?Q?2iw0XxMzPxZkI=3D?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4158.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b15ae-0b30-4da8-09e6-08d88fd6da1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 17:40:21.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOI3hGv5Gxozzym8Sz/nIZg/iQQ5Y6Pj7WuaeQZzxIqr8dDqlaXIKKZ2Iao9YVE5L4o6KOu4ibSr+FGnxm8KbsEiWUgsy7gXAicBbgaPvCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4629
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyMywgMjAyMCA2OjE5IFBNDQo+
IFRvOiBQYW9sb25pLCBHYWJyaWVsZSA8Z2FicmllbGUucGFvbG9uaUBpbnRlbC5jb20+DQo+IENj
OiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0K
PiBtaW5nb0ByZWRoYXQuY29tOyB4ODZAa2VybmVsLm9yZzsgaHBhQHp5dG9yLmNvbTsgbGludXgt
DQo+IGVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4gc2FmZXR5QGxpc3RzLmVsaXNhLnRlY2gNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzRdIHg4Ni9tY2U6IG1vdmUgdGhlIG1jZV9wYW5pYygpIGNhbGwgYW5kIGtpbGxfaXQNCj4gYXNz
aWdubWVudHMgYXQgdGhlIHJpZ2h0IHBsYWNlcw0KPiANCj4gT24gTW9uLCBOb3YgMjMsIDIwMjAg
YXQgMDU6MDY6MzFQTSArMDAwMCwgUGFvbG9uaSwgR2FicmllbGUgd3JvdGU6DQo+ID4gRnJvbSBt
eSB1bmRlcnN0YW5kaW5nIG5vX3dheV9vdXQgYW5kIGtpbGxfaXQgYXJlIGRpZmZlcmVudCBpbiBw
cmluY2lwbGVzOg0KPiA+IG5vX3dheV9vdXQgaXMgdGVsbGluZyB0aGF0IGFuIGVycm9yIG9jY3Vy
cmVkICdzb21ld2hlcmUnIGluIHNvbWUgQ1BVDQo+IGJhbmsNCj4gPiB0aGF0IHJlcXVpcmVzIHRo
ZSBzeXN0ZW0gdG8gcGFuaWMgKGUuZy4gUENDPTEpOyBraWxsX2l0IGlzIHNheWluZyB0aGF0IHRo
ZQ0KPiBleGVjdXRpb24NCj4gPiBjYW5ub3QgYmUgcmVzdGFydGVkIHdoZXJlIGl0IGxlZnQgZm9y
IHRoZSBsb2NhbCBDUFUgYW5kIGhlbmNlIHdlIG5lZWQgdG8NCj4gZmluZA0KPiA+IGFuIGFsdGVy
bmF0aXZlIHNvbHV0aW9uIGFzIHBhcnQgb2YgdGhlIHJlY292ZXJ5IGFjdGlvbi4gSW4gcHJhY3Rp
Y2UgaXQgc2VlbXMgdG8NCj4gPiBtZSB0aGF0IGtpbGxfaXQgaXMgdXNlZCB0byByZXBsYWNlIGtp
bGxfbWVfbWF5YmUgd2l0aCBraWxsX21lX25vdyBpbiBjYXNlDQo+ID4gdGhlIGV4Y2VwdGlvbiBo
YXBwZW5lZCBpbiB1c2VyIG1vZGUuDQo+IA0KPiBCYWgsIEkgZ290IGNvbmZ1c2VkLCBzb3JyeSBh
Ym91dCB0aGF0IC0geW91J3JlIHJpZ2h0Lg0KV2VsbCBpdCBpcyBub3QgdGhlIGVhc2llc3QgY29k
ZSB0byBkZWNvZGUg8J+Yig0KDQo+IA0KPiBCdHcsIHRoYXQga2lsbF9pdCBzaG91bGQgcHJvYmFi
bHkgYmUgY2FsbGVkICJraWxsX2N1cnJlbnRfdGFzayIgb3Igc28gdG8NCj4gbWFrZSBpdCBtb3Jl
IGNsZWFyLg0KU3VyZSBJIGNhbiBhZGQgYW5vdGhlciBwYXRjaCB0byB0aGUgc2V0IHRvIHJlbmFt
ZSBpdC4NCg0KR2FiDQoNCj4gDQo+IFRoeC4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+
ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1h
Ym91dC1uZXRpcXVldHRlDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSU5URUwgQ09SUE9SQVRJT04gSVRBTElBIFMu
cC5BLiBjb24gdW5pY28gc29jaW8KU2VkZTogTWlsYW5vZmlvcmkgUGFsYXp6byBFIDQgCkNBUCAy
MDA5NCBBc3NhZ28gKE1JKQpDYXBpdGFsZSBTb2NpYWxlIEV1cm8gMTA0LjAwMCwwMCBpbnRlcmFt
ZW50ZSB2ZXJzYXRvClBhcnRpdGEgSS5WLkEuIGUgQ29kaWNlIEZpc2NhbGUgIDA0MjM2NzYwMTU1
ClJlcGVydG9yaW8gRWNvbm9taWNvIEFtbWluaXN0cmF0aXZvIG4uIDk5NzEyNCAKUmVnaXN0cm8g
ZGVsbGUgSW1wcmVzZSBkaSBNaWxhbm8gbnIuIDE4Mzk4My81MjgxLzMzClNvZ2dldHRhIGFkIGF0
dGl2aXRhJyBkaSBkaXJlemlvbmUgZSBjb29yZGluYW1lbnRvIGRpIApJTlRFTCBDT1JQT1JBVElP
TiwgVVNBCgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZp
ZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2Ug
Y29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllcy4K

