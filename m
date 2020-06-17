Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F311FD73B
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 23:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFQV3R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 17:29:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:28951 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQV3R (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 17 Jun 2020 17:29:17 -0400
IronPort-SDR: uirFb1FVNIpZG5vOxlGAA5p5N05+WLw6+NwxWZBSKX2Mc3+2B2spUcut9wIlBjqCWa81Ybmmel
 LxjWd7OXkSsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 14:29:16 -0700
IronPort-SDR: Nsquo/N3cnkdJ5ghBjTUKzDKBJJIKa3ETc5TpnnzUqDnGDJ2VzU1r8DM4MqnPEpLHl04z0NHNV
 Ur6Wai7guEBw==
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="273648327"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 14:29:16 -0700
Date:   Wed, 17 Jun 2020 14:29:15 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] x86/mce/dev-mcelog: Use struct_size() helper in
 kzalloc()
Message-ID: <20200617212915.GA4803@agluck-desk2.amr.corp.intel.com>
References: <20200617211734.GA9636@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211734.GA9636@embeddedor>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 17, 2020 at 04:17:34PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Tony Luck <tony.luck@intel.com>

> ---
>  arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 43c466020ed5..03e51053592a 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -345,7 +345,7 @@ static __init int dev_mcelog_init_device(void)
>  	int err;
>  
>  	mce_log_len = max(MCE_LOG_MIN_LEN, num_online_cpus());
> -	mcelog = kzalloc(sizeof(*mcelog) + mce_log_len * sizeof(struct mce), GFP_KERNEL);
> +	mcelog = kzalloc(struct_size(mcelog, entry, mce_log_len), GFP_KERNEL);
>  	if (!mcelog)
>  		return -ENOMEM;
>  
> -- 
> 2.27.0
> 
