Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEB2EC751
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 01:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAGA1B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 6 Jan 2021 19:27:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:40160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbhAGA1B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 19:27:01 -0500
IronPort-SDR: o8/vI1hVCFNJVpqoMEpkuL/ZlV/rNRmMEpQVTd9EPz0alT1NmgIr3mafNPFChQ/gSuljDsxgpg
 ZUxfbVn+Tj4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="157137153"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="157137153"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 16:26:20 -0800
IronPort-SDR: A/MsPr8dcoH6OiLuLFYlQsyMVjjZvEZfZ2pHdoVvC2tHn4w0pDZuChVAn7DaOmH9/LHLKQJ2Ja
 4QXybMlDycXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="346823662"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2021 16:26:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 16:26:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 16:26:19 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 6 Jan 2021 16:26:19 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Thread-Topic: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Thread-Index: AQHW5FMjkT1VpnYtUUqf+lhaTJjRmaoa6vEAgACTkgD//7UugIAAj7uA//+Jw9A=
Date:   Thu, 7 Jan 2021 00:26:19 +0000
Message-ID: <366fc78e7b8c4474958b289eec31ed25@intel.com>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
 <20210106191708.GB2743@paulmck-ThinkPad-P72>
 <20210106224918.GA7914@agluck-desk2.amr.corp.intel.com>
 <20210106232347.GG2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210106232347.GG2743@paulmck-ThinkPad-P72>
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

> Please see below for an updated patch.

Yes. That worked:

[   78.946069] mce: mce_timed_out: MCE holdout CPUs (may include false positives): 24-47,120-143
[   78.946151] mce: mce_timed_out: MCE holdout CPUs (may include false positives): 24-47,120-143
[   78.946153] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler

I guess that more than one CPU hit the timeout and so your new message was printed twice
before the panic code took over?

Once again, the whole of socket 1 is MIA rather than just the pair of threads on one of the cores there.
But that's a useful improvement (eliminating the other three sockets on this system).

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
