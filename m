Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BD2803F6
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgJAQ34 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 12:29:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:56967 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbgJAQ34 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 1 Oct 2020 12:29:56 -0400
IronPort-SDR: A1DwE94C5P6THAQ8+ajXGoSY2GNveefp2tJWh+pdE3RO1aZGaqPBcRrnB34f+PwzgIb5oWxAWD
 Bcbzw9CGJaLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="247508056"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="247508056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 09:29:50 -0700
IronPort-SDR: xSqcFfJHGZ6mrSvRCmojTn6eKtka4P8kF6gQc25rvrcHNytxpOLBPk1Hk4NAfwLo1dqQbjsS4E
 /2CK5yU27sjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="325470793"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2020 09:29:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Oct 2020 09:29:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Oct 2020 09:29:49 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 1 Oct 2020 09:29:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Corey Minyard <minyard@acm.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: RE: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Thread-Topic: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Thread-Index: AQHWlqXaLugN/2bEYEaScMC3jedrIqmB7h2AgAAOrwCAARiSAIAAJL6AgAAqdID//4zz4A==
Date:   Thu, 1 Oct 2020 16:29:49 +0000
Message-ID: <6c6238c0088747a994a2bdce38ad0242@intel.com>
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic> <20200930184906.GZ3674@minyard.net>
 <20201001113318.GC17683@zn.tnic> <20201001134449.GB3674@minyard.net>
 <20201001161645.GD17683@zn.tnic>
In-Reply-To: <20201001161645.GD17683@zn.tnic>
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

Pj4gSSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhpcyBzb21lIHllc3RlcmRheS4gIEl0IHNlZW1zIHRv
IG1lIHRoYXQgZW5hYmxpbmcNCj4+IElSUVMgaW4gYW4gTUNFIGhhbmRsZXIgaXMganVzdCBhIGJh
ZCBpZGVhLCBidXQgaXQncyByZWFsbHkgYSBiYWQgaWRlYQ0KPj4gZm9yIGtkdW1wLg0KPg0KPiBJ
IGRvbid0IHRoaW5rIHRoaXMgY29kZSBldmVyIHRob3VnaHQgYWJvdXQga2R1bXAuDQoNCkhvdyB1
c2VmdWwgaXMga2R1bXAgYWZ0ZXIgYSBtYWNoaW5lIGNoZWNrIGluZHVjZWQgY3Jhc2ggYW55d2F5
Pw0KDQprZHVtcCBpcyB1c2VmdWwgZm9yIGRlYnVnZ2luZyBzb2Z0d2FyZSBwcm9ibGVtcy4gIFRo
ZXJlIGFyZSB2ZXJ5DQpmZXcgd2F5cyB0aGF0IGEgc29mdHdhcmUgYnVnIGNhbiByZXN1bHQgaW4g
YSBtYWNoaW5lIGNoZWNrLiBUaGVyZQ0KYXJlIG1hbnkgd2F5cyB0aGF0IGEgaGFyZHdhcmUgcHJv
YmxlbSBjYW4gdHJpZ2dlciBhIG1hY2hpbmUgY2hlY2sNCmFuZCBjcmFzaC4NCg0KU28gaXQgd291
bGQgc2VlbSAoc3RhdGlzdGljYWxseSkgdGhhdCB0aGUgYW5hbHlzaXMgb2YgYWxtb3N0IGV2ZXJ5
IGtkdW1wDQphZnRlciBhIG1hY2hpbmUgY2hlY2sganVzdCBzYXlzICJoL3cgaXNzdWUiLg0KDQot
VG9ueQ0K
