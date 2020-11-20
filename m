Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B01D2BB189
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgKTRfH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 12:35:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:52901 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbgKTRfG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Nov 2020 12:35:06 -0500
IronPort-SDR: keUlF9dhT45VtbUqGYDC1Jd1ar3Ye+WfZE9utTujULwgyqF+HHS8Z8rND/dVAzN0wPnktqdFT5
 9LS2v1kpPV+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168940840"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168940840"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 09:35:06 -0800
IronPort-SDR: 4CSURNqtvZjjJYIH0nnyVB3O/KC0uJFnWquSbNIzZB1Rcd2T3U+gJDz4t+M/gf+ABjwHjQqQg+
 PyqEf6heCK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="533631946"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2020 09:35:05 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 09:35:05 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 09:35:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 20 Nov 2020 09:35:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 20 Nov 2020 09:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUnnHfDNs74CPaRZJ+wcqMZkx9czKP83FZ5AOZENbiG0j0erVU8QsY8lPC7vEMYFIhjYwFPagwijjRCBoTLp1H+gX/kNJEE7HqmgoYAr2cOo0zFVbBmkYBTEuCquvXuporsxnBj8zeSpuzure0EV9QtTcfPjJYo3CFpRfLBp9cCB+amTP7xYwBJ6oopmhS8FN2MehQkit7H39qaAApWWuHFUGJpkj/Hd9CkjqW5sMx+iH0sMQ8qsutW6xkPFi6jWl3+vM8ZCA9A5L4F1b2NSDEktDWOWH2eh/H8iicT+j79nc8g+BjBs74UMlEi6eBvauUV3rqCBdobbbJyH1kB2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS96ac70TdSRCnwkjbJuiPGTX+vHUOGd2JTO358fWes=;
 b=TWWBB5oJQ/3iiGebEUiDgty9AxzZfCIhZv8I1sb7AE+8+ffnDm2QbvMzxdlLfsK8xGH/a0aeNui+wbC4kCnTOE0XSVDWClilCcS1xy3++RpM01sur+xaiJ8VI4xt6BXDUdg/pwBMe7nsCMQeuENz8Gn3hlNF6pcpzPKqZskd2ltwdvjNeT6Y1U9zDx+fbGeYed8cAB60xN7IVrUbHRqKlxoPt/yzbFigwChtxj30n6Wusyal8WjZHHuEVxVLQDFAluJMBncRW2+02Y0LGlB23pZtrZIgMNmlhmSB3tgroAWPiOGnc9m6mMEPnK+v3yh0B43YNBtpVkJsv/3fvESSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS96ac70TdSRCnwkjbJuiPGTX+vHUOGd2JTO358fWes=;
 b=IqDHAdo3jk7oa3UlyZWjv2+QbdXPNNLUoC5ATnStsU5Xqq/gZMYGWiAUVwtWXYiMadj7YB/j9GO3cjjqLv+MpCgYhPZdq1gZsNofvbFx9PHMjB2R/MhdZ41Vyqya5Xnu6qar0LZvelWEgB+9znuD4pM0FYTiXPplXbPLEt/OOPc=
