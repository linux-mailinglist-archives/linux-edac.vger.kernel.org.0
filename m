Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45464243CDB
	for <lists+linux-edac@lfdr.de>; Thu, 13 Aug 2020 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMP4O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Aug 2020 11:56:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:43958 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMP4O (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Aug 2020 11:56:14 -0400
IronPort-SDR: 2nQcvrtXn7w2VLb1haYZ/+vrAMjf1XLkq8s9RAd8TtHklc9BEoO2BQCmzccXk0FAx8Kn2KPTi6
 Jtptq/vkkgsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="172289991"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="172289991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 08:56:13 -0700
IronPort-SDR: jMhzdtnjezyjVPwEYYKKvZzwo20m2IfpFCrAs5K79bc/S720i1AYqzUgJYUVsbrkQCRwjJB1M0
 QIvFiayK2+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="439818253"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2020 08:56:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 08:56:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 08:56:12 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 13 Aug 2020 08:56:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Boris Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>
CC:     Jason Baron <jbaron@akamai.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
Thread-Topic: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
Thread-Index: AQHWW59+1jV2sks7FUC1qHiVi6FaC6k2rbkAgAADSACAAAX2AIAACrMA//+amOA=
Date:   Thu, 13 Aug 2020 15:56:11 +0000
Message-ID: <3d552bacd3ff464a84c743da00f1fc75@intel.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
 <20200813134406.23dvvsulfxend5jx@redhat.com>
 <FE8145F7-A6A9-446F-A13F-3A14CF6E1934@alien8.de>
 <20200813141710.ug5ei4hxoorproi4@redhat.com>
 <31B390C9-0172-4E0D-920C-19D27CA89C4D@alien8.de>
In-Reply-To: <31B390C9-0172-4E0D-920C-19D27CA89C4D@alien8.de>
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
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiA+VGVzdGVkLWJ5OiBWaXNoYWwgQWdyYXdhbCA8dmFncmF3YWxAcmVkaGF0LmNvbT4NCg0KQm9y
aXMsDQoNCkkgYXBwbGllZCB0aGlzIHBhdGNoIHdoZW4gSmFzb24gQmFyb24gc2VudCBhIHJlbWlu
ZGVyIGxhc3Qgd2Vlay4gSXQgaXMgc2l0dGluZyBpbiB0aGUNCmllMzEyMDAgdG9waWMgYnJhbmNo
IG9mIHRoZSBSQVMgdHJlZSAoYW5kIGFsc28gaW4gdGhlIG5leHQgYnJhbmNoIC4uLiBzbyBoYXMg
aGFkIGENCmNvdXBsZSBvZiBkYXlzIGluIGxpbnV4LW5leHQgdG9vKS4NCg0KVGhhdCBjb3B5IGRv
ZXNuJ3QgaGF2ZSB0aGVzZSBBY2tlZC1ieSBhbmQgVGVzdGVkLWJ5IHRhZ3MsIGJ1dCBpcyBvdGhl
cndpc2UgdGhlDQpzYW1lLg0KDQpJIHBsYW4gdG8gc2VuZCBhIHNlY29uZCBlZGFjIHB1bGwgcmVx
dWVzdCB0byBMaW51cyB0b2RheS9yb21vcnJvdyB0byBwaWNrIGl0IHVwLg0KDQotVG9ueQ0KDQog
DQo=
