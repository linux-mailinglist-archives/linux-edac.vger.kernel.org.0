Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53613DC832
	for <lists+linux-edac@lfdr.de>; Sat, 31 Jul 2021 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGaUnW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 31 Jul 2021 16:43:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:1396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhGaUnV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 31 Jul 2021 16:43:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="274335556"
X-IronPort-AV: E=Sophos;i="5.84,285,1620716400"; 
   d="scan'208";a="274335556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 13:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,285,1620716400"; 
   d="scan'208";a="477676538"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2021 13:43:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 31 Jul 2021 13:43:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 31 Jul 2021 13:43:13 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Sat, 31 Jul 2021 13:43:13 -0700
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
Thread-Index: AQHXhdWHIECRm0GebEyGCELVn1f6zqtdjHxQ
Date:   Sat, 31 Jul 2021 20:43:13 +0000
Message-ID: <fc4d994b02f643d480647edc4f2a7a29@intel.com>
References: <CAPcxDJ6qnrkuckxm6KkoONZZh5Q-H3-CkFiWq627p5OF3GKJ4Q@mail.gmail.com>
In-Reply-To: <CAPcxDJ6qnrkuckxm6KkoONZZh5Q-H3-CkFiWq627p5OF3GKJ4Q@mail.gmail.com>
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

PiBBZnRlciBjaGVycnkgcGlja2luZyBwYXRjaCAxICYgMiwgSSBzYXcgdGhlIGZvbGxvd2luZyB3
aXRoIDIgVUMgZXJyb3JzIGluamVjdGVkDQo+IGludG8gdGhlIHVzZXIgc3BhY2UgYnVmZmVyIHBh
c3NlZCBpbnRvIHdyaXRlKDIpLCBhcyBleHBlY3RlZDoNCj4NCj4gWyAgMjg3Ljk5NDc1NF0gS2Vy
bmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE1hY2hpbmUgY2hlY2tzIHRvIGRpZmZlcmVudA0KPiB1
c2VyIHBhZ2VzDQoNCkludGVyZXN0aW5nLiAgV2hhdCBhcmUgdGhlIG9mZnNldHMgb2YgdGhlIHR3
byBpbmplY3RlZCBlcnJvcnMgaW4geW91ciB0ZXN0IChib3RoDQp3LnIudC4gdGhlIHN0YXJ0IG9m
IHRoZSBidWZmZXIsIGFuZCB3aXRoaW4gYSBwYWdlKS4NCg0KPiBUaGUga2VybmVsIHRlc3RlZCB3
aXRoIGhhcyBpdHMgeDg2L21jZSBhbmQgbW0vbWVtb3J5LWZhaWx1cmUgYWxpZ25lZCB3aXRoDQo+
IHVwc3RyZWFtIHRpbGwgYXJvdW5kIDIwMjAvMTEuDQo+DQo+IElzIHRoZXJlIGFueSBvdGhlciBw
YXRjaCB0aGF0IEkgaGF2ZSBtaXNzZWQgdG8gdGhlIHdyaXRlIHN5c2NhbGwgZXRjPw0KDQpUaGVy
ZSBpcyBhIGxvbmcgc2VyaWVzIG9mIHBhdGNoZXMgZnJvbSBBbCBWaXJvIHRvIGxpYi9pb3ZfaXRl
ci5jIHRoYXQgYXJlIG1heWJlDQphbHNvIHJlbGV2ZW50IGluIG1ha2luZyB0aGUga2VybmVsIGNv
cHkgZnJvbSB1c2VyIHN0b3AgYXQgdGhlIGZpcnN0IHBvaXNvbg0KYWRkcmVzcyBpbiB0aGUgYnVm
ZmVyLg0KDQotVG9ueQ0K
