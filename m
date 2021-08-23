Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACC3F52EE
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhHWVmi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 17:42:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:47765 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbhHWVme (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 17:42:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="239328157"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="239328157"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 14:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="493164511"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2021 14:41:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 23 Aug 2021 14:41:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 23 Aug 2021 14:41:50 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Mon, 23 Aug 2021 14:41:50 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: RE: [PATCH v2] x86/mce: Defer processing early errors until
 mcheck_late_init()
Thread-Topic: [PATCH v2] x86/mce: Defer processing early errors until
 mcheck_late_init()
Thread-Index: AQHXmF89Oz8u+YQnM02rBs/rAfFp9quCBeKA//+XZ8A=
Date:   Mon, 23 Aug 2021 21:41:50 +0000
Message-ID: <d0c96c2ba2ff45d6afc593a18f3893fb@intel.com>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
 <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
 <YR/Oxark0bhLlona@zn.tnic>
 <20210823184547.GA1638691@agluck-desk2.amr.corp.intel.com>
 <20210823204122.GA1640015@agluck-desk2.amr.corp.intel.com>
 <YSQKT0NPrx6puVUQ@zn.tnic>
In-Reply-To: <YSQKT0NPrx6puVUQ@zn.tnic>
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

KwlNQ1BfTE9HX09OTFkJPSBCSVQoMyksCS8qIGxvZyBvbmx5ICovDQoNClRoYXQgbG9va3Mgbmlj
ZSAuLi4gZXhjZXB0IGZvciB0aGUgbmFtZSAmIGNvbW1lbnQgaGVyZS4gVGhleSBkb24ndA0KcmVh
bGx5IGNhcHR1cmUgd2hhdCB0aGlzIGZsYWcgYml0IGRvZXMuDQoNCk1heWJlDQoNCglNQ1BfUVVF
VUVfTE9HCT0gQklUKDMpLAkvKiBKdXN0IHF1ZXVlIHRvIGdlbnBvb2wgKi8NCg0KLVRvbnkNCg==
