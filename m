Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8061D19ED9F
	for <lists+linux-edac@lfdr.de>; Sun,  5 Apr 2020 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDET0H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 5 Apr 2020 15:26:07 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:51577 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgDET0G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 5 Apr 2020 15:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1964; q=dns/txt; s=iport;
  t=1586114765; x=1587324365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WXgpscTcRWeEhKqFXVKYpzOzqXgkbB2jj9f8HNO+BbI=;
  b=YlfKTgLkT5KfiAecLb+bQHolTKnRkJ9yGFI+QXcz6CY1ONiWWrx5CF/w
   fZB/m7qrggf+UvAmipEVwI7dSDTdN0Vrhkc2AQrKArPyt4eA8Kxvibgmh
   tB2B8HAK+NQEqtXIkN18oZz7sP4nqXtj0nIqrAFN6kFTFT6594gtQsK4x
   k=;
IronPort-PHdr: =?us-ascii?q?9a23=3AC2I/PRKDi4lzpaWHKNmcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeBvKd2lFGcW4Ld5roEkOfQv636EU04qZea+DFnEtRXUg?=
 =?us-ascii?q?Mdz8AfngguGsmAXEjyKvfxbzE5NM9DT1RiuXq8NBsdFQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DVAQAHMIpe/5ldJa1mHAEBAQEBBwE?=
 =?us-ascii?q?BEQEEBAEBgWoEAQELAYFTUAWBRCAECyoKhBGDRQOKZU6CEZgeglIDVAoBAQE?=
 =?us-ascii?q?MAQEtAgQBAYFQgnQCF4IvJDcGDgIDAQELAQEFAQEBAgEFBG2FVgyFcAEBAQE?=
 =?us-ascii?q?CARIRBA0MAQE3AQQLAgEGAg4KAgImAgICMBUQAgQOBRsHgwSCTAMOHwEBk1C?=
 =?us-ascii?q?QZwKBOYhidX8zgn8BAQWFPRiCDQkUeioBjDIagUE/gREnHIJNPoROF4J7MoI?=
 =?us-ascii?q?skEk7oB4Kgj2XKh2CTog4kHyrXAIEAgQFAg4BAQWBaCOBV3AVZQGCPlAYDY4?=
 =?us-ascii?q?dg3OKVXSBKY0cAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.72,348,1580774400"; 
   d="scan'208";a="741810511"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 Apr 2020 19:26:05 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 035JQ5Bj027985
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 Apr 2020 19:26:05 GMT
Received: from xhs-aln-002.cisco.com (173.37.135.119) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 5 Apr
 2020 14:26:05 -0500
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by xhs-aln-002.cisco.com
 (173.37.135.119) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 5 Apr
 2020 14:26:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-001.cisco.com (64.101.210.228) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 5 Apr 2020 15:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOUVTxouxx1nhw9uf2RChf+OIkDsvg0sLLW+OOeQsO+AN4Ew41d5tjyNcijwa46/ieKcZh6ygwaJQmjJJTn9JW8bGIfRQy21asyj58ZxsksgR6iQUZJVKWVBfsEuBNhICp8SommjCxPUct9T4TqBIuW5xS0SW4vmKegma5rjsEVfnv3M5aDIMq4OQL2XxAthXZvwZberi89LF8R8D3SPo/1JAOjkJtgBNjtyp2KZ4qUxNJRgkVHajp2Gt4ONCLYC8AJ1EWS62m4oZioZYdAE+j1mALj1IEGby2DtNCEwYGI0ii6YByAzCEaXIcLLh+zOKDAivtYkV0YyG7qquWSLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXgpscTcRWeEhKqFXVKYpzOzqXgkbB2jj9f8HNO+BbI=;
 b=AVWlM8/Eq5KfQ7X8UV/sY1b3+PF+2xBI1XfA77l8Rx600uRAKEZmpOlsiUZonNE0TfE+WcuQ0wbwA7i6lhNrhWRiYnRleaEc4GIPdgfSNvRJVPguAYFKrZy7HCqinpy4Gyc+hOBkiPAHXy+kgdjVuBO8m6dqKo/c1aCd+vAknthgdfld9zICimOdZ6axXrKI3nGKukiYdI/NyHPPSF8wxB7/v6W1XGLSpaKvYNf5RI53YMOsC56ZS05Xfo0iIf8k6S5FP97vMfv1ijXDqeTNVv4o1cuxRfC3Z2L2KOuM5lM1ikGc+4Gs15d42xR4x0KtiBsIQdeePk4+ftAwSkAiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXgpscTcRWeEhKqFXVKYpzOzqXgkbB2jj9f8HNO+BbI=;
 b=nyj8HAUjIseQ6JUvvDdc+kee449mO+tnKMGrlQX5HKl/nDIp0p0MGOp1AIcxQKFqQDzo/UkeaOzc2G9pDBh2AHb7AJHInEs1gngqCn2Kaq2YcL+hlKBcHgGO8mmksZ4OEnd9Kl2DSAi7hflII+4zPoef1yIR94qb0+TJ2X9OrjU=
