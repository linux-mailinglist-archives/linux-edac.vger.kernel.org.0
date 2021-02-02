Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E591630C50D
	for <lists+linux-edac@lfdr.de>; Tue,  2 Feb 2021 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhBBQK7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Feb 2021 11:10:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:11622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236097AbhBBQIw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Feb 2021 11:08:52 -0500
IronPort-SDR: DBYL1IgfkCYR1QKpGe0qVQV9QuHZz/lynG89OTa+2rz052fRoNa8PBPI2sFlfS0KJp96uOVOCI
 ANushj3+7mmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160642750"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="160642750"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:04:20 -0800
IronPort-SDR: l5mKSzRJkP7qVH9nCbGn+kbS5yQY3daL/Y2i01rj7wx1JGQX/CBt9B7GgHg5YKCVRoQTyM8sU5
 gQuViiLS7N9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="413312380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Feb 2021 08:04:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 08:04:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 08:04:18 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Tue, 2 Feb 2021 08:04:18 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Darren Hart" <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHW820jWhd/BlkCukOtPpk65S5gH6o6RPEAgAA7fACAA1zygIAF1CqAgAGTOQD//8zdUA==
Date:   Tue, 2 Feb 2021 16:04:17 +0000
Message-ID: <d99c43608909400199e9384bb7425beb@intel.com>
References: <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
 <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
 <20210128175735.GB2120@zn.tnic>
 <20210201185812.GA54867@agluck-desk2.amr.corp.intel.com>
 <20210202110126.GB18075@zn.tnic>
In-Reply-To: <20210202110126.GB18075@zn.tnic>
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

PiBBbmQgdGhlIG11Y2ggbW9yZSBpbXBvcnRhbnQgcXVlc3Rpb24gaXMsIHdoYXQgaXMgdGhlIGNv
ZGUgc3VwcG9zZWQgdG8NCj4gZG8gd2hlbiB0aGF0IG92ZXJmbG93ICphY3R1YWxseSogaGFwcGVu
cyBpbiByZWFsIGxpZmU/IEJlY2F1c2UgSUlOTSwNCj4gYW4gb3ZlcmZsb3cgY29uZGl0aW9uIG9u
IHRoZSBzYW1lIHBhZ2Ugd291bGQgbWVhbiBraWxsaW5nIHRoZSB0YXNrIHRvDQo+IGNvbnRhaW4g
dGhlIGVycm9yIGFuZCBub3Qga2lsbGluZyB0aGUgbWFjaGluZS4uLg0KDQpDb3JyZWN0LiBUaGUg
Y2FzZXMgSSd2ZSBhY3R1YWxseSBoaXQsIHRoZSBzZWNvbmQgbWFjaGluZSBjaGVjayBpcyBvbiB0
aGUNCnNhbWUgYWRkcmVzcyBhcyB0aGUgZmlyc3QuIEJ1dCBmcm9tIGEgcmVjb3ZlcnkgcGVyc3Bl
Y3RpdmUgTGludXggaXMgZ29pbmcNCnRvIHRha2UgYXdheSB0aGUgd2hvbGUgcGFnZSBhbnl3YXkg
Li4uIHNvIG5vdCBjb21wbGFpbmluZyBpZiB0aGUgc2Vjb25kDQoob3Igc3Vic2VxdWVudCkgYWNj
ZXNzIGlzIHdpdGhpbiB0aGUgc2FtZSBwYWdlIG1ha2VzIHNlbnNlIChhbmQgdGhhdCdzDQp3aGF0
IHRoZSBwYXRjaCBkb2VzKS4NCg0KVGhlIGNvZGUgY2FuJ3QgaGFuZGxlIGl0IGlmIGEgc3Vic2Vx
dWVudCAjTUMgaXMgdG8gYSBkaWZmZXJlbnQgcGFnZSAoYmVjYXVzZQ0Kd2Ugb25seSBoYXZlIGEg
c2luZ2xlIHNwb3QgaW4gdGhlIHRhc2sgc3RydWN0dXJlIHRvIHN0b3JlIHRoZSBwaHlzaWNhbCBw
YWdlDQphZGRyZXNzKS4gIEJ1dCB0aGF0IGxvb2tzIGFkZXF1YXRlLiBJZiB0aGUgY29kZSBpcyB3
aWxkbHkgYWNjZXNzaW5nIGRpZmZlcmVudA0KcGFnZXMgKmFuZCogZ2V0dGluZyBtYWNoaW5lIGNo
ZWNrcyBmcm9tIHRob3NlIGRpZmZlcmVudCBwYWdlcyAuLi4gdGhlbg0Kc29tZXRoaW5nIGlzIHZl
cnkgc2VyaW91c2x5IHdyb25nIHdpdGggdGhlIHN5c3RlbS4NCg0KLVRvbnkNCg0K
