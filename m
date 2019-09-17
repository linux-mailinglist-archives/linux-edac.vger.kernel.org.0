Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6193B532A
	for <lists+linux-edac@lfdr.de>; Tue, 17 Sep 2019 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfIQQhH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Sep 2019 12:37:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:4489 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfIQQhH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Sep 2019 12:37:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 09:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="201866500"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga001.fm.intel.com with ESMTP; 17 Sep 2019 09:37:05 -0700
Date:   Tue, 17 Sep 2019 09:37:05 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support
Message-ID: <20190917163704.GA1922@agluck-desk2.amr.corp.intel.com>
References: <1da27840413348febf301ef39305de12@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da27840413348febf301ef39305de12@zhaoxin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 17, 2019 at 06:54:05AM +0000, Tony W Wang-oc wrote:
> But have a question about below codes:
> 	if (mcgstatus & MCG_STATUS_RIPV) {
> 		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> 		return true;
> 	}
> These seems require all #MC exception errors set MCG_STATUS_RIPV = 1
> in order to skip synchronize which "return true;" actually does for this.
> 
> As Intel SDM show, "Recoverable-not-continuable SRAR Type" errors may
> set MCG_STATUS_RIPV = 0, PCC = 0. When these #MC errors broadcast
> to offline CPU, may cause kernel panic with synchronize timeout (offline
> CPU can't skip synchronize in this case).
> 
> Could "return true;" outside the if-case?
> 	if (mcgstatus & MCG_STATUS_RIPV) {
> 		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> 	} 
> 	return true; 

If RIPV bit is not set in mcgstatus, then where will the CPU return
to if you simply return from the #MC handler? RIPV=1 means that the
CPU pushed a valid return instruction pointer onto the stack.

E.g. in the not-continuable case you mention above? The CPU
will likely do something undefined if you try to continue a
not-continuable instruction.

-Tony