Received: from MN2PR11MB4158.namprd11.prod.outlook.com (2603:10b6:208:155::14)
 by MN2PR11MB3821.namprd11.prod.outlook.com (2603:10b6:208:f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 17:35:03 +0000
Received: from MN2PR11MB4158.namprd11.prod.outlook.com
 ([fe80::7c1f:8c42:4ed6:240e]) by MN2PR11MB4158.namprd11.prod.outlook.com
 ([fe80::7c1f:8c42:4ed6:240e%3]) with mapi id 15.20.3589.025; Fri, 20 Nov 2020
 17:35:03 +0000
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
Thread-Index: AQHWvb2/GqMi8MuYvESX6RxO6efbtqnRSrOAgAAAl/A=
Date:   Fri, 20 Nov 2020 17:35:03 +0000
Message-ID: <MN2PR11MB4158662CEA416C6B482D77B988FF0@MN2PR11MB4158.namprd11.prod.outlook.com>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-2-gabriele.paoloni@intel.com>
 <20201120173217.GE712@zn.tnic>
In-Reply-To: <20201120173217.GE712@zn.tnic>
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
x-ms-office365-filtering-correlation-id: c23c578a-ae78-4ff7-5773-08d88d7a9d21
x-ms-traffictypediagnostic: MN2PR11MB3821:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3821088261C7E7E4DC205F3988FF0@MN2PR11MB3821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lw0Q8V9ML+GVmrbzxmNcxiRH2aDD/+3hXU4tbq7rxPVvQXNWdYOBXskmL+BsX8aBTc0rKTUqJS7vJdLKnirooQkQJsZeJ1z+VW33JbUt2LG783Yjn7RQmhD/aCysIq/f3Zj52ELNN0e6rWJ5acfy1LgrP780UuNIxiib/c8jg1emfhnghPEGnbm8caSUTEBF3TUweqa0OplJ514ROXJFN9efCe51/rmX84QawDOw/GTYmJoq+AshL01x7ByqjFb9NgG3/zjbCCLYFKzAKlYHV2p7Zq0fHsN/21PiyXf+Wqv9BuEx03uzLtwxLxFQCDE3oKPcXlPFDBDgypXoEY0oYdEl+HVPGsy+TS7oYAvAVste0GRLGpwAAHaAphMLi2AR4ui6Ikqu8T75FW1ANz0xBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4158.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(55016002)(8676002)(66446008)(64756008)(5660300002)(52536014)(9686003)(2906002)(7696005)(33656002)(71200400001)(8936002)(558084003)(66476007)(66556008)(4326008)(66946007)(478600001)(6916009)(76116006)(86362001)(54906003)(26005)(966005)(6506007)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /mQXikNHHINfbqB/SsLHKHBqd7WMakRzQT1aRZxbwkvpyM0EfzhWEfDtq8sPG0l7utGCQkWIAb+HRu+v7SJRJaMn6IAPYOG8bZ3RvxqRG30hIO2278EB6EhM5ksjKcTh5KpTZ3fb96EcHdwYjCVeymv+z1rbTmLVqWFs6ULuCCHMR9tMlGv6s8FBd7fiZ4mKBoJOCMV9Ixdcy22XKM7fKIY+4O16dKmxwuZQJcQ8yL59oJnxdJtYZ41w6gZSiXKKATXRpiyyCbZU0PQVFPnssN/TN1vwWLzNHmSZMWEBG021E2v7vEfyk2fPL8IjWgBmrYE7PzYilxPYM2IMpdgf6Jw7a9qvUCotscIzbzoZwLzgw53xMueMtNTFicGGUtdL3LOKGqu2rSjGqq802HGz/iu7zWWVDR3EnU5TMNyl9sDT2oyp8vAtjOl0LF2D/oCXkZIgLqeUPXIXI2yWjskHH7wMrSwAWZ/EjMUzBuUas946fkTMYVPHgmuXjo77/fUEjK9kfDXQX59o9cQEDqEA7sIajLOB9fCIa4YoCm3+JzTYV4TfaJElTZsfoX9Htze3tKNwZsBT7SrPVkgkdHzvsYkH67gBHFnORqDRzWcwkNQ7l+Ejvx8Tew4DJYZ3UadCtOihowscr/xkETiu2W9WSKbHMk11/GuLwvMJmFOA/MlViEiHR2ul+cGzR00Pcs4lv8X6pFabq815u3JDTO52O5FxFGvOUdVi+m4J6S+mnnJFOdnlPi8qFawztLeCORCBonvWvSJGSixPgz7+KpvsiKBbzIgFKrGJ7gUuukbTExlCuizj6uxnbALNF0W1RfokAjAhwtJ2H5fn1izIUw/3LxpPrH7YCKZFqWoPjEzL7pgKa7Zo7LRuG5MFDhbRAeZNEijx+0FcoZfH/J2JPEkwZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4158.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23c578a-ae78-4ff7-5773-08d88d7a9d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 17:35:03.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R54GXpU6RrJBWGCVBKz5kil0FiDhxemFtuwUb8bWfGQU2PoouTKtfeeU+iEH7VTsnZ7ay+fWSfcN7cCGif9zku+sIFF6p9Z/69DuT/JT81w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3821
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Wy4uLl0NCg0KPiBBbHNvLCB0aGlzIHZlcnkgbGlrZWx5IHdhbnRzIENjOiBzdGFibGUsIEknZCBz
YXksIGNvbnNpZGVyaW5nIHRoZQ0KPiBzZXZlcml0eS4NCg0KU3VyZSwgd2lsbCBhZGQgc3RhYmxl
IGluIHYyLg0KDQpUaGFua3MNCkdhYg0KDQo+IA0KPiBUaHguDQo+IA0KPiAtLQ0KPiBSZWdhcmRz
L0dydXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3Rn
bHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCklOVEVMIENPUlBPUkFUSU9O
IElUQUxJQSBTLnAuQS4gY29uIHVuaWNvIHNvY2lvClNlZGU6IE1pbGFub2Zpb3JpIFBhbGF6em8g
RSA0IApDQVAgMjAwOTQgQXNzYWdvIChNSSkKQ2FwaXRhbGUgU29jaWFsZSBFdXJvIDEwNC4wMDAs
MDAgaW50ZXJhbWVudGUgdmVyc2F0bwpQYXJ0aXRhIEkuVi5BLiBlIENvZGljZSBGaXNjYWxlICAw
NDIzNjc2MDE1NQpSZXBlcnRvcmlvIEVjb25vbWljbyBBbW1pbmlzdHJhdGl2byBuLiA5OTcxMjQg
ClJlZ2lzdHJvIGRlbGxlIEltcHJlc2UgZGkgTWlsYW5vIG5yLiAxODM5ODMvNTI4MS8zMwpTb2dn
ZXR0YSBhZCBhdHRpdml0YScgZGkgZGlyZXppb25lIGUgY29vcmRpbmFtZW50byBkaSAKSU5URUwg
Q09SUE9SQVRJT04sIFVTQQoKVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29u
dGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yCnRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbgpieSBvdGhlcnMgaXMg
c3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkCnJlY2lwaWVu
dCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuCg==

