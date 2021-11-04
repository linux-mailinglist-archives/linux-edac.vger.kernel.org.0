Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5B44568E
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKDPvX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 11:51:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:14549 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhKDPvX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 11:51:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="218926795"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="218926795"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 08:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="730096467"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2021 08:47:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 4 Nov 2021 08:47:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 4 Nov 2021 08:47:36 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Thu, 4 Nov 2021 08:47:36 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Zhaolong Zhang <zhangzl2013@126.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mce: correct cpu_missing reporting in mce_timed_out
Thread-Topic: [PATCH] x86/mce: correct cpu_missing reporting in mce_timed_out
Thread-Index: AQHX0VACTTZXC2qgzkKbgYjusGnqVqvzix0A///4IaA=
Date:   Thu, 4 Nov 2021 15:47:36 +0000
Message-ID: <442373b1384e4607ba743de4c09df670@intel.com>
References: <20211104074431.1091525-1-zhangzl2013@126.com>
 <YYOkKm8UmmIxSdXF@zn.tnic>
In-Reply-To: <YYOkKm8UmmIxSdXF@zn.tnic>
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

PiBGcmFua2x5LCB3ZSBtaWdodCBqdXN0IGFzIHdlbGwga2lsbCB0aGF0IGNwdV9taXNzaW5nIHRo
aW5nIGJlY2F1c2Ugd2UNCj4gYWxyZWFkeSBzYXkgdGhhdCBzb21lIENQVXMgYXJlIG5vdCByZXNw
b25kaW5nLg0KDQpZZXMuIFRoZSBtb3JlIHJlY2VudCBjb21taXQ6DQoNCjdiYjM5MzEzY2Q2MiAo
Ing4Ni9tY2U6IE1ha2UgbWNlX3RpbWVkX291dCgpIGlkZW50aWZ5IGhvbGRvdXQgQ1BVcyIpDQoN
CnRyaWVzIHRvIHByb3ZpZGUgdGhlIG1vcmUgZGV0YWlsZWQgbWVzc2FnZSBhYm91dCAqd2hpY2gq
IENQVXMgYXJlIG1pc3NpbmcNCg0KPiBUb255LCBkbyB5b3Ugc2VlIGFueSByZWFsIG5lZWQgdG8g
a2VlcCBpdD8NCg0KSSB0aGluayBjcHVfbWlzc2luZyBjYW4gYmUgZHJvcHBlZC4NCg0KLVRvbnkN
Cg==
