Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD13D3BF9
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhGWOHM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jul 2021 10:07:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:57225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235310AbhGWOHM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Jul 2021 10:07:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="275708894"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="275708894"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 07:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="578014731"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2021 07:47:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 07:47:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 07:47:40 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Fri, 23 Jul 2021 07:47:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "dinghui@sangfor.com.cn" <dinghui@sangfor.com.cn>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Subject: RE: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHXfwEmVkDftAlLQUekz+CS3pEeK6tPG/EAgAD+lAD//5bsgIAAsOQA//+MXOCAAHu3AIAAOfWA
Date:   Fri, 23 Jul 2021 14:47:40 +0000
Message-ID: <3f944f83524d40a28fa9bb94647d1679@intel.com>
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
 <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com>
 <0e39ef0e1b6d4532a09ad2d6e0b28310@intel.com>
 <CAPcxDJ7=UsAkDwVuoQcTt2B2UA4RWjs_o_=Fnk4Hfuqj+V8hAA@mail.gmail.com>
In-Reply-To: <CAPcxDJ7=UsAkDwVuoQcTt2B2UA4RWjs_o_=Fnk4Hfuqj+V8hAA@mail.gmail.com>
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

PiBJbiBvdXIgdGVzdCwgdGhlIGFwcGxpY2F0aW9uIG1lbW9yeSB3YXMgYW5vbi4NCj4gV2l0aCAx
IFVDIGVycm9yIGluamVjdGVkLCB0aGUgdGVzdCBhbHdheXMgcGFzc2VzIHdpdGggdGhlIGVycm9y
DQo+IHJlY292ZXJlZCBhbmQgYSBTSUdCVVMgZGVsaXZlcmVkIHRvIHVzZXIgc3BhY2UuDQo+DQo+
IFdoZW4gdGhlcmUgYXJlID4xIFVDIGVycm9ycyBpbiBidWZmZXIsIHRoZW4gaW5kZWZpbml0ZSBt
Y2UgbG9vcC4NCg0KRG8geW91IHN0aWxsIHNlZSB0aGUgaW5maW5pdGUgbG9vcCB3aXRoIHRoZXNl
IHRocmVlIHBhdGNoZXMgb24gdG9wIG9mDQp2NS4xNC1yYywgcmF0aGVyIHRoYW4gYSBzaG9ydCBi
eXRlIHJldHVybiB2YWx1ZSBmcm9tIHdyaXRlLCBvcg0KDQoJbWNlX3BhbmljKCJNYWNoaW5lIGNo
ZWNrcyB0byBkaWZmZXJlbnQgdXNlciBwYWdlcyIsIG0sIG1zZyk7DQoNCi1Ub255DQoNCg0K
