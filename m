Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429BD1690FF
	for <lists+linux-edac@lfdr.de>; Sat, 22 Feb 2020 18:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBVRwD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 22 Feb 2020 12:52:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgBVRwA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 22 Feb 2020 12:52:00 -0500
Received: from zn.tnic (p200300EC2F1C5400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:5400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A2281EC0C2B;
        Sat, 22 Feb 2020 18:51:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582393918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+k6vcshKzlOrgLczSsM+NviqJvVFIej9VdfUzXk4rKw=;
        b=iPp3t+d2hLwXdK9KVbZ1Q/pMALh9+LAmxFGWPePZ/HbxwA1eHQqOBewIIbSUdos66lL1TQ
        4NFMwGEOglbBtnIrKTyDgAd8tERR3eFaXN3Cz6KAwctN4zIhuyqmc7kxHbIHgxQ94BTmNn
        vIsldXPWISxQOFFD57mByBsNC7/djcg=
Date:   Sat, 22 Feb 2020 18:51:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where
 throttle_active_work() is called on behalf of an offline CPU
Message-ID: <20200222175151.GD11284@zn.tnic>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Feb 22, 2020 at 08:24:32AM -0800, Srinivas Pandruvada wrote:
> During cpu-hotplug test with CONFIG_PREEMPTION and CONFIG_DEBUG_PREEMPT
> enabled, Chris reported error:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/1:0/17
> caller is throttle_active_work+0x12/0x280
> 
> Here throttle_active_work() is a work queue callback scheduled with
> schedule_delayed_work_on(). This will not cause this error for the use
> of smp_processor_id() under normal conditions as there is a check for
> "current->nr_cpus_allowed == 1".
> But when the target CPU is offline the workqueue becomes unbound.
> Then the work queue callback can be scheduled on another CPU and the
> error is printed for the use of smp_processor_id() in preemptible context.

So what's wrong with simply doing:

	if (cpu_is_offline(this_cpu))
		return;

?

You don't need to run the callback on an offlined CPU anyway...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
