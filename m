Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0B20FCD
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 22:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfEPU7p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 16:59:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:5975 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfEPU7o (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 16:59:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 13:59:43 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2019 13:59:43 -0700
Date:   Thu, 16 May 2019 13:59:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190516205943.GA3299@agluck-desk>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516203456.GD21857@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 16, 2019 at 10:34:56PM +0200, Borislav Petkov wrote:
> On Thu, May 16, 2019 at 08:20:58PM +0000, Ghannam, Yazen wrote:
> > We don't actually know if there are bits set in hardware until we read
> > it back. So I don't think this is adding anything new.
> 
> Bah, of course. We need to read it first (pasting the whole function).
> Now, __mcheck_cpu_init_clear_banks() gets called when we change
> configuration too, in mce_cpu_restart() and if we do it this way, we'll
> be rereading MCi_CTL each time but I don't see anything wrong with that.

Intel doesn't "set any bits in hardware" ... so I think you'll just
get a 0x0 and disable everything.

> 
> Hmmm?
> 
> static void __mcheck_cpu_init_clear_banks(void)
> {
>         struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
>         int i;
> 
>         for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>                 struct mce_bank *b = &mce_banks[i];
> 
>                 rdmsrl(msr_ops.ctl(i), b->ctl);
> 
>                 /* Bank is initialized if bits are set in hardware. */
>                 b->init = !!b->ctl;
>                 if (b->init) {
>                         wrmsrl(msr_ops.ctl(i), b->ctl);
>                         wrmsrl(msr_ops.status(i), 0);
>                 }
> 
>         }
> }


I think the intent of the original patch was to find out
which bits are "implemented in hardware". I.e. throw all
1's at the register and see if any of them stick.

I don't object to the idea behind the patch. But if you want
to do this you just should not modify b->ctl.

So something like:
	

static void __mcheck_cpu_init_clear_banks(void)
{
        struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
	u64 tmp;
        int i;

        for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
                struct mce_bank *b = &mce_banks[i];

                if (b->init) {
                        wrmsrl(msr_ops.ctl(i), b->ctl);
                        wrmsrl(msr_ops.status(i), 0);
			rdmsrl(msr_ops.ctl(i), tmp);

			/* Check if any bits implemented in h/w */
			b->init = !!tmp;
                }

        }
}

-Tony

-Tony
