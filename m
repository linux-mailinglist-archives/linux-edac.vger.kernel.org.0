Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE27F44B434
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 21:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbhKIUra (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 15:47:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:1517 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244625AbhKIUr3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Nov 2021 15:47:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="293374042"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="293374042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 12:44:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="503666032"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2021 12:44:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 12:44:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 12:44:42 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Tue, 9 Nov 2021 12:44:42 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Zhaolong Zhang <zhangzl2013@126.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: RE: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Thread-Topic: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Thread-Index: AQHX1Hq0qXr3DmSE1U2VzqbCjPBltKv55BMAgAALgwCAAAUwAIAAJhiAgAFKpICAAAodgP//7irAgADE0YD//3oYIIAAj0EA//98L+A=
Date:   Tue, 9 Nov 2021 20:44:41 +0000
Message-ID: <42d1d11d63f3453db61fad58a91e2ba5@intel.com>
References: <20211108082832.142436-1-zhangzl2013@126.com>
 <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic> <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
 <YYrQe7bYe+OBzZ4B@zn.tnic> <84e2622e4300490587793d2509f7b3ff@intel.com>
 <YYrYUpM7c5Z+nFsv@zn.tnic>
In-Reply-To: <YYrYUpM7c5Z+nFsv@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiB3aGF0IGRvIHdlIGRvIHdpdGggdGhlIHN5c2ZzIGtub2I/IEl0IHByb2JhYmx5IGlzIGFuIEFC
SToNCj4NCj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9tYWNoaW5lY2hlY2svbWFjaGluZWNoZWNrMS90
b2xlcmFudA0KPiAvc3lzL2RldmljZXMvc3lzdGVtL21hY2hpbmVjaGVjay9tYWNoaW5lY2hlY2sy
L3RvbGVyYW50DQoNCiQgZ2l0IGdyZXAgdG9sZXJhbnQgLS0gRG9jdW1lbnRhdGlvbi9BQkkvDQok
DQoNCkFuIHVuZG9jdW1lbnRlZCBBQkkhIFdlbGwsIG5vdCBkb2N1bWVudGVkIHdpdGggYWxsIHRo
ZSBvdGhlciBzeXNmcyBiaXRzLg0KDQpJdCBkb2VzIGFwcGVhciBpbjoNCkRvY3VtZW50YXRpb24v
eDg2L3g4Nl82NC9tYWNoaW5lY2hlY2sucnN0DQoNCk9mIGNvdXJzZSwgbGlrZSBhIGxvdCBvZiBk
b2N1bWVudGF0aW9uLCBpdCBpc24ndCBhY2N1cmF0ZS4gSXQgd2Fzbid0DQp1cGRhdGVkIHRvIGRl
c2NyaWJlIHdoYXQgaGFwcGVucyB3aXRoIHJlY292ZXJhYmxlIGVycm9ycy4NCkZpbmFsIHBhcmFn
cmFwaCBzYXlzOg0KDQogICAgICAgIE5vdGUgdGhpcyBvbmx5IG1ha2VzIGEgZGlmZmVyZW5jZSBp
ZiB0aGUgQ1BVIGFsbG93cyByZWNvdmVyeQ0KICAgICAgICBmcm9tIGEgbWFjaGluZSBjaGVjayBl
eGNlcHRpb24uIEN1cnJlbnQgeDg2IENQVXMgZ2VuZXJhbGx5IGRvIG5vdC4NCg0KUmVjb3Zlcnkg
d2FzIGZpcnN0IGludHJvZHVjZWQgaW4gdGhlIE5laGFsZW0gZ2VuZXJhdGlvbiB3aGljaCBhcmsu
aW50ZWwuY29tDQpzYXlzIHdhcyBsYXVuY2hlZCBpbiBRMScyMDEwLiBTbyBvdmVyIGEgZGVjYWRl
Lg0KDQpDaG9pY2VzOg0KMSkgTGVhdmUgdGhlIGZpbGUgdGhlcmUsIGJ1dCByZW1vdmUgdGhlIGNv
ZGUgdGhhdCB1c2VzIHRoZSB2YWx1ZQ0KMikgRGVsZXRlIHRoZSBmaWxlIHRvbw0KDQpPcHRpb24g
MSBkb2Vzbid0IGJyZWFrIGFueSBzY3JpcHRzIHRoYXQgbG9vayBmb3IgdGhlIGZpbGUsIGJ1dCBt
YXkgbWFrZQ0KcGVvcGxlIHNob3V0IGxvdWRlciB3aGVuIHRoZXkgZmluZCBpdCBubyBsb25nZXIg
ZG9lcyBhbnl0aGluZy4NCg0KT3B0aW9uIDIgaXMgdGhlIG1vcmUgaG9uZXN0IGFwcHJvYWNoLg0K
DQoNCi1Ub255DQoNCg==
