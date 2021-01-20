Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993302FD6C6
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jan 2021 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbhATRSo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jan 2021 12:18:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:12378 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390735AbhATRSj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 20 Jan 2021 12:18:39 -0500
IronPort-SDR: tC31yFzbu3rTs2UfCIIhxHqghO71WAusQM2pUwEEg9WbQqRX+SVYDXafACGnT6pMgbCv3pjr5J
 9265Y1iHBKLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="240681976"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="240681976"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 09:17:49 -0800
IronPort-SDR: IDUk1aqPy7VgkqcXJff/ivsMPleJk4CRYmJ1s9Uu0o9W0tyPECwd9AAGqBybD29jbh25iPM08e
 z5Oh0HDdvorA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="391615567"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2021 09:17:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 09:17:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 09:17:25 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 20 Jan 2021 09:17:25 -0800
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
Subject: RE: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHW64AlZtFSH7GIt0KNvnBLdhzieKopU/SAgAX+pgCAAFQ9AIABVOkA///MFvA=
Date:   Wed, 20 Jan 2021 17:17:25 +0000
Message-ID: <ac36cf0fa63442188d2d1458ef6a0eb3@intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com> <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
In-Reply-To: <20210120121812.GF825@zn.tnic>
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

PiBZYWgsIHNvbWUgcHJpbnRrIHNwcmlua2xpbmcgbWlnaHQgYmUgYSBnb29kIHN0YXJ0LiBCdXQg
ZGVidWdnaW5nIGluIHRoYXQNCj4gYXRvbWljIGNvbnRleHQgaXMgYWx3YXlzIG5hc3R5LiA7LVwN
Cg0KU29tZSB2ZXJ5IGxpZ2h0IHByaW50ayBzcHJpbmtsaW5nIChvbmUgbWVzc2FnZSBpbiBxdWV1
ZV90YXNrX3dvcmsoKSBpbiBhdG9taWMNCmNvbnRleHQsIG9uZSBlYWNoIGluIGtpbGxfbWVfbm93
KCkgYW5kIGtpbGxfbWVfbWF5YmUoKSB0byBjaGVjayB3aGVuIHRhc2tfd29yaw0KYWN0dWFsbHkg
Y2FsbGVkIHRoZW0uDQoNCkNhc2VzIDEgJiAyICh1c2VyICYgbm9ybWFsIGNvcHlpbikgbm93IHdv
cmsganVzdCBmaW5lIChodW5kcmVkcyBvZiBpdGVyYXRpb25zKS4NCg0KQ2FzZSAzIChteSBmdXRl
eCB0ZXN0KSBqdXN0IGhhbmdzIHdpdGggb25seSB0d28gY2hhcmFjdGVycyBtYWtpbmcgaXQgdG8g
dGhlIHNlcmlhbCBwb3J0ICJbICINCg0KRGVlcGx5IHN0cmFuZ2UuDQoNCi1Ub255DQo=
