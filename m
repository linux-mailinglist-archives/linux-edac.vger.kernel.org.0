Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD721A7209
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 05:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgDNDz6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 23:55:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:55254 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgDNDz5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Apr 2020 23:55:57 -0400
IronPort-SDR: wQefF3Ufyl6QElO6HZomZKHX62kvB2KE6CEnooVivTbMAlN5MiNgOr2WO7OEuQcGxZopsFBBfw
 o28AeEVdzNjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 20:55:56 -0700
IronPort-SDR: vzBTEWecsrmKI4L9C7YiW1yyInHNJ3i4lIT4gQGtWjIi+WnNK/AuRWIIcxjwPuLxsO7+5VA5Ev
 8a6ExhrjiMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="399825341"
Received: from spandruv-mobl3.jf.intel.com (HELO yzrodnik-mobl.amr.corp.intel.com) ([10.251.1.193])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 20:55:55 -0700
Message-ID: <bad9e0bd5504df83092c7add2d84331e164b60cc.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] x86/mce/therm_throt: remove unused
 platform_thermal_notify function pointer
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, bberg@redhat.com, bp@suse.de
Date:   Mon, 13 Apr 2020 20:55:55 -0700
In-Reply-To: <20200407063345.4484-1-Jason@zx2c4.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> A long time ago platform_thermal_notify was added as some generic
> mechanism for platform drivers to hook thermal events. It seems as
> though this has been entirely superseded, and nothing uses it. Remove
> the plumbing for this, since this code runs in an interrupt hot path.
Good idea.

Thanks,
Srinivas

> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/include/asm/mce.h            |  3 ---
>  arch/x86/kernel/cpu/mce/therm_throt.c | 25 -------------------------
>  2 files changed, 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 4359b955e0b7..ee30cb60ad36 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -257,9 +257,6 @@ extern void (*deferred_error_int_vector)(void);
>  
>  void intel_init_thermal(struct cpuinfo_x86 *c);
>  
> -/* Interrupt Handler for core thermal thresholds */
> -extern int (*platform_thermal_notify)(__u64 msr_val);
> -
>  /* Interrupt Handler for package thermal thresholds */
>  extern int (*platform_thermal_package_notify)(__u64 msr_val);
>  
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> b/arch/x86/kernel/cpu/mce/therm_throt.c
> index f36dc0742085..f904e85eb68f 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -105,10 +105,6 @@ struct thermal_state {
>  	struct _thermal_state pkg_thresh1;
>  };
>  
> -/* Callback to handle core threshold interrupts */
> -int (*platform_thermal_notify)(__u64 msr_val);
> -EXPORT_SYMBOL(platform_thermal_notify);
> -
>  /* Callback to handle core package threshold_interrupts */
>  int (*platform_thermal_package_notify)(__u64 msr_val);
>  EXPORT_SYMBOL_GPL(platform_thermal_package_notify);
> @@ -551,24 +547,6 @@ static void notify_package_thresholds(__u64
> msr_val)
>  		platform_thermal_package_notify(msr_val);
>  }
>  
> -static void notify_thresholds(__u64 msr_val)
> -{
> -	/* check whether the interrupt handler is defined;
> -	 * otherwise simply return
> -	 */
> -	if (!platform_thermal_notify)
> -		return;
> -
> -	/* lower threshold reached */
> -	if ((msr_val & THERM_LOG_THRESHOLD0) &&
> -			thresh_event_valid(CORE_LEVEL, 0))
> -		platform_thermal_notify(msr_val);
> -	/* higher threshold reached */
> -	if ((msr_val & THERM_LOG_THRESHOLD1) &&
> -			thresh_event_valid(CORE_LEVEL, 1))
> -		platform_thermal_notify(msr_val);
> -}
> -
>  /* Thermal transition interrupt handler */
>  static void intel_thermal_interrupt(void)
>  {
> @@ -579,9 +557,6 @@ static void intel_thermal_interrupt(void)
>  
>  	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
>  
> -	/* Check for violation of core thermal thresholds*/
> -	notify_thresholds(msr_val);
> -
>  	therm_throt_process(msr_val & THERM_STATUS_PROCHOT,
>  			    THERMAL_THROTTLING_EVENT,
>  			    CORE_LEVEL);