Received: from DM6PR11MB2539.namprd11.prod.outlook.com (2603:10b6:5:bf::30) by
 DM6PR11MB4491.namprd11.prod.outlook.com (2603:10b6:5:204::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Sun, 5 Apr 2020 19:26:02 +0000
Received: from DM6PR11MB2539.namprd11.prod.outlook.com
 ([fe80::805b:a037:1a5a:362a]) by DM6PR11MB2539.namprd11.prod.outlook.com
 ([fe80::805b:a037:1a5a:362a%4]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 19:26:02 +0000
From:   "Manali Shukla (manashuk)" <manashuk@cisco.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Aristeu Rozanski Filho" <arozansk@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Russ Anderson <rja@hpe.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Thread-Topic: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Thread-Index: AQHV+C49gAe7MhzwwUqG/ujZrWDTQahMm6eAgB64nID//6UfgIAAcogA
Date:   Sun, 5 Apr 2020 19:26:01 +0000
Message-ID: <994FAF5C-B773-4B09-8C08-91E22ECDB8A9@cisco.com>
References: <20200312052201.49456-1-manashuk@cisco.com>
 <20200317102249.GC1130294@kroah.com>
 <5D56C6A7-B076-47BB-9016-7BD54DFE71E7@cisco.com>
 <20200405180605.GC17324@zn.tnic>
In-Reply-To: <20200405180605.GC17324@zn.tnic>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.35.20030802
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=manashuk@cisco.com; 
x-originating-ip: [171.76.93.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec25555b-9e8f-4f69-769f-08d7d9972d69
x-ms-traffictypediagnostic: DM6PR11MB4491:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4491FF3D14670E17104E33C6C6C50@DM6PR11MB4491.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03648EFF89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(6512007)(2616005)(186003)(8676002)(86362001)(81166006)(4326008)(81156014)(33656002)(2906002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(91956017)(54906003)(5660300002)(6916009)(53546011)(6506007)(36756003)(71200400001)(26005)(8936002)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtktHPUVGsazmW6mE1OirbufZp7x1WPG9Ih1zLYah88LotItCkyr0rrmk/+A4zbiUsYj6A/KBg1Itt/Cf2uHAhHhLg2j3ZsN3nqw6F1PZfg+CWrHQpJasXshR1cuBXpbyLeMNXd0lSv6fSoHUJzRPQMDCpxUwDVumGbRDTxeOcY8HNjvIlKZRHksPiZV6lzncTimmca5CpOa47F1sXSkDoV83PYrx0BmSr41qM/dfjSCqTHUvAjHoNA1FlEPazWQxHKCVStUj/2YgB3K23bS+KoRiD+XFk6l++jROhlF+cn7WzJ1YeLgSLBx5+GbdCb0bD9To36tbaSkSwHGhgcJlFtW5gHW7foG5qI/Ot9JDMNq6Iulc4WHIeFkUagsxAHpwgGJJHDwodQ4s66Ita9m0q1oMQIZfI2nmh13h4kVGHk0b52br+mY80cN0DN0DDZH
x-ms-exchange-antispam-messagedata: Z3GyVKjr6SciD8Wmxf7LX51OT4N5tP3LuCu+iv0gQhgtj7Cmr8Dpaa/MvqiVExJsQ19cx6iaR7WcVJwrqBl0Oub1ZJr26rJFx0jQODJSTD/yBAfPJpgaOqV1uNg20bIPyqaPTJ+qYKp9nmEOpbjIJw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1BE35C63ACB224D84B607E2697196AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec25555b-9e8f-4f69-769f-08d7d9972d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2020 19:26:01.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZpICnhqr62LJ3VVxpozJLINKLkFZ9+1jMQL1PtMmt+ibZXb9NKssSm1/mZt66EXqV65cNUJzr6OxLg2YS9YEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4491
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBPbiAwNS8wNC8yMCwgMTE6MzYgUE0sICJCb3Jpc2xhdiBQZXRrb3YiIDxicEBzdXNlLmRlPiB3
cm90ZToNCg0KPiAgICBPbiBTdW4sIEFwciAwNSwgMjAyMCBhdCAwNjowMToyMVBNICswMDAwLCBN
YW5hbGkgU2h1a2xhIChtYW5hc2h1aykgd3JvdGU6DQo+PiBXaXRoIHRoaXMgcGF0Y2ggLCB3ZSBh
cmUgcmVtb3ZpbmcgcGVyLU1DIGJ1cywgdGhpcyByZW1vdmVzIGRlcGVuZGVuY3kgb24gdmFsdWUg
b2YgbWF4IG51bWJlciBvZiBjb250cm9sbGVycyAoRURBQ19NQVhfTUNTKSB3aGljaCBpcyBoYXJk
Y29kZWQgdG8gMiAqIE1BWF9OVU1OT0RFUyAgaW4gYWxsIHN0YWJsZSB2ZXJzaW9ucyBvZiBrZXJu
ZWwuIA0KID4+IE9uIHR3byBub2RlcyBzeXN0ZW0gTUFYX05VTU5PREVTIHZhbHVlIGlzIOKAmDHi
gJkgLCBzbyB2YWx1ZSBvZiBtYXggbnVtYmVyIG9mIG1lbW9yeSBjb250cm9sbGVyIGJlY29tZXMg
4oCYMuKAmSwgdGhpcyBwYXRjaCBmaXhlcyB0aGlzIGlzc3VlIHdoZW4gdGhlcmUgYXJlIG9ubHkg
MiBub2RlcyBvbiB0aGUgc3lzdGVtIGFuZCBudW1iZXIgb2YgbWVtb3J5IGNvbnRyb2xsZXJzIGFy
ZSBtb3JlIHRoYW4g4oCYMicNCiAgICANCiA+IFlvdSBiYXNpY2FsbHkgcmVwZWF0ZWQgd2hhdCB5
b3UgaGFkIHdyaXR0ZW4gYWxyZWFkeS4NCiAgICANCiA+ICBCdXQgd2hhdCBpcyB0aGlzIGZpeGlu
Zz8gU29tZSBwbGF0Zm9ybSBvZiB5b3VycyBvciB3aGF0PyBXaHkgZG9lcyBpdA0KID4gbmVlZCB0
byBnbyB0byBzdGFibGU/DQogICAgDQpDZXJ0YWluIE1JUFMgcGxhdGZvcm0gY2FuIGhhdmUgMiBu
b2RlcyBhbmQgbnVtYmVyIG9mIG1lbW9yeSBjb250cm9sbGVycyBjYW4gYmUgbW9yZSB0aGFuICcy
JyAuDQoNCmZvciBhYm92ZSBjb25kaXRpb24sIGlmDQojZGVmaW5lIEVEQUNfTUFYX01DUyAyICog
TUFYX05VTU5PREVTLA0KaXQgZmFpbHMgaW4gdGhpcyBmdW5jdGlvbiBlZGFjX21jX2FkZF9tY193
aXRoX2dyb3Vwcw0KaW4gYmVsb3cgY29uZGl0aW9uDQppZiAobWNpLT5tY19pZHggPj0gRURBQ19N
QVhfTUNTKSB7DQpwcl93YXJuX29uY2UoIlRvbyBtYW55IG1lbW9yeSBjb250cm9sbGVyczogJWRc
biIsIG1jaS0+bWNfaWR4KTsNCnJldHVybiAtRU5PREVWOw0KfQ0KVGhhdCBpcyB3aHkgdGhpcyBm
aXggaXMgbmVlZGVkLg0KDQogPiAgQnR3LCBwbGVhc2UgZG8gbm90IHRvcC1wb3N0IGFuZCByZXBs
eSB1bmRlciB0aGUgcXVvdGVkIHRleHQgbGlrZSBhbGwgb2YNCiA+IHVzIGRvLg0KICAgIA0KID4g
VGh4Lg0KICAgIA0KICAgIC0tIA0KID4gIFJlZ2FyZHMvR3J1c3MsDQogPiAgIEJvcmlzLg0KICAg
IA0KID4gIFNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgR0Y6IEZlbGl4IElt
ZW5kw7ZyZmZlciwgSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcNCg0KVGhhbmtzIA0KTWFuYWxpDQog
ICAgDQoNCg==
