Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39671BAC2C
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgD0STG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 14:19:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:60964 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgD0STG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Apr 2020 14:19:06 -0400
IronPort-SDR: r8hrnD4xEQX1NDqO/iu7uKHjsAi08s3lzBcBATeDGb/wY4epqo3xGV85hPrppI5oMiym4415zX
 vEX6GgPs+BGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 11:19:05 -0700
IronPort-SDR: hSKJ2wdAprtTNItd6V6pDBVhSbvJd5aRenMEOiIvofuY60dco2kW9JvJpMOq/llW/NPn/9bOPv
 CnlV9y/RuQng==
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="247480665"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 11:19:04 -0700
Date:   Mon, 27 Apr 2020 11:19:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Add compat_ioctl assignment to make it
 compatible with 32-bit system
Message-ID: <20200427181903.GA14473@agluck-desk2.amr.corp.intel.com>
References: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
 <1f449e01-3207-b699-b91f-d1c04626a447@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f449e01-3207-b699-b91f-d1c04626a447@windriver.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 16, 2020 at 04:40:31PM +0800, He Zhe wrote:
> Can this be considered for the moment?
> 
> Thanks,
> Zhe
> 
> On 3/4/20 2:39 PM, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> >
> > 32-bit user-space program would get errors like the following from ioctl
> > syscall due to missing compat_ioctl.
> > MCE_GET_RECORD_LEN: Inappropriate ioctl for device
> >
> > compat_ptr_ioctl is provided as a generic implementation of .compat_ioctl
> > file operation to ioctl functions that either ignore the argument or pass
> > a pointer to a compatible data type.

I'm not super-familiar with the compat ioctl bits.  But this looks plausible.

All three of the ioctl's for this driver have a "pointer to integer" for the
"return" value.  And "int" is a compatible type between i386 and x86_64.

I don't have a system setup to build a 32-bit binary to test the theory,
but I assume that you have built something that tests all three:

	MCE_GET_RECORD_LEN
	MCE_GET_LOG_LEN
	MCE_GETCLEAR_FLAGS

So I guess:

Acked-by: Tony Luck <tony.luck@intel.com>

> >
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > ---
> >  arch/x86/kernel/cpu/mce/dev-mcelog.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> > index 7c8958d..6c9b91b7 100644
> > --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> > +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> > @@ -328,6 +328,7 @@ static const struct file_operations mce_chrdev_ops = {
> >  	.write			= mce_chrdev_write,
> >  	.poll			= mce_chrdev_poll,
> >  	.unlocked_ioctl		= mce_chrdev_ioctl,
> > +	.compat_ioctl		= compat_ptr_ioctl,
> >  	.llseek			= no_llseek,
> >  };
> >  
> 
