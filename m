Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7450B411A07
	for <lists+linux-edac@lfdr.de>; Mon, 20 Sep 2021 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhITQpF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Sep 2021 12:45:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:58896 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237709AbhITQpF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 20 Sep 2021 12:45:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="222821628"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="222821628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 09:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="434822284"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2021 09:43:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 09:43:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 09:43:14 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Mon, 20 Sep 2021 09:43:14 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "Song, Youquan" <youquan.song@intel.com>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] x86/mce: Drop copyin special case for #MC
Thread-Topic: [PATCH v2 3/3] x86/mce: Drop copyin special case for #MC
Thread-Index: AQHXk8gq8Qe1g5tesEOw6jGkHsNov6utTUoAgAAAgWCAAHuLgP//i9Tw
Date:   Mon, 20 Sep 2021 16:43:14 +0000
Message-ID: <b65f57dd40e54572b3e00c571bafe1e3@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-4-tony.luck@intel.com> <YUhQsOKLeY/QV6ag@zn.tnic>
 <9d4690a2f3f143f882f63bd88c355004@intel.com> <YUi4v6BHqN5WqJUd@zn.tnic>
In-Reply-To: <YUi4v6BHqN5WqJUd@zn.tnic>
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

PiBJcyB0aGlzIGhvdyB5b3UgZ2VuZXJhdGVkIHRoYXQgbGlzdCwgcGVyIGNoYW5jZT8NCj4NCj4g
JCBnaXQgbG9nIC0tb25lbGluZSB2NS4xNCAtLSBsaWIvaW92X2l0ZXIuYw0KDQpBbG1vc3QuIEkg
aGFkICJ2NS4xNCBedjUuMTMiIHRvIHN0b3AgZ2l0IGZyb20gZ29pbmcgYmFjaw0KZnVydGhlciB0
aGFuIHdoZW4gSSB0aGluayBBbCBzdGFydGVkIGFwcGx5aW5nIHRob3NlIGZpeGVzLg0KDQotVG9u
eQ0K
