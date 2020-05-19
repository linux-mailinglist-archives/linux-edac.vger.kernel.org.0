Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D211DA28E
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgESUZn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgESUZn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 May 2020 16:25:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8EC08C5C0;
        Tue, 19 May 2020 13:25:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b87001461a870af27ee92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:1461:a870:af27:ee92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C7E61EC02A7;
        Tue, 19 May 2020 22:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589919941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0KQyk6eHRwREL78mJ6GkGFFWFdrtxrD703khoZRYXS8=;
        b=Jrs74L0jyryYiOWqzSGi+NpM7qxfVX2uWG3+US/KKWLVeV+2W1/gipMtwlAgsEHhaAmaPI
        c74gjETApzBnmXYJSYN9ZhJ1HwSYsIENOf6iIHMdYdmahX6eYhGsjTRUn382XO7cB/ctdt
        wqE6Wd7LmqQ6SCdGBvhe5+vvQ+E7z10=
Date:   Tue, 19 May 2020 22:25:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/ghes: Setup DIMM label from DMI and use it in
 error reports
Message-ID: <20200519202535.GC444@zn.tnic>
References: <20200518095852.28010-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518095852.28010-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 18, 2020 at 11:58:52AM +0200, Robert Richter wrote:
> +static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
> +{
> +	const char *bank = NULL, *device = NULL;
> +
> +	dmi_memdev_name(handle, &bank, &device);
> +
> +	/* both strings must be non-zero */
> +	if (bank && *bank && device && *device)
> +		snprintf(dimm->label, sizeof(dimm->label),
> +			"%s %s", bank, device);
> +	else
> +		snprintf(dimm->label, sizeof(dimm->label),
> +			"unknown memory (handle: 0x%.4x)", handle);

This changes the sysfs strings on my test box like this. 00-ghes.before
and 01-ghes.after are created by doing:

grep -EriIn . /sys/devices/system/edac/ 2>/dev/null > [filename]

edac_mc_alloc_dimms() already sets the dimm->label to "mc#%dmemory#%d"
but I'm guessing that dmi_memdev_name() doesn't give on my machine what
it gives on yours.

Welcome to the wonderful world of consistently implemented firmware!

--- 00-ghes.before      2020-05-19 17:55:50.821220239 +0200
+++ 01-ghes.after       2020-05-19 22:09:28.808492701 +0200
@@ -17,7 +17,7 @@
 /sys/devices/system/edac/mc/mc0/ce_count:1:0
 /sys/devices/system/edac/mc/mc0/mc_name:1:ghes_edac
 /sys/devices/system/edac/mc/mc0/csrow15/ce_count:1:0
-/sys/devices/system/edac/mc/mc0/csrow15/ch0_dimm_label:1:mc#0memory#15
+/sys/devices/system/edac/mc/mc0/csrow15/ch0_dimm_label:1:unknown memory (handle: 0x0030)
 /sys/devices/system/edac/mc/mc0/csrow15/power/runtime_active_time:1:0
 /sys/devices/system/edac/mc/mc0/csrow15/power/runtime_active_kids:1:0
 /sys/devices/system/edac/mc/mc0/csrow15/power/runtime_usage:1:0
@@ -42,7 +42,7 @@
 /sys/devices/system/edac/mc/mc0/power/runtime_enabled:1:disabled & forbidden
 /sys/devices/system/edac/mc/mc0/power/control:1:on
 /sys/devices/system/edac/mc/mc0/csrow31/ce_count:1:0
-/sys/devices/system/edac/mc/mc0/csrow31/ch0_dimm_label:1:mc#0memory#31
+/sys/devices/system/edac/mc/mc0/csrow31/ch0_dimm_label:1:unknown memory (handle: 0x0040)
 /sys/devices/system/edac/mc/mc0/csrow31/power/runtime_active_time:1:0
 /sys/devices/system/edac/mc/mc0/csrow31/power/runtime_active_kids:1:0
 /sys/devices/system/edac/mc/mc0/csrow31/power/runtime_usage:1:0
@@ -73,10 +73,10 @@
 /sys/devices/system/edac/mc/mc0/dimm15/dimm_dev_type:1:Unknown
 /sys/devices/system/edac/mc/mc0/dimm15/size:1:32768
 /sys/devices/system/edac/mc/mc0/dimm15/dimm_ce_count:1:0
-/sys/devices/system/edac/mc/mc0/dimm15/dimm_label:1:mc#0memory#15
+/sys/devices/system/edac/mc/mc0/dimm15/dimm_label:1:unknown memory (handle: 0x0030)
 /sys/devices/system/edac/mc/mc0/dimm15/dimm_location:1:memory 15 
 /sys/devices/system/edac/mc/mc0/dimm15/dimm_edac_mode:1:SECDED
-/sys/devices/system/edac/mc/mc0/seconds_since_reset:1:354
+/sys/devices/system/edac/mc/mc0/seconds_since_reset:1:979
 /sys/devices/system/edac/mc/mc0/dimm31/dimm_ue_count:1:0
 /sys/devices/system/edac/mc/mc0/dimm31/dimm_mem_type:1:Registered-DDR4
 /sys/devices/system/edac/mc/mc0/dimm31/power/runtime_active_time:1:0
@@ -90,7 +90,7 @@
 /sys/devices/system/edac/mc/mc0/dimm31/dimm_dev_type:1:Unknown
 /sys/devices/system/edac/mc/mc0/dimm31/size:1:32768
 /sys/devices/system/edac/mc/mc0/dimm31/dimm_ce_count:1:0
-/sys/devices/system/edac/mc/mc0/dimm31/dimm_label:1:mc#0memory#31
+/sys/devices/system/edac/mc/mc0/dimm31/dimm_label:1:unknown memory (handle: 0x0040)
 /sys/devices/system/edac/mc/mc0/dimm31/dimm_location:1:memory 31 
 /sys/devices/system/edac/mc/mc0/dimm31/dimm_edac_mode:1:SECDED
 /sys/devices/system/edac/mc/mc0/max_location:1:memory 31

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
