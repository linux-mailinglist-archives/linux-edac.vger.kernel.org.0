Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2472EFBA4
	for <lists+linux-edac@lfdr.de>; Sat,  9 Jan 2021 00:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbhAHXV3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 8 Jan 2021 18:21:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:61583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbhAHXV3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 Jan 2021 18:21:29 -0500
IronPort-SDR: OKevAF1yWfcjb735SjUpv/SGVSoXPdY2EXhxdZAl8Z7mgSpnH9L/TiL8hPsU3i8Pz+7Sh7Q57e
 Mz++l/a14g4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="241743478"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="241743478"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 15:20:48 -0800
IronPort-SDR: XEqiajOjlWKN1/TtNMQNlPeAgQ4e90e5AfWK4VDr2Slw4kJUdOjSJZgp2loe2nG2Pt3HckthJW
 Y5HgT1fPuzGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="568220165"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2021 15:20:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 15:20:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 15:20:47 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Fri, 8 Jan 2021 15:20:47 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 2/2] futex, x86/mce: Avoid double machine checks
Thread-Topic: [PATCH 2/2] futex, x86/mce: Avoid double machine checks
Thread-Index: AQHW5gzS994+pBz0+EqmRhsWwoX/Iaoe2m6A//9/AZCAAIi+gP//exEg
Date:   Fri, 8 Jan 2021 23:20:46 +0000
Message-ID: <1cfc2ca781a24d658063c20829a54f9c@intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210108222251.14391-3-tony.luck@intel.com>
 <20210108224715.GB2453@worktop.programming.kicks-ass.net>
 <4493a015ffcd4d82bbea7d1e5c2e73e4@intel.com>
 <20210108231459.GC2453@worktop.programming.kicks-ass.net>
In-Reply-To: <20210108231459.GC2453@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Yeah, saw that, but that should be trivially fixable I'm thinking.

Trivial, maybe ... but then follows the audit of other get_user() calls:

git grep get_user\( | wc -l
2003

:-(

-Tony
