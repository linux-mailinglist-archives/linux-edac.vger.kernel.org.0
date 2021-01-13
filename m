Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0492F5011
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbhAMQdw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jan 2021 11:33:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:63201 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbhAMQdw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Jan 2021 11:33:52 -0500
IronPort-SDR: fgOj37cFgIJApYIGQ8wE/tMYDrbrAZELnACIZbzO5oTuBEZtXAJCXgsgeqZutfaddU4r+7wjrF
 LYDDJWdeiUBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="242306735"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="242306735"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 08:33:09 -0800
IronPort-SDR: bFZ+1re53W/fi1j8G3Wq4IiNhv7PbW4zz7l6u50V2K9KO2F/5PX8X1sNTnuKgyMqqmvIvIpOcz
 kvv3P0xpGxgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="363932892"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2021 08:32:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 08:32:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 08:32:54 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 13 Jan 2021 08:32:54 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: RE: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHW6GMIjFZnFv+51UOaFGZUXPBBdKojguIA//98a4CAAb7TAP//fnCAgACHdoD//4tlAAAR67SA//+aBgCAAJpygP//uQmAgACulACAAGA4gIAAINgQgABJKYCAAITv4A==
Date:   Wed, 13 Jan 2021 16:32:54 +0000
Message-ID: <b6ba39266301475b8565142585943fec@intel.com>
References: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
 <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
 <20210113100009.GA16960@zn.tnic> <8c4cd08e82884518b607f392523dd70b@intel.com>
 <20210113161933.GE16960@zn.tnic>
In-Reply-To: <20210113161933.GE16960@zn.tnic>
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

Pj4gTWF5YmUgdGhlIG90aGVyIGRpZmZlcmVuY2UgaW4gYXBwcm9hY2ggYmV0d2VlbiBBbmR5IGFu
ZCBtZSBpcyB3aGV0aGVyIHRvDQo+PiBnbyBmb3IgYSBzb2x1dGlvbiB0aGF0IGNvdmVycyBhbGwg
dGhlIGNvcm5lciBjYXNlcywgb3IganVzdCBtYWtlIGFuIGluY3JlbWVudGFsDQo+PiBpbXByb3Zl
bWVudCB0aGF0IGFsbG93cyBmb3IgcmVjb3ZlciBpbiBzb21lIHVzZWZ1bCBzdWJzZXQgb2YgcmVt
YWluaW5nIGZhdGFsDQo+PiBjYXNlcywgYnV0IHN0aWxsIGRpZXMgaW4gb3RoZXIgY2FzZXMuDQo+
DQo+IERvZXMgdGhhdCBtZWFuIG1vcmUgY29yZSBjb2RlIHN1cmdlcnk/DQoNClllcy4gSSBuZWVk
IHRvIGxvb2sgYXQgb3RoZXIgdXNlciBhY2Nlc3MgaW5zaWRlIHBhZ2VmYXVsdF9kaXNhYmxlL2Vu
YWJsZSgpDQphcyBsaWtlbHkgc3BvdHMgd2hlcmUgdGhlIGNvZGUgbWF5IGNvbnRpbnVlIGFmdGVy
IGEgbWFjaGluZSBjaGVjayBhbmQNCnJldHJ5IHRoZSBhY2Nlc3MuICBTbyBleHBlY3Qgc29tZSBt
b3JlICJpZiAocmV0ID09IEVOWElPKSB7IGRvIHNvbWV0aGluZyB0byBnaXZlIHVwIGdyYWNlZnVs
bHkgfSINCg0KPj4gSSdtIGhhcHB5IHRvIHJlcGxhY2UgZXJyb3IgbWVzc2FnZXMgd2l0aCBvbmVz
IHRoYXQgYXJlIG1vcmUgZGVzY3JpcHRpdmUgYW5kDQo+PiBoZWxwZnVsIHRvIGh1bWFucy4NCj4N
Cj4gWWFwLCB0aGF0OiAiTXVsdGlwbGUgY29weWluIiB3aXRoIHNvbWV0aGluZyBtb3JlIHVuZGVy
c3RhbmRhYmxlIHRvIHVzZXJzLi4uDQoNCkknbGwgd29yayBvbiBpdC4gV2UgdGVuZCBub3QgdG8g
aGF2ZSBlc3NheSBsZW5ndGggbWVzc2FnZXMgYXMgcGFuaWMoKSBzdHJpbmdzLiBCdXQgSSBjYW4N
CmFkZCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUgdGhlcmUgc28gdGhhdCBwZW9wbGUgd2hvIGdyZXAg
d2hhdGV2ZXIgcGFuaWMgbWVzc2FnZQ0Kd2UgY2hvb3NlIGNhbiBnZXQgbW9yZSBkZXRhaWxzIG9u
IHdoYXQgaGFwcGVuZWQgYW5kIHdoYXQgdG8gZG8uDQoNCi1Ub255DQo=
