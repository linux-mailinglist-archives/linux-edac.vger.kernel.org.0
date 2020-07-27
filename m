Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA922F518
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgG0Q1V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 12:27:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:17460 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgG0Q1V (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 12:27:21 -0400
IronPort-SDR: Zyrt3+BfaOtjdtjZZV+UkB/nvfcEMGxND+8xw1RB12XAwqBbyEHd4GkyMOY2II0tb2Ks0WEy89
 jz2w91RLJD6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="139093719"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="139093719"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 09:27:19 -0700
IronPort-SDR: nF9r4Ff70lscw3zHgJ4L5MfCizfqd26FMjfRw15FVNDjjE6Yj+Y0Po5vFBUGzSdTCfPYyjAheu
 mhnzQ7O2hliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="312267699"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2020 09:27:18 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Jul 2020 09:27:18 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.57]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.221]) with mapi id 14.03.0439.000;
 Mon, 27 Jul 2020 09:27:18 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Park, Kyung Min" <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Thread-Topic: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when
 available
Thread-Index: AQHWY87lOQINcdfFdkGk2Wd5AEVUOKkbYrqAgAA6k+A=
Date:   Mon, 27 Jul 2020 16:27:18 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F6B0D4A@ORSMSX115.amr.corp.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
In-Reply-To: <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGb3IgYSByZWFsbHkgb3ZlcmVuZ2luZXJlZCBzb2x1dGlvbiwgYnV0IHdoaWNoIG1pZ2h0IHBl
cmZvcm0gdW5uZWNlc3NhcnkgcG9vcmx5IG9uIGV4aXN0aW5nIGhhcmR3YXJlOg0KPg0KPiBhc20g
dm9sYXRpbGUoIjE6IC5ieXRlIDB4ZiwgMHgxLCAweGU4OyAyOiINCj4gICAgICAgICAgICAgICAg
ICAgICAgICBfQVNNX0VYVEFCTEUoMWIsMmIpKTsNCg0KWW91IHdpbiB0aGUgcHJpemUgZm9yIHRo
ZSBzbWFsbGVzdCBjb2RlLiAgTWlnaHQgbmVlZCAodGhlIGFscmVhZHkgbGFyZ2UpIGNvbW1lbnQg
dG8gZG91YmxlDQppbiBzaXplIHRvIGV4cGxhaW4gdGhlIHN1YnRsZXRpZXMhDQoNCi1Ub255DQo=
