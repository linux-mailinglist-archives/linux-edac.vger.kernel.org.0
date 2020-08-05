Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8423D3DF
	for <lists+linux-edac@lfdr.de>; Thu,  6 Aug 2020 00:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHEWUM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 18:20:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:45077 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgHEWUL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 18:20:11 -0400
IronPort-SDR: g0TxY6qRHFaunRuL4+8eCr3kXFd2WZ1ubeNzbVE1gdtE9Yg2Xpk2j63KzI/S2gIb7CsB4p4I6x
 vpZkZDhScF0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="214191139"
X-IronPort-AV: E=Sophos;i="5.75,439,1589266800"; 
   d="scan'208";a="214191139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 15:20:11 -0700
IronPort-SDR: n4fF5Ssox3MMl9O5gtpI7pzM2hwKg2EkdJHaGQAKL1JaM5BGGfh/hv7SD7UzzWTQo7D8YPKDLs
 vCoC5sO9hAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,439,1589266800"; 
   d="scan'208";a="367379419"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2020 15:20:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 15:20:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 15:19:53 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 5 Aug 2020 15:19:53 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Park, Kyung Min" <kyung.min.park@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Thread-Topic: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Thread-Index: AQHWas2615VPl64ZH0en2kZgOnVmAakpZx0AgAACuoCAAAK3AIAAyO2AgAAWsoCAAAv+AIAAFhoA//+oNUA=
Date:   Wed, 5 Aug 2020 22:19:53 +0000
Message-ID: <908fa12f40804f2185f58e8d2a87413f@intel.com>
References: <20200805191126.GA27509@ranerica-svr.sc.intel.com>
 <AC4AC665-06C3-404A-8245-BA4F1F4C4961@amacapital.net>
In-Reply-To: <AC4AC665-06C3-404A-8245-BA4F1F4C4961@amacapital.net>
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
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJIG1lYW50IGFzbSBhcyBpbiBhIC5TIGZpbGUuIEJ1dCB0aGUgY29kZSB3ZSBoYXZlIGlzIGZp
bmUgZm9yIHRoaXMgcHVycG9zZSwgYXQgbGVhc3QgZm9yIG5vdy4NCg0KVGhlcmUgc2VlbSB0byBi
ZSBzb21lIGRyaXZlcnMgdGhhdCBjYWxsIHN5bmNfY29yZToNCg0KZHJpdmVycy9taXNjL3NnaS1n
cnUvZ3J1ZmF1bHQuYzogICAgICAgICAgICAgICAgc3luY19jb3JlKCk7DQpkcml2ZXJzL21pc2Mv
c2dpLWdydS9ncnVmYXVsdC5jOiAgICAgICAgICAgICAgICBzeW5jX2NvcmUoKTsgICAgICAgICAg
ICAvKiBtYWtlIHN1cmUgd2UgYXJlIGhhdmUgY3VycmVudCBkYXRhICovDQpkcml2ZXJzL21pc2Mv
c2dpLWdydS9ncnVoYW5kbGVzLmM6ICAgICAgc3luY19jb3JlKCk7DQpkcml2ZXJzL21pc2Mvc2dp
LWdydS9ncnVoYW5kbGVzLmM6ICAgICAgc3luY19jb3JlKCk7DQpkcml2ZXJzL21pc2Mvc2dpLWdy
dS9ncnVrc2VydmljZXMuYzogICAgc3luY19jb3JlKCk7DQoNClNvIGlmIHlvdSBnbyB0aGlzIHBh
dGggc29tZSBkYXkgYmUgc3VyZSB0byBFWFBPUlQgdGhlIGlyZXRfdG9fc2VsZigpIGZ1bmN0aW9u
Lg0KDQotVG9ueQ0K
