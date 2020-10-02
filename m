Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855F7281764
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgJBQES (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 12:04:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:35080 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBQES (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 12:04:18 -0400
IronPort-SDR: LecBRMnfDShrs0Qa9uYUtkWGVDoKfWhYgcoZT+xovqSFLdrHijHYqLjddY8ES34bGmPkl2gBCd
 5gfDaIuJVO2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="143012882"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="143012882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 09:04:15 -0700
IronPort-SDR: udVJL/X8/W+sS40VxCA/bJb7m+t4hkrhV5lr5F50i8cJL4nqY/4BpWyu9Ine+j38JpOzbwq5K5
 eO+Bl6j/sG3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="294879708"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2020 09:04:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 2 Oct 2020 09:04:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 2 Oct 2020 09:04:13 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Fri, 2 Oct 2020 09:04:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
Thread-Topic: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
Thread-Index: AQHWmLdSoSVhEXUwu0K9roIwfCS2WamEt0cA///Ax6A=
Date:   Fri, 2 Oct 2020 16:04:11 +0000
Message-ID: <fd12bc3222784e06bb5b0ca1d1f1e1ae@intel.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
 <20201002124352.GC17436@zn.tnic>
In-Reply-To: <20201002124352.GC17436@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBCZWNhdXNlIGZyb20gbXkgeDg2IENQVXMgbGltaXRlZCBleHBlcmllbmNlLCB0aGUgY2FjaGUg
YXJyYXlzIGFyZSBtb3N0bHkNCj4gZmluZSBhbmQgZXJyb3JzIHJlcG9ydGVkIHRoZXJlIGFyZSBu
b3Qgc29tZXRoaW5nIHRoYXQgaGFwcGVucyB2ZXJ5DQo+IGZyZXF1ZW50bHkgc28gd2UgZG9uJ3Qg
ZXZlbiBuZWVkIHRvIGNvbGxlY3QgYW5kIGNvdW50IHRob3NlLg0KDQpPbiBJbnRlbCBYODYgd2Ug
bGVhdmUgdGhlIGNvdW50aW5nIGFuZCB0aHJlc2hvbGQgZGVjaXNpb25zIGFib3V0IGNhY2hlDQpo
ZWFsdGggdG8gdGhlIGhhcmR3YXJlLiBXaGVuIGEgY2FjaGUgcmVhY2hlcyB0aGUgbGltaXQsIGl0
IGxvZ3MgYSAieWVsbG93Ig0Kc3RhdHVzIGluc3RlYWQgb2YgImdyZWVuIiBpbiB0aGUgbWFjaGlu
ZSBjaGVjayBiYW5rIChlcnJvciBpcyBzdGlsbCBtYXJrZWQNCmFzICJjb3JyZWN0ZWQiKS4gVGhl
IG1jZWxvZyg4KSBkYWVtb24gbWF5IGF0dGVtcHQgdG8gdGFrZSBDUFVzIHRoYXQgc2hhcmUNCnRo
YXQgY2FjaGUgb2ZmbGluZS4NCg0KU2VlIEludGVsIFNETSB2b2x1bWUgM0IgIjE1LjQgRW5oYW5j
ZWQgQ2FjaGUgRXJyb3IgUmVwb3J0aW5nIg0KDQotVG9ueQ0KDQoNCg==
