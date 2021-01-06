Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863C02EC347
	for <lists+linux-edac@lfdr.de>; Wed,  6 Jan 2021 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFSkO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 6 Jan 2021 13:40:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:49511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFSkN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 13:40:13 -0500
IronPort-SDR: kAh8FNVs7mTxvjzKHRw5zW5hzCRUxrFU4mJ5x49hN9r3ekZm2He6AzI+iFOfCpDLNxUF37VZoR
 YSMKh4r6FUfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="176540886"
X-IronPort-AV: E=Sophos;i="5.79,327,1602572400"; 
   d="scan'208";a="176540886"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 10:39:32 -0800
IronPort-SDR: tc9npouO/88MZ33Lrtz0TlvT9Z/MC7cNMF++1tOZ+hicHff1sqsywpS3LyG7gAJSNLP5GMYWNo
 memD1sDdr3WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,327,1602572400"; 
   d="scan'208";a="350304902"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2021 10:39:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 10:39:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 10:39:30 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 6 Jan 2021 10:39:30 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Thread-Topic: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Thread-Index: AQHW5FMjkT1VpnYtUUqf+lhaTJjRmaoa6vEA
Date:   Wed, 6 Jan 2021 18:39:30 +0000
Message-ID: <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
In-Reply-To: <20210106174102.GA23874@paulmck-ThinkPad-P72>
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

> The "Timeout: Not all CPUs entered broadcast exception handler" message
> will appear from time to time given enough systems, but this message does
> not identify which CPUs failed to enter the broadcast exception handler.
> This information would be valuable if available, for example, in order to
> correlated with other hardware-oriented error messages.  This commit
> therefore maintains a cpumask_t of CPUs that have entered this handler,
> and prints out which ones failed to enter in the event of a timeout.

I tried doing this a while back, but found that in my test case where I forced
an error that would cause both threads from one core to be "missing", the
output was highly unpredictable. Some random number of extra CPUs were
reported as missing. After I added some extra breadcrumbs it became clear
that pretty much all the CPUs (except the missing pair) entered do_machine_check(),
but some got hung up at various points beyond the entry point. My only theory
was that they were trying to snoop caches from the dead core (or access some
other resource held by the dead core) and so they hung too.

Your code is much neater than mine ... and perhaps works in other cases, but
maybe the message needs to allow for the fact that some of the cores that
are reported missing may just be collateral damage from the initial problem.

If I get time in the next day or two, I'll run my old test against your code to
see what happens.

-Tony
