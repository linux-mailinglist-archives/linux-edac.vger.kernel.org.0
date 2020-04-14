Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4651A71E7
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 05:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404855AbgDNDiQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 23:38:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:26962 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404832AbgDNDiP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Apr 2020 23:38:15 -0400
IronPort-SDR: dyc1zlGx/EIIM4TQgsOuh3kf6WmIWEQu5Y90i7/vrMYBFUFzr/2hbPipkXD1r60DW10QNcQjm6
 Wte4zGCOtIEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 20:38:13 -0700
IronPort-SDR: ryRMdczRXeSt3REPgNY/dx33Icm2zTQ9iZq8E8txQlawLMOHHC0nHj1aJFMwt+4oqBphRTj2tb
 3g5CdKDWAuGQ==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="277118965"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.229.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 20:38:13 -0700
Message-ID: <0e189a4fe1e69b08afc859ce83623a0e5ea0c08b.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, bberg@redhat.com, bp@suse.de
Date:   Mon, 13 Apr 2020 20:38:12 -0700
In-Reply-To: <20200407063345.4484-3-Jason@zx2c4.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
         <20200407063345.4484-3-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> The thermal IRQ handler uses 1.21% CPU on my system when it's hot
> from
> compiling things. Indeed looking at /proc/interrupts reveals quite a
> lot
I am curious why you are hitting threshold frequently?
What is rdmsr 0x1a2


> of events coming in. Beyond logging them, the existing drivers on the
> system don't appear to do very much that I'm interested in. So, add a
> way to disable this entirely so that I can regain precious CPU
> cycles.
It is showing amount of time system is running in a constrained
environment. Lots of real time and HPC folks really care about this.

Thanks,
Srinivas

> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/Kconfig                | 4 ++++
>  arch/x86/kernel/cpu/mce/intel.c | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 39e7444353af..3125a11932f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1157,7 +1157,11 @@ config X86_MCE_INJECT
>  
>  config X86_THERMAL_VECTOR
>  	def_bool y
> +	prompt "Machine check thermal vector"
>  	depends on X86_MCE_INTEL
> +	---help---
> +	  Provide support for capturing thermal events, logging them,
> and
> +	  passing them off to other drivers.
>  
>  config X86_MCE_THERMAL_VERBOSE
>  	bool "Verbose logging for thermal events"
> diff --git a/arch/x86/kernel/cpu/mce/intel.c
> b/arch/x86/kernel/cpu/mce/intel.c
> index f996ffb887bc..d14f1922fb49 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -511,7 +511,8 @@ static void intel_ppin_init(struct cpuinfo_x86
> *c)
>  
>  void mce_intel_feature_init(struct cpuinfo_x86 *c)
>  {
> -	intel_init_thermal(c);
> +	if (IS_ENABLED(CONFIG_X86_THERMAL_VECTOR))
> +		intel_init_thermal(c);
>  	intel_init_cmci();
>  	intel_init_lmce();
>  	intel_ppin_init(c);

