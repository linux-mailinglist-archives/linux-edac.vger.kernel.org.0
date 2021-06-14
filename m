Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA43A71E3
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFNW1m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Jun 2021 18:27:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:47951 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhFNW1m (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Jun 2021 18:27:42 -0400
IronPort-SDR: 0od/GL/+NNiRXXG9lTAO5nci3OhucSKjeS4FxvxorVyvkMJkdydE0DbfVPdNvv7JfWpriODw6c
 rtp3sx42hFMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="267036265"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="267036265"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 15:25:37 -0700
IronPort-SDR: f3cWHzUgT7jOHyd18r0lRpwulvZFohRS6R6d8U3a3GjP0mGiz8IX9Deg8m4O6CSPo1Ke9C6ZtZ
 iemaKmp/xt/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="471452825"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2021 15:25:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 14 Jun 2021 15:25:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 14 Jun 2021 15:25:37 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Mon, 14 Jun 2021 15:25:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        Robert Richter <rric@kernel.org>
Subject: RE: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Thread-Topic: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Thread-Index: AQHXYWNK3FqBHVBWmECrS7erxBQl9KsUhEiA//+OjFA=
Date:   Mon, 14 Jun 2021 22:25:36 +0000
Message-ID: <16a34b6834f94f139444c2ff172645e9@intel.com>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
In-Reply-To: <YMfRxX/M4rJ5gM/R@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBCdXQgYXBwYXJlbnRseSB0aG9zZSB3cm9uZyBlcnJvciBtZXNzYWdlcyBidWcgcGVvcGxlIG9u
IGEgcmVndWxhciBiYXNpcw0KPiBhbmQgSSdtIHRpcmVkIG9mIHR5cGluZyB0aGlzIGVhY2ggdGlt
ZSBzbyBJJ2xsIHRha2UgYSBkaWZmZXJlbnQgdmVyc2lvbg0KPiBvZiB0aGlzIHBhdGNoOiBjaGVj
ayBYODZfRkVBVFVSRV9IWVBFUlZJU09SIG9uIGVudHJ5IGluIG1jZV9hbWRfaW5pdCgpDQo+IGFu
ZCByZXR1cm4gLUVOT0RFViBpZiBzZXQuDQo+DQo+IFNvIHRoYXQgdGhpcyBpcyBkb25lIG9uY2Ug
YW5kIGZvciBhbGwuDQoNCkkgZXhwZWN0IGFsbCB0aGUgSW50ZWwgRURBQyBkcml2ZXJzIHRoYXQg
bG9hZCBiYXNlZCBvbiBDUFUgbW9kZWwgaGF2ZSBzaW1pbGFyDQppc3N1ZXMuIE1heWJlIHRoZXkg
YXJlbid0IHdoaW5pbmcgYXMgbG91ZGx5IGFib3V0IG5vdCBiZWluZyBhYmxlIHRvIGZpbmQgdGhl
DQptZW1vcnkgY29udHJvbGxlciBkZXZpY2VzPw0KDQpUaGV5IHNob3VsZCBhbHNvIGNoZWNrIGZv
ciBYODZfRkVBVFVSRV9IWVBFUlZJU09SIHRvby4NCg0KJCBnaXQgZ3JlcCAtbCB4ODZfbWF0Y2hf
Y3B1IC0tIGRyaXZlcnMvZWRhYw0KZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KZHJpdmVycy9l
ZGFjL2kxMG5tX2Jhc2UuYw0KZHJpdmVycy9lZGFjL2llaF9lZGFjLmMNCmRyaXZlcnMvZWRhYy9w
bmQyX2VkYWMuYw0KZHJpdmVycy9lZGFjL3NiX2VkYWMuYw0KZHJpdmVycy9lZGFjL3NreF9iYXNl
LmMNCg0KVGhvdWdoIHBlcmhhcHMgdGhpcyBpcyBhbiBpc3N1ZSBvdXRzaWRlIG9mIEVEQUMgYW5k
IHg4Nl9tYXRjaF9jcHUoKQ0KY291bGQgZG8gdGhlIEhZUEVSVklTT1IgY2hlY2sgYW5kIHJldHVy
biBubyBtYXRjaC4gVGhlIGZldyBjYWxsZXJzDQp3aG8gd2FudCB0byBiZWxpZXZlIHRoZSBmaWN0
aW9uYWwgQ1BVIG1vZGVsIG51bWJlciBwYXNzZWQgaW4gYnkgdGhlDQpWTU0gd291bGQgbmVlZCB0
byB1c2Ugc29tZSBuZXcgdmFyaWFudCBvZiB0aGUgY2FsbD8NCg0KLVRvbnkNCg0KDQo=
