Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DF307C45
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jan 2021 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhA1RY5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Jan 2021 12:24:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:58077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhA1RXO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Jan 2021 12:23:14 -0500
IronPort-SDR: iz5+H8ulB3xknaNaRMkfU0JX/m/YzHz83ucx4fyOqNKpdujZBStQgE5m4QRACa9y4HNfPjQJNK
 W/OYzBerOfdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="167372321"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="167372321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:22:31 -0800
IronPort-SDR: nI6ArfeYesHOylrhhm6ohHkBZOI7Z3zkM3H9EExFE6lAVryUSfSRGUUNzHlu8Ms3ukfntfOOyo
 WQPxKPa+Dkkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="409219123"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2021 09:22:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 09:22:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 09:22:30 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Thu, 28 Jan 2021 09:22:30 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>, Borislav Petkov <bp@alien8.de>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "CHENGUOMIN@kingsoft.com" <CHENGUOMIN@kingsoft.com>
Subject: RE: [PATCH v2] Dump cper error table in mce_panic
Thread-Topic: [PATCH v2] Dump cper error table in mce_panic
Thread-Index: AQHW9W1UcvZJLq301kWjYofz6/0Q7Ko9Rv/Q
Date:   Thu, 28 Jan 2021 17:22:30 +0000
Message-ID: <e9645a3ff93e46d4aabdf7dd45bfc4d7@intel.com>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
        <20201119134057.37ca2c19.yaoaili@kingsoft.com>
        <20201119174508.GE3769@zn.tnic>
        <20201120172235.620eb826.yaoaili@kingsoft.com>  <20201120102422.GA712@zn.tnic>
 <20210128200128.6f022993.yaoaili@kingsoft.com>
In-Reply-To: <20210128200128.6f022993.yaoaili@kingsoft.com>
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

PiBUaGUgZXZlbiBiZXR0ZXIgd2F5IHRvIGRldGVjdCB0aGlzIGlzIHRvIGJlIGFibGUgdG8gY2hl
Y2sgd2hldGhlciB0aGlzDQo+IGlzIHRoZSBrZHVtcCBrZXJuZWwgYW5kIHdoZXRoZXIgaXQgZ290
IGxvYWRlZCBkdWUgdG8gYSBmYXRhbCBNQ0UgaW4gdGhlDQo+IGZpcnN0IGtlcm5lbCBhbmQgdGhl
biBtYXRjaCB0aGF0IGVycm9yIGFkZHJlc3Mgd2l0aCB0aGUgZXJyb3IgYWRkcmVzcyBvZg0KPiB0
aGUgZXJyb3Igd2hpY2ggY2F1c2VkIHRoZSBmaXJzdCBwYW5pYyBpbiB0aGUgbWNlIGNvZGUuIFRo
ZW4gdGhlIHNlY29uZA0KPiBrZXJuZWwgd29uJ3QgbmVlZCB0byBwYW5pYyBidXQgc2ltcGx5IGxv
Zy4NCg0KVGhlIGJpZ2dlc3QgcHJvYmxlbSB3aXRoIGFsbCBvZiB0aGUgbG9nZ2luZyAod2hldGhl
ciBpbiBtYWNoaW5lIGNoZWNrDQpiYW5rcywgb3IgaW4gZXJyb3IgcmVjb3JkcyBmcm9tIEJJT1Mp
IGlzIHRoZSBsYWNrIG9mIGEgdGltZXN0YW1wLiBJZiB0aGVyZQ0Kd2FzIGEgd2F5IHRvIHRlbGwg
aWYgdGhpcyAianVzdCBoYXBwZW5lZCIsIG9yICJoYXBwZW5lZCBhIHdoaWxlIGFnbyIgdGhlbg0K
c3VjaCAidGFrZSBhY3Rpb24iIG9yICJqdXN0IGxvZyIgZGVjaXNpb25zIHdvdWxkIGJlIHNpbXBs
ZXIuDQoNCk1heWJlIHlvdSBkb24ndCBuZWVkIHRvIGRvICphbGwqIHRob3NlIG1hdGNoaW5nIGNo
ZWNrcy4gIEp1c3QgYSBmbGFnDQpmcm9tIHRoZSBmaXJzdCBrZXJuZWwgdG8gc2F5ICJJIGRpZWQg
ZnJvbSBhIGZhdGFsIG1hY2hpbmUgY2hlY2siIGNvdWxkDQpiZSB1c2VkIHRvIHRlbGwgdGhlIGtk
dW1wIGtlcm5lbCAianVzdCBsb2cgdGhlIGNwZXIiIHN0dWZmLg0KDQpJZiB0aGUgc3lzdGVtIGlz
IGJyb2tlbiBlbm91Z2ggdGhhdCBtb3JlIG1hY2hpbmUgY2hlY2tzIGFyZSBzdGlsbA0KZmlyaW5n
IGluIHRoZSBrZHVtcCBrZXJuZWwgLi4uIHRoZW4geW91IHdvdWxkIG1pc3MgdHJ5aW5nIHRvIHJl
Y292ZXIuDQpCdXQgaWYgbW9yZSBtYWNoaW5lIGNoZWNrcyBhcmUgaGFwcGVuaW5nLCB0aGVuIHRo
ZSBrZHVtcCBrZXJuZWwNCmlzIGxpa2VseSBkb29tZWQgYW55d2F5Lg0KDQpHZXR0aW5nIGEgZnVs
bCBtZW1vcnkgZHVtcCBhZnRlciBhIG1hY2hpbmUgY2hlY2sgZ2VuZXJhbGx5IGlzbid0DQphbGwg
dGhhdCB1c2VmdWwgYW55d2F5LiBUaGUgcHJvYmxlbSB3YXMgKGFsbW9zdCBjZXJ0YWlubHkpIGgv
dywgc28NCm5vdCBtdWNoIGJlbmVmaXQgaW4gZGVjb2RpbmcgdGhlIGR1bXAgdG8gZmluZCB3aGlj
aCBjb2RlIHdhcyBydW5uaW5nDQp3aGVuIHRoZSBoL3cgc2lnbmFsbGVkLg0KDQpBIHNlY29uZCBi
aXRlIGF0IGdldHRpbmcgdGhlIGVycm9yIGxvZ3MgZnJvbSB0aGUgZGVhdGggb2YgdGhlIGZpcnN0
DQprZXJuZWwgaXMgd29ydGggaXQgdGhvdWdoLg0KDQotVG9ueQ0K
