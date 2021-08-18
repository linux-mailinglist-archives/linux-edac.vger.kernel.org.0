Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5F3F08CD
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHRQPQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 18 Aug 2021 12:15:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:23695 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229619AbhHRQPQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Aug 2021 12:15:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="280102579"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="280102579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 09:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="641385365"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2021 09:14:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 09:14:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 09:14:39 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Wed, 18 Aug 2021 09:14:39 -0700
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
Subject: RE: [PATCH v2 0/3] More machine check recovery fixes
Thread-Topic: [PATCH v2 0/3] More machine check recovery fixes
Thread-Index: AQHXk8gpkFvZ1Gbe80CQzogjtbcrGqt5byJw
Date:   Wed, 18 Aug 2021 16:14:38 +0000
Message-ID: <f5fafffacaa746dab99bec1b788383d4@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
In-Reply-To: <20210818002942.1607544-1-tony.luck@intel.com>
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

> Changes since v1:
> 1) Fix bug in kill_me_never() that forgot to clear p->mce_count so
>   repeated recovery in the same task would trigger the panic for
>	"Machine checks to different user pages"
>   [Note to Jue Wang ... this *might* be why your test that injects
>    two errors into the same buffer passed to a write(2) syscall
>    failed with this message]

I recreated Jue's specific test today with uncorrected errors in two
pages passed to a write(2) syscall.

	buf = alloc(2 pages);
	inject(buf + 0x440);
	inject*buf + 0x11c0);
	n = write(fd, buf, 8K);

Result was that the write returned 0x440 (i.e. bytes written up to the
first poison location).

-Tony
