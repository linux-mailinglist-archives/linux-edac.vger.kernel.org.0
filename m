Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6744B382
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbhKITxr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 14:53:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:57195 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243910AbhKITxq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Nov 2021 14:53:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="295971738"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="295971738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 11:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="669534948"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2021 11:50:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 11:50:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 11:50:58 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Tue, 9 Nov 2021 11:50:57 -0800
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
Thread-Index: AQHX1Hq0qXr3DmSE1U2VzqbCjPBltKv55BMAgAALgwCAAAUwAIAAJhiAgAFKpICAAAodgP//7irAgADE0YD//3oYIA==
Date:   Tue, 9 Nov 2021 19:50:57 +0000
Message-ID: <84e2622e4300490587793d2509f7b3ff@intel.com>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com> <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic> <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
 <YYrQe7bYe+OBzZ4B@zn.tnic>
In-Reply-To: <YYrQe7bYe+OBzZ4B@zn.tnic>
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

Pj4gSnVzdCBhIG5vdGUgdGhhdCBza2lwcGluZyB0aGUgbWNlX3BhbmljKCkgaGVyZSBpc24ndCBn
b2luZyB0byBoZWxwDQo+PiBtdWNoLiBXaXRoIHNvbWUgQ1BVcyBzdHVjayBub3QgcmVzcG9uZGlu
ZyB0byAjTUMgdGhlIHN5c3RlbSBpcyBnb2luZw0KPj4gdG8gbG9jayB1cCBvciBjcmFzaCBmb3Ig
b3RoZXIgdGltZW91dHMgaW4gdGhlIG5leHQgZmV3IHNlY29uZHMuDQo+DQo+IFllaCwgSSBzcGVu
dCBhIGNvdXBsZSBvZiBtaW51dGVzIHRvZGF5IHN0YXJpbmcgYXQgdGhpcyAtPnRvbGVyYW50DQo+
IHRoaW5nIGFuZCB3b25kZXJpbmcgd2h5IHdlIG5lZWQgaXQgYXQgYWxsLiBJIHdvdWxkbid0IG1p
bmQgcmlwcGluZyBpdA0KPiBhbHRvZ2V0aGVyIHVubGVzcyB5b3UncmUgdXNpbmcgaXQgZm9yIHRl
c3Rpbmcgb3Igc28uDQoNCkkgdGhpbmsgaXQgbWlnaHQgaGF2ZSBiZWVuIHVzZWZ1bCBiZWZvcmUg
cmVjb3ZlcmFibGUgbWFjaGluZSBjaGVja3MuIEJ1dA0Kbm93IGl0IGp1c3Qgc2VlbXMgdG8gY2F1
c2UgY29uZnVzaW9uLiBJIGRvIG5vdCBldmVyIHVzZSBpdC4gSSB3b3VsZCBub3QgYmUNCnNhZCB0
byBzZWUgaXQgZ28uDQoNCi1Ub255DQo=
