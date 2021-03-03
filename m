Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0632C66C
	for <lists+linux-edac@lfdr.de>; Thu,  4 Mar 2021 02:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbhCDA2t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 3 Mar 2021 19:28:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:42743 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452251AbhCCPoo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 3 Mar 2021 10:44:44 -0500
IronPort-SDR: zz88F/Gjxqvs/Fjg3z1sHEODSFXgPqtDNvXBnRsrW6w0wkTmzk0kbA1kaAnTMnvHifPC4X7sOM
 rtNfN4NIwQhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="248621665"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="248621665"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:41:36 -0800
IronPort-SDR: yXpyJk2j0C04/Bw3RIfI7MJkMU6yQc8k208m+pb6y178O/htKkJuvtbGI8nBza4gRk8qYEZcXm
 rMVoVpqk8uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="600194614"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 03 Mar 2021 07:41:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 07:41:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 07:41:35 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Wed, 3 Mar 2021 07:41:35 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: RE: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCnz5ja9ELypBUEatGW66U99st6pnoa2AgAEgN4CAAIHfAIAAAyEAgAAQXwD//9g7gIABDSmAgAALNoCAB2DqAIAAiu0AgABOzQD//+3L0A==
Date:   Wed, 3 Mar 2021 15:41:35 +0000
Message-ID: <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>  <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
        <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
        <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
        <20210226105915.6cf7d2b8@alex-virtual-machine>
        <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
        <20210303115710.2e9f8e23@alex-virtual-machine>
 <20210303163912.3d508e0f@alex-virtual-machine>
In-Reply-To: <20210303163912.3d508e0f@alex-virtual-machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> For error address with sigbus, i think this is not an issue resulted by the patch i post, before my patch, the issue is already there.
> I don't find a realizable way to get the correct address for same reason --- we don't know whether the page mapping is there or not when
> we got to kill_me_maybe(), in some case, we may get it, but there are a lot of parallel issue need to consider, and if failed we have to fallback
> to the error brach again, remaining current code may be an easy option;

My RFC patch from yesterday removes the uncertainty about whether the page is there or not. After it walks the page
tables we know that the poison page isn't mapped (note that patch is RFC for a reason ... I'm 90% sure that it should
do a bit more that just clear the PRESENT bit).

So perhaps memory_failure() has queued a SIGBUS for this task, if so, we take it when we return from kill_me_maybe()

If not, we will return to user mode and re-execute the failing instruction ... but because the page is unmapped we will take a #PF

The x86 page fault handler will see that the page for this physical address is marked HWPOISON, and it will send the SIGBUS
(just like it does if the page had been removed by an earlier UCNA/SRAO error).

At least that's the theory.

-Tony
