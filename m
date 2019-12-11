Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7937111BBA7
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2019 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfLKS0W (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Dec 2019 13:26:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:8449 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbfLKS0W (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Dec 2019 13:26:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 10:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="216011126"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2019 10:26:21 -0800
Message-ID: <158bc5342520a5904625ee503a53a337abb3eba5.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mce/therm_throt: mark throttle_active_work as
 __maybe_unused
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, bberg@redhat.com,
        ckellner@redhat.com, hdegoede@redhat.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Dec 2019 10:26:21 -0800
In-Reply-To: <20191210203925.3119091-1-arnd@arndb.de>
References: <20191210203925.3119091-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2019-12-10 at 21:39 +0100, Arnd Bergmann wrote:
> throttle_active_work() is only called if CONFIG_SYSFS is set,
> otherwise we get a harmless warning:
> 
> arch/x86/kernel/cpu/mce/therm_throt.c:238:13: error:
> 'throttle_active_work' defined but not used [-Werror=unused-function]
> 
> Mark the function as __maybe_unused to avoid the warning.
> 
> Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of
> thermal throttle")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> b/arch/x86/kernel/cpu/mce/therm_throt.c
> index b38010b541d6..8963493a1e9e 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -235,7 +235,7 @@ static void get_therm_status(int level, bool
> *proc_hot, u8 *temp)
>  	*temp = (msr_val >> 16) & 0x7F;
>  }
>  
> -static void throttle_active_work(struct work_struct *work)
> +static void __maybe_unused throttle_active_work(struct work_struct
> *work)
>  {
>  	struct _thermal_state *state =
> container_of(to_delayed_work(work),
>  						struct _thermal_state,
> therm_work);

