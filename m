Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5602F4F85
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbhAMQGx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jan 2021 11:06:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:11046 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbhAMQGx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Jan 2021 11:06:53 -0500
IronPort-SDR: WgjdOOYThxqPdEe4wNNk/4kBqXuR5zAngrehk/yrab1xw98y+sOuEJiMfadkKu48w845HtkqtW
 U7LrB6YozpAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="263014471"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="263014471"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 08:06:10 -0800
IronPort-SDR: bOzlq79cq60wRr/pOdULkolaqESeVE55VU8e0SDI7AWi7An4zqvFB9QvPfy0xB4iIQ26NoFKlC
 w89OBIzLNwKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="567891965"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2021 08:06:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 08:06:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 08:06:09 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 13 Jan 2021 08:06:09 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Darren Hart" <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: RE: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHW6GMIjFZnFv+51UOaFGZUXPBBdKojguIA//98a4CAAb7TAP//fnCAgACHdoD//4tlAAAR67SA//+aBgCAAJpygP//uQmAgACulACAAGA4gIAAINgQ
Date:   Wed, 13 Jan 2021 16:06:09 +0000
Message-ID: <8c4cd08e82884518b607f392523dd70b@intel.com>
References: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
 <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
 <20210113100009.GA16960@zn.tnic>
In-Reply-To: <20210113100009.GA16960@zn.tnic>
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

PiBJIHRoaW5rIHlvdSBndXlzIGhhdmUgdmVlcmVkIG9mZiBpbnRvIHRoZSB3ZWVkcyB3aXRoIHRo
aXMuIFRoZSBjdXJyZW50DQo+IHNvbHV0aW9uIC0gbW9kdWxvIGVycm9yIG1lc3NhZ2VzIG5vdCBk
ZXN0aW5lZCBmb3IgaHVtYW5zIDopIC0gaXMgbm90IHNvbw0KPiBiYWQsIGNvbnNpZGVyaW5nIHRo
ZSB3aG9sZSBNQ0EgdHJhaW53cmVjay4NCj4NCj4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZyBj
b21wbGV0ZWx5IHVuYWNjZXB0YWJsZT8NCg0KTWF5YmUgdGhlIG90aGVyIGRpZmZlcmVuY2UgaW4g
YXBwcm9hY2ggYmV0d2VlbiBBbmR5IGFuZCBtZSBpcyB3aGV0aGVyIHRvDQpnbyBmb3IgYSBzb2x1
dGlvbiB0aGF0IGNvdmVycyBhbGwgdGhlIGNvcm5lciBjYXNlcywgb3IganVzdCBtYWtlIGFuIGlu
Y3JlbWVudGFsDQppbXByb3ZlbWVudCB0aGF0IGFsbG93cyBmb3IgcmVjb3ZlciBpbiBzb21lIHVz
ZWZ1bCBzdWJzZXQgb2YgcmVtYWluaW5nIGZhdGFsDQpjYXNlcywgYnV0IHN0aWxsIGRpZXMgaW4g
b3RoZXIgY2FzZXMuDQoNCkknbSBoYXBweSB0byByZXBsYWNlIGVycm9yIG1lc3NhZ2VzIHdpdGgg
b25lcyB0aGF0IGFyZSBtb3JlIGRlc2NyaXB0aXZlIGFuZA0KaGVscGZ1bCB0byBodW1hbnMuDQoN
Ci1Ub255DQo=
