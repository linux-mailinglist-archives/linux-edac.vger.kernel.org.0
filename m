Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4420B91
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEPPwE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 11:52:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:55405 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfEPPwE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 11:52:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 08:52:03 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2019 08:52:02 -0700
Date:   Thu, 16 May 2019 08:52:02 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190516155202.GA11517@agluck-desk>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430203206.104163-6-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 30, 2019 at 08:32:20PM +0000, Ghannam, Yazen wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 986de830f26e..551366c155ef 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1567,10 +1567,13 @@ static void __mcheck_cpu_init_clear_banks(void)
>  	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>  		struct mce_bank *b = &mce_banks[i];
>  
> -		if (!b->init)
> -			continue;
> -		wrmsrl(msr_ops.ctl(i), b->ctl);
> -		wrmsrl(msr_ops.status(i), 0);
> +		if (b->init) {
> +			wrmsrl(msr_ops.ctl(i), b->ctl);
> +			wrmsrl(msr_ops.status(i), 0);
> +		}
> +
> +		/* Save bits set in hardware. */
> +		rdmsrl(msr_ops.ctl(i), b->ctl);
>  	}
>  }

This looks like it will be a problem for Intel CPUs. If
we take a CPU offline, and then bring it back again, we
ues "b->ctl" to reinitialize the register in mce_reenable_cpu().

But Intel SDM says at the end of section "15.3.2.1 IA32_MCi_CTL_MSRs"

	"P6 family processors only allow the writing of all 1s or all
	0s to the IA32_MCi_CTL MSR."

-Tony
