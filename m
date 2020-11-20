Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40672BB17B
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 18:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgKTRbj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 12:31:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:50290 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgKTRbi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Nov 2020 12:31:38 -0500
IronPort-SDR: Cka6/Cs8zMQOZzSN+Ff1v/PeqPC+CdpeKT+npnW0vWTZjoMSmxTLRO8cFTfFDP/5ocdUg7lEUd
 j+V0t0A24opw==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="233127839"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="233127839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 09:31:35 -0800
IronPort-SDR: laVkgpYBrrbSF+dd9nT4/ruCDFuBdYQ3BLkrNywawk3o/aSSvh57EKAwCOrTsLZV/sdtKjJw70
 HvHb8DjenAxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369236769"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2020 09:31:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 09:31:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 09:31:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 20 Nov 2020 09:31:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 20 Nov 2020 09:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYbUM+Rye9oLDZfSPgsceNQbZd7aQ5E/U/vmZ0kRmZbGUbK02A5esRxgmvtLIw2a6z2iv6X/tfGEb4raj7NkynfGoKuCC0+2EZ3AIBIMaeo3qif9VJMNEEgMyZZLMhL1xP1gU89EZPWO8OpeohOqbP3DwSURVoxNL87UsQl5uEqMuVGu+dAn2JZcn0J8FQi5OaspJflhE1N7hQqnHDAHpAtDQn1higwNxE04D0P7h5Y2SQE62jQ4FPeiDXdbTaVW+893MM57v3GHefK9Z3o+KKDl3h7kVIzvo1y3pw66BfeC8FswBfBZiIBTEW359H9UDifhY/IrmSGyNyQN7rRrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy8qHTDX7cfCbH9tHmS956pv+wqOm1GXtZbb7tDjvbQ=;
 b=IVFFMZ9yBcFPNrZBd00V7jWNeGc9iCvfmCE3zTuQew+r6gpdeLBtxBCwwOGGl3pvO9ASdnYUdFWC7YK2zz2ZlTwCCKwfbODq6HLmBnFXeTu9X1C7yJi4GdAxlHrS/R3vH0R9yokd/aWSDEYVW2DO/XUOjyEtMqK4evAUhg4M7l3VGxgNAx3nzVwSBZNvL0wgasn6efCfs0TDn1B8pkjFpRNIqGbzzHDhgypfjCn22ScFdXr1QtVbSXbzzo1g2CFulmUl7pReQ2HnJ0tZi4JOdIU+bCULXSgcSoFhMx6eJwUT5EstfYim0Wd2pI4N1RnAu1jd7KE/2m9orZpBZO+ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy8qHTDX7cfCbH9tHmS956pv+wqOm1GXtZbb7tDjvbQ=;
 b=s++lPtinsvelbH6hvI2XeMS5NWV2X37duxbbKvV9yW+UjxW+Y12Fd1IMxSBvUknf9Vr1S5mHeNYNQUiFxBKZWicikKDCZYFig2lHc3nSEp5bcOa1I3cyHzLZCAM2wW7u+QB39wGeit2ZWUpFmDvuQMT9IKPwuhaSYzr7E65gV/8=
Received: from MN2PR11MB4158.namprd11.prod.outlook.com (2603:10b6:208:155::14)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 17:31:33 +0000
Received: from MN2PR11MB4158.namprd11.prod.outlook.com
 ([fe80::7c1f:8c42:4ed6:240e]) by MN2PR11MB4158.namprd11.prod.outlook.com
 ([fe80::7c1f:8c42:4ed6:240e%3]) with mapi id 15.20.3589.025; Fri, 20 Nov 2020
 17:31:32 +0000
From:   "Paoloni, Gabriele" <gabriele.paoloni@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
Subject: RE: [PATCH 1/4] x86/mce: do not overwrite no_way_out if mce_end()
 fails
Thread-Topic: [PATCH 1/4] x86/mce: do not overwrite no_way_out if mce_end()
 fails
Thread-Index: AQHWvb2/GqMi8MuYvESX6RxO6efbtqnRQ8+AgAACm8A=
Date:   Fri, 20 Nov 2020 17:31:32 +0000
Message-ID: <MN2PR11MB4158BE8B738CF6F6BF9B850D88FF0@MN2PR11MB4158.namprd11.prod.outlook.com>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-2-gabriele.paoloni@intel.com>
 <20201120170737.GD712@zn.tnic>
