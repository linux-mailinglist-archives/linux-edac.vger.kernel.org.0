Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71C30CE91
	for <lists+linux-edac@lfdr.de>; Tue,  2 Feb 2021 23:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhBBWM4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Feb 2021 17:12:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:43374 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234706AbhBBWMv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Feb 2021 17:12:51 -0500
IronPort-SDR: 00h68qkAOAN9KnAySTFuQOExcvsjkdOMyl8dujB2FyMLCwShaqyhjk4SaQwsXJj3UKxDU5kkti
 xsF43/Bbs6wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160704518"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160704518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:12:07 -0800
IronPort-SDR: w126W91cTxhj9RDnAU3n/zMgWaUBBy6DDJyPibqCceUyqSoGT4ZpmHZyvkdqEklQvd4+cWeeUX
 X0kaj3ozw/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="579200629"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2021 14:12:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 14:12:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 14:12:06 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Tue, 2 Feb 2021 14:12:06 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Darren Hart" <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHW820jWhd/BlkCukOtPpk65S5gH6o6RPEAgAA7fACAA1zygIAF1CqAgAGTOQD//8zdUIAA3A0A//+LxOA=
Date:   Tue, 2 Feb 2021 22:12:06 +0000
Message-ID: <6e719355ea7f472e94b5bd45105c7ebe@intel.com>
References: <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
 <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
 <20210128175735.GB2120@zn.tnic>
 <20210201185812.GA54867@agluck-desk2.amr.corp.intel.com>
 <20210202110126.GB18075@zn.tnic> <d99c43608909400199e9384bb7425beb@intel.com>
 <20210202210600.GF18075@zn.tnic>
In-Reply-To: <20210202210600.GF18075@zn.tnic>
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

PiBTbyB0aGF0ICJzeXN0ZW0gaGFuZyBvciBwYW5pYyIgd2hpY2ggdGhlIHZhbGlkYXRpb24gZm9s
a3MgdHJpZ2dlcmVkLA0KPiB0aGF0IGNhbm5vdCBiZSByZXByb2R1Y2VkIGFueW1vcmU/IERpZCB0
aGV5IHJ1biB0aGUgbGF0ZXN0IHZlcnNpb24gb2YNCj4gdGhlIHBhdGNoPw0KDQpJIHdpbGwgZ2V0
IHRoZSB2YWxpZGF0aW9uIGZvbGtzIHRvIHJ1biB0aGUgbGF0ZXN0IHZlcnNpb24gKGFuZCBwbGF5
IGFyb3VuZCB3aXRoDQpoeXBlcnRocmVhZGluZyBpZiB0aGV5IHNlZSBwcm9ibGVtcykuDQoNCi1U
b255DQo=
