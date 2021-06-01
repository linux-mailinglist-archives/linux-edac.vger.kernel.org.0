Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C6397B55
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jun 2021 22:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhFAUmS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Jun 2021 16:42:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:45953 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhFAUmS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Jun 2021 16:42:18 -0400
IronPort-SDR: Ka7saZNmeKQvoLrYmmgHMtpsE/ZHrpJqpo5JwS0BA+Ry2cBD5TFBzoO7jZ3t1aOkvcpNNPAN6T
 d59oeBOBSKPw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="183315341"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="183315341"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 13:40:35 -0700
IronPort-SDR: E4N3uAm4SiJy+SRITTbaWr3w5BSWqfxTtqLPYOq6W7rD006EY8smp/y9KS912Cwzmj34Z8ekG7
 Ah5tV3Y0ly0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="447122995"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2021 13:40:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:40:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:40:35 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Tue, 1 Jun 2021 13:40:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Christopher BeSerra <beserra@amazon.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm
 state
Thread-Topic: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm
 state
Thread-Index: AQHXVyFw8ozj2tDfYEeFwI0n0FGBLqsAEouA//+LHPA=
Date:   Tue, 1 Jun 2021 20:40:34 +0000
Message-ID: <1cc039a15b4248e1a625dbb6fc275169@intel.com>
References: <20210601200505.966849-1-tony.luck@intel.com>
 <YLaaLws+4FEHOqQs@zn.tnic>
In-Reply-To: <YLaaLws+4FEHOqQs@zn.tnic>
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

PiBCdXQgSSdtIHVuY2xlYXIgYXMgdG8gd2hhdCB0aGlzIHdob2xlIHVzZSBjYXNlIGlzLiBUaGUg
dmVyeSBmaXJzdA0KPiAiU2NyaXB0cyB0aGF0IHByb2Nlc3MgZXJyb3IgbG9ncyIgYWxyZWFkeSBz
b3VuZHMgbGlrZSBhIGJhZCBpZGVhIC0gSSdkDQo+IGV4cGVjdCB1c2Vyc3BhY2UgY29uc3VtZXJz
IHRvIG9wZW4gdGhlIHRyYWNlX21jZV9yZWNvcmQoKSBhbmQgZ2V0IHRoZQ0KPiBNQ0UgcmVjb3Jk
cyBmcm9tIHRoZXJlLiBBbmQgaW4gdGhhdCBjYXNlIENNQ0kgc3Rvcm0gc2hvdWxkbid0IG1hdHRl
ci4uLg0KDQpJIHRoaW5rIHRoZSBwcm9ibGVtIGlzIGtub3dpbmcgdGhhdCBtYW55IGVycm9ycyBh
cmUgYmVpbmcgbWlzc2VkIGJlY2F1c2UNCm9mIHRoZSBzd2l0Y2ggdG8gcG9sbCBtb2RlLiBBbGwg
bWV0aG9kcyB0byB0cmFjayBlcnJvcnMsIGluY2x1ZGluZyB0aGUgdHJhY2VfbWNlX3JlY29yZCgp
DQp0ZWNobmlxdWUgYXJlIGVxdWFsbHkgYWZmZWN0ZWQgYnkgbWlzc2VkIGVycm9ycy4NCg0KQnV0
IG1heWJlIENocmlzIGNhbiBiZXR0ZXIgZGVzY3JpYmUgd2hhdCB0aGUgcHJvYmxlbSBpcyAuLi4N
Cg0KLVRvbnkNCg==