In-Reply-To: <20201120170737.GD712@zn.tnic>
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
x-ms-office365-filtering-correlation-id: bf2c912d-baef-413f-541d-08d88d7a1fac
x-ms-traffictypediagnostic: MN2PR11MB4517:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB451724750B5B86582AF06FEA88FF0@MN2PR11MB4517.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+d0ZbFJbZr3yWNkz+IyMLTa+F9qK1hUp8JNobfgQfz20lVAb3BvtD9dgwVOB5NJskkkNLARQ34+mypM4DB4ZJF1r9rJuadWL2X3nUG2xYvbxA8iFT7kTQnJ16+jwN+piBoC0P1yGRgjI5JiVOov+5ja1rkmq0YLFtxSyi+yrVB+TjN60wO7JxCCYF8yuf/4P7PeITxPZXFOFPmitrtO//1ixUDGW3RKJuds2FQH5ib6iopvXYRbNQVfrRttLXi34K5cfKsGKzXXFuSwOrPbZQmrD1GV5dTJSN7NL74yyGxM+kxhhcX43Ja9vZ4N718DSq+ibT+7ZM7w0LM9+ZQq+I3ETqHbpUb3z2xwQ3DSV0YXTF2IXUIV3yiG5dWIz27vBISqUeMqFY12nV8i1yjSKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4158.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(8936002)(478600001)(966005)(86362001)(8676002)(33656002)(55016002)(9686003)(6916009)(4326008)(6506007)(53546011)(186003)(26005)(2906002)(7696005)(52536014)(5660300002)(54906003)(71200400001)(83380400001)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cxR5zQLKslTViQZXIPwNGshbj/i559ib6bvqvc45GGsfOL1S+2zwffXnWsEDvIKadHvFwDmOyVR9l15qkaX5auVEyly/lCzmKlJ5xuJNI2GJdJ+CEXHR7ehKou8loEPCFIJbK12vLuRBZn/uHTqtcrahP5O0EVL3LEzYP5NiG9vyWyS/lFYwvB/Qve15w93ZKl1oYlXbV+cnfCchc19YG9z4AM8L49Ditnwh87K+TuDLYQK7+5/jxCfNLHTsjcQkQxPKxpleDzMJ6+FMDD/P3qS4hppiOAlT5Co9HfryV9pS1aILVY9bHAKCHnMiVHI5HTeZ1UqPn73KvwXpzvlsoi6ZT0/dOiuY4SndOpUsJNvhCv73y+wmtJyRAz1VIMpE8SSKZ11G78xtLbx4c2ns7XX6Dy+tnPvUf5BzzGbqxoUyRT4qLrB2jb4UHSFLYciUnrO7IraItcUu0wLAOIKSl9rMIDVzyiudKFeF4vkNpfUMmfufsYRdrjBbZEx/kcTXTsAHl76wA5AK9JPclC+XDAzoe+15l7wuASWUlm3GOle3qb/ko12vBnPh/S2OUEnYuE1TGBp+YhodgI6NAVMrBE+6Mc6gP8pYOYQa4e9WlGldi7VN+vNmHT8l7tpzXWo+zicJE7tsSH0H4EDl2XmChmfbIcNB0Al7FNsPaulKLoot5jp5+TAhTO7KB8XxNH2fc/FF/HoJ3WjCaMvuHy0I0+RbqO9QkjqV7Bomb6GeBPzQDjBai+iuSqfvA9dYXyRN3jfKsBzmhEOxiAq1qFpc4FYFmIJ6pr73aaae3cFLW1YJLpfftc9KW9PGFc6n20h15r42OuQHbdkhJYjb7S9dP+bjXpK2/Vd84chqNhw+SUD7h8b5d3G5x/eGKotVknzKrYg0G/37dghU5fCtmbM3kw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4158.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2c912d-baef-413f-541d-08d88d7a1fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 17:31:32.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQB5hODJ+neXvYCPqjdmLQwWovo/cGp0utyCSICYdT+6Sg8DKNAjkyW65UfU1gzqZUbEbKcXAsEwvbG+p5z97EG6Sfs9DN1jSR5XphsEcUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xh
diBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyMCwgMjAy
MCA2OjA4IFBNDQo+IFRvOiBQYW9sb25pLCBHYWJyaWVsZSA8Z2FicmllbGUucGFvbG9uaUBpbnRl
bC5jb20+DQo+IENjOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgdGdseEBsaW51
dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29tOyB4ODZAa2VybmVsLm9yZzsgaHBhQHp5dG9y
LmNvbTsgbGludXgtDQo+IGVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gc2FmZXR5QGxpc3RzLmVsaXNhLnRlY2gNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzRdIHg4Ni9tY2U6IGRvIG5vdCBvdmVyd3JpdGUgbm9fd2F5X291dCBpZg0K
PiBtY2VfZW5kKCkgZmFpbHMNCj4gDQo+IE9uIFdlZCwgTm92IDE4LCAyMDIwIGF0IDAzOjE1OjQ5
UE0gKzAwMDAsIEdhYnJpZWxlIFBhb2xvbmkgd3JvdGU6DQo+ID4gQ3VycmVudGx5IGlmIG1jZV9l
bmQoKSBmYWlscyBub193YXlfb3V0IGlzIHNldCBlcXVhbCB0byB3b3JzdC4NCj4gPiB3b3JzdCBp
cyB0aGUgd29yc3Qgc2V2ZXJpcnR5IHRoYXQgd2FzIGZvdW5kIGluIHRoZSBNQ0EgYmFua3MNCj4g
CQkgICAgIF5eXl5eXl5eXg0KPiANCj4gUGxlYXNlIGludHJvZHVjZSBhIHNwZWxsY2hlY2tlciBp
bnRvIHlvdXIgcGF0Y2ggY3JlYXRpb24gd29ya2Zsb3cuDQo+IA0KPiA+IGFzc29jaWF0ZWQgdG8g
dGhlIGN1cnJlbnQgQ1BVOyBob3dldmVyIGF0IHRoaXMgcG9pbnQgbm9fd2F5X291dA0KPiAJICAg
ICBeDQo+IAkgICAgIHdpdGgNCj4gDQo+IA0KPiA+IGNvdWxkIGJlIGFscmVhZHkgc2V0IGJ5IG1j
YV9zdGFydCgpIGJ5IGxvb2tpbmcgYXQgYWxsIHNldmVyaXRpZXMNCj4gDQo+IEkgdGhpbmsgeW91
IG1lYW4gImNvdWxkIGhhdmUgYmVlbiBhbHJlYWR5IHNldCIgaGVyZQ0KPiANCj4gPiBvZiBhbGwg
Q1BVcyB0aGF0IGVudGVyZWQgdGhlIE1DRSBoYW5kbGVyLg0KPiA+IGlmIG1jZV9lbmQoKSBmYWls
cyB3ZSBmaXJzdCBjaGVjayBpZiBub193YXlfb3V0IGlzIGFscmVhZHkgc2V0IGFuZA0KPiANCj4g
UGxlYXNlIHVzZSBwYXNzaXZlIHZvaWNlIGluIHlvdXIgY29tbWl0IG1lc3NhZ2U6IG5vICJ3ZSIg
b3IgIkkiLCBldGMuDQo+IA0KPiBBbHNvLCBwbHMgc3RhcnQgbmV3IHNlbnRlbmNlcyB3aXRoIGEg
Y2FwaXRhbCBsZXR0ZXIgYW5kIGVuZCB0aGVtIHdpdGggYQ0KPiBmdWxsc3RvcC4NCg0KU29ycnkg
YWJvdXQgdGhlIGdyYW1tYXIgZXJyb3JzIGFib3ZlLCBJJ2xsIHBheSBtb3JlIGF0dGVudGlvbiBp
biBmdXR1cmUNCg0KPiANCj4gPiBpZiBzbyB3ZSBzdGljayB0byBpdCwgb3RoZXJ3aXNlIHdlIHVz
ZSB0aGUgbG9jYWwgd29yc3QgdmFsdWUNCj4gDQo+IFNvIGJhc2ljYWxseSB5b3UncmUgdHJ5aW5n
IHRvIHNheSBoZXJlIHRoYXQgbm9fd2F5X291dCBtaWdodCBoYXZlIGJlZW4NCj4gYWxyZWFkeSBz
ZXQgYW5kIG90aGVyIENQVXMgY291bGQgb3ZlcndyaXRlIGl0IGFuZCB0aGF0IHNob3VsZCBub3QN
Cj4gaGFwcGVuLg0KPiANCj4gSXMgdGhhdCB3aGF0IHlvdSBtZWFuPw0KDQpJIG1lYW4gdGhhdCBv
biB0aGlzIENQVSB0aHJlYWQgYXQgdGhpcyBwb2ludCBtY2Vfc3RhcnQoKSBhbHJlYWR5IGNhY2hl
ZA0KZ2xvYmFsX253byBhbmQgaGVuY2UgY291bGQgYWNjdW11bGF0ZSBmYXRhbCBzZXZlcml0aWVz
IG9mIG90aGVyIENQVXMuDQoNCk5vdyBoZXJlIGlmIG1jZV9lbmQoKSBmYWlscyB3ZSBvbmx5IGNv
bnNpZGVyIHRoZSBsb2NhbCAnd29yc3QnIHNldmVyaXR5DQphbmQgd2Ugb3ZlcndyaXRlIHRob3Nl
IGFscmVhZHkgY2FjaGVkLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEdhYnJpZWxlIFBhb2xv
bmkgPGdhYnJpZWxlLnBhb2xvbmlAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBUb255IEx1
Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9j
cHUvbWNlL2NvcmUuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvY29yZS5jDQo+IGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+ID4gaW5k
ZXggNDEwMmI4NjZlN2MwLi5iOTkwODkyYzY3NjYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvY29yZS5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
Y29yZS5jDQo+ID4gQEAgLTEzODUsNyArMTM4NSw3IEBAIG5vaW5zdHIgdm9pZCBkb19tYWNoaW5l
X2NoZWNrKHN0cnVjdCBwdF9yZWdzDQo+ICpyZWdzKQ0KPiA+ICAJICovDQo+ID4gIAlpZiAoIWxt
Y2UpIHsNCj4gPiAgCQlpZiAobWNlX2VuZChvcmRlcikgPCAwKQ0KPiA+IC0JCQlub193YXlfb3V0
ID0gd29yc3QgPj0gTUNFX1BBTklDX1NFVkVSSVRZOw0KPiA+ICsJCQlub193YXlfb3V0ID0gbm9f
d2F5X291dCA/IG5vX3dheV9vdXQgOiB3b3JzdCA+PQ0KPiBNQ0VfUEFOSUNfU0VWRVJJVFk7DQo+
IA0KPiBJIGhhZCB0byBzdGFyZSBhdCB0aGlzIGEgYml0IHRvIGZpZ3VyZSBvdXQgd2hhdCB5b3Un
cmUgZG9pbmcuIFNvIGhvdw0KPiBhYm91dCBzaW1wbGlmeWluZyB0aGlzOg0KPiANCj4gCQkJaWYg
KCFub193YXlfb3V0KQ0KPiAJCQkJbm9fd2F5X291dCA9IHdvcnN0ID49DQoNClllcyB0aGF0IHdv
cmtzIGFzIHdlbGwgaW1wcm92aW5nIHJlYWRhYmlsaXR5Lg0KDQpJZiBvayBJIHdpbGwgZml4IHRo
ZSBncmFtbWFyIGFuZCByZXdyaXRlIHRoaXMgY29kZSBpbiB2Mi4NCg0KTWFueSBUaGFua3MNCkdh
Yg0KDQo+IE1DRV9QQU5JQ19TRVZFUklUWTsNCj4gDQo+ID8NCj4gDQo+IFRoeC4NCj4gDQo+IC0t
DQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtl
cm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSU5URUwg
Q09SUE9SQVRJT04gSVRBTElBIFMucC5BLiBjb24gdW5pY28gc29jaW8KU2VkZTogTWlsYW5vZmlv
cmkgUGFsYXp6byBFIDQgCkNBUCAyMDA5NCBBc3NhZ28gKE1JKQpDYXBpdGFsZSBTb2NpYWxlIEV1
cm8gMTA0LjAwMCwwMCBpbnRlcmFtZW50ZSB2ZXJzYXRvClBhcnRpdGEgSS5WLkEuIGUgQ29kaWNl
IEZpc2NhbGUgIDA0MjM2NzYwMTU1ClJlcGVydG9yaW8gRWNvbm9taWNvIEFtbWluaXN0cmF0aXZv
IG4uIDk5NzEyNCAKUmVnaXN0cm8gZGVsbGUgSW1wcmVzZSBkaSBNaWxhbm8gbnIuIDE4Mzk4My81
MjgxLzMzClNvZ2dldHRhIGFkIGF0dGl2aXRhJyBkaSBkaXJlemlvbmUgZSBjb29yZGluYW1lbnRv
IGRpIApJTlRFTCBDT1JQT1JBVElPTiwgVVNBCgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUgdXNlIG9m
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uCmJ5
IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQKcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNv
cGllcy4K

