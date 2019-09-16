Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB411B3FA7
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfIPRkg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Sep 2019 13:40:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:16443 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfIPRkg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Sep 2019 13:40:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 10:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="386275060"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2019 10:40:34 -0700
Date:   Mon, 16 Sep 2019 10:40:35 -0700
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
Message-ID: <20190916174034.GA21132@agluck-desk2.amr.corp.intel.com>
References: <ff93d38a81ea45848c6b634f72b9b9a5@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff93d38a81ea45848c6b634f72b9b9a5@zhaoxin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 16, 2019 at 11:37:18AM +0000, Tony W Wang-oc wrote:
> Zhaoxin newer CPUs support LMCE that compatible with Intel's
> "Machine-Check Architecture", so add support for Zhaoxin LMCE
> in mce/core.c.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 65c5a1f..acdd76b 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1132,6 +1132,27 @@ static bool __mc_check_crashing_cpu(int cpu)
>  		u64 mcgstatus;
>  
>  		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
> +			if (mcgstatus & MCG_STATUS_LMCES)
> +				return false;
> +
> +			if (!(mcgstatus & MCG_STATUS_LMCES)) {

Don't really need this test ... you already did "return false" if 
the LMCES bit was set ... so this test is redundant (and you can avoid
indenting the next dozen lines.

> +				/*
> +				 * Clear the MCG_STATUS_RIPV valid status
> +				 * bit so that a second MCE won't cause a
> +				 * shutdown.
> +				 */
> +				if (mcgstatus & MCG_STATUS_RIPV)
> +					mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +				/*
> +				 * On this CPU, skip synchronize regardless
> +				 * of MCG_STATUS_RIPV status.
> +				 */
> +				return true;
> +			}
> +		}
> +

Otherwise I'm OK with the series.  May earlier comment about
wanting to clean up all the vendor/family/model checks should
be seen as a longer term goal. I don't want to block this waiting
until the day we figure out how to make this prettier.

-Tony

[The "Content-Language: zh-CN" in the mail headers is still freaking out
my version of mutt (Mutt 1.11.3 (2019-02-01)) ... but I figured out a
simple script to dowload a raw copy of each patch from lore.kernel.org
to work around that]
