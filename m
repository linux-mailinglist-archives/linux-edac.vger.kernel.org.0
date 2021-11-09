Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1A44B0DA
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 17:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhKIQJo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 11:09:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:51456 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235059AbhKIQJn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Nov 2021 11:09:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232314691"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="232314691"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 08:06:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="491707776"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2021 08:06:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 08:06:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 08:06:48 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Tue, 9 Nov 2021 08:06:48 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Zhaolong Zhang <zhangzl2013@126.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: RE: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Thread-Topic: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Thread-Index: AQHX1Hq0qXr3DmSE1U2VzqbCjPBltKv55BMAgAALgwCAAAUwAIAAJhiAgAFKpICAAAodgP//7irA
Date:   Tue, 9 Nov 2021 16:06:48 +0000
Message-ID: <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com> <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic>
In-Reply-To: <YYo6VwPZLCWcP3Bl@zn.tnic>
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

PiAgICAgICAgaWYgKChzNjQpKnQgPCBTUElOVU5JVCkgew0KPiAgICAgICAgICAgICAgICBpZiAo
Y3B1bWFza19hbmQoJm1jZV9taXNzaW5nX2NwdXMsIGNwdV9vbmxpbmVfbWFzaywgJm1jZV9taXNz
aW5nX2NwdXMpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIHByX2VtZXJnKCJDUFVzIG5vdCBy
ZXNwb25kaW5nIHRvIE1DRSBicm9hZGNhc3QgKG1heSBpbmNsdWRlIGZhbHNlIHBvc2l0aXZlcyk6
ICUqcGJsXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdW1hc2tfcHJf
YXJncygmbWNlX21pc3NpbmdfY3B1cykpOw0KPiAgICAgICAgICAgICAgICBpZiAobWNhX2NmZy50
b2xlcmFudCA8PSAxKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIG1jZV9wYW5pYyhtc2csIE5V
TEwsIE5VTEwpOw0KPiAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gICAgICAgIH0NCg0KSnVz
dCBhIG5vdGUgdGhhdCBza2lwcGluZyB0aGUgbWNlX3BhbmljKCkgaGVyZSBpc24ndCBnb2luZyB0
byBoZWxwIG11Y2guIFdpdGggc29tZSBDUFVzDQpzdHVjayBub3QgcmVzcG9uZGluZyB0byAjTUMg
dGhlIHN5c3RlbSBpcyBnb2luZyB0byBsb2NrIHVwIG9yIGNyYXNoIGZvciBvdGhlciB0aW1lb3V0
cyBpbg0KdGhlIG5leHQgZmV3IHNlY29uZHMuDQoNCi1Ub255DQoNCg==
