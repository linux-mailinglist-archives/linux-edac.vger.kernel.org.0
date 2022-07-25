Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9D57FCBA
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGYJxS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiGYJxP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 05:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD17117043;
        Mon, 25 Jul 2022 02:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DC2612BF;
        Mon, 25 Jul 2022 09:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE32FC341D1;
        Mon, 25 Jul 2022 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658742792;
        bh=3Of89sNRXE/Vbn0w1Oznoltg2EhIG+oKSB5/Rfm3G2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpABwVkf4r1Q6BkyuC/FxNwBzc4NMFsKn6lgPnh4OLqhM/rXtCn/q/3EAOCMc0+De
         kPa2kYc1yy4M4qBX7bc9abghSKDXGXccKyTPiFbMNcOjTwrrlYbK3C1JkBQuqHBkOO
         RERh7lsN9yE8rUz8zMzBXqKUrt61JmmgG9NzNfMFkYsfxZQdVetqVY93gLopdIGxz2
         kwXDV9wEl/EinvsmNJDNq3ksTwDcmnBV/c36iEXpc5+ofyaQo5b70q1AadBoeMGRzl
         DKREVJVuwO9c/aR1b1wGwmymxRv66PXD/gqmkVvz2aUSHRkaDXhB4JIRafsbIa1M7B
         9UNHRU3xmKeEA==
Date:   Mon, 25 Jul 2022 11:53:06 +0200
From:   Robert Richter <rric@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org,
        elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <Yt5oAjbZ5Koy9v5i@rric.localdomain>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtqkMicKdZdPdUWB@zn.tnic>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 22.07.22 15:20:50, Borislav Petkov wrote:
> + fix Robert's address.
> 
> On Thu, Jul 21, 2022 at 12:05:03PM -0600, Toshi Kani wrote:
> > The following buffer overflow BUG was observed on an HPE system.
> > ghes_edac_register() called strlen() on an uninitialized label,
> > which had non-zero values from krealloc_array().
> 
> I ended up massaging it into this:
> 
> ---
> From: Toshi Kani <toshi.kani@hpe.com>
> Date: Thu, 21 Jul 2022 12:05:03 -0600
> Subject: [PATCH] EDAC/ghes: Set the DIMM label unconditionally
> 
> The commit in Fixes enforced that both the bank and device strings
> passed to dimm_setup_label() are not NULL.
> 
> However, there are BIOSes, for example on a
> 
>   HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/15/2019
> 
> which don't populate both strings:
> 
>   Handle 0x0020, DMI type 17, 84 bytes
>   Memory Device
>           Array Handle: 0x0013
>           Error Information Handle: Not Provided
>           Total Width: 72 bits
>           Data Width: 64 bits
>           Size: 32 GB
>           Form Factor: DIMM
>           Set: None
>           Locator: PROC 1 DIMM 1        <===== device
>           Bank Locator: Not Specified   <===== bank
> 
> This results in a buffer overflow because ghes_edac_register() calls
> strlen() on an uninitialized label, which had non-zero values left over
> from krealloc_array():
> 
>   detected buffer overflow in __fortify_strlen
>    ------------[ cut here ]------------
>    kernel BUG at lib/string_helpers.c:983!
>    invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          I       5.18.6-200.fc36.x86_64 #1
>    Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/15/2019
>    RIP: 0010:fortify_panic
>    ...
>    Call Trace:
>     <TASK>
>     ghes_edac_register.cold
>     ghes_probe
>     platform_probe
>     really_probe
>     __driver_probe_device
>     driver_probe_device
>     __driver_attach
>     ? __device_attach_driver
>     bus_for_each_dev
>     bus_add_driver
>     driver_register
>     acpi_ghes_init
>     acpi_init
>     ? acpi_sleep_proc_init
>     do_one_initcall
> 
> Change dimm_setup_label() to always initialize the label and use
> "N/A" in case bank or device is null.
> 
>   [ bp: Rewrite commit message. ]
> 
> Fixes: cb51a371d08e ("EDAC/ghes: Setup DIMM label from DMI and use it in error reports")
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Tested-by: Robert Elliott <elliott@hpe.com>
> Link: https://lore.kernel.org/r/20220719220124.760359-1-toshi.kani@hpe.com
> ---
>  drivers/edac/ghes_edac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 59b0bedc9c24..fcab10e26b43 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -103,9 +103,9 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
>  
>  	dmi_memdev_name(handle, &bank, &device);
>  
> -	/* both strings must be non-zero */
> -	if (bank && *bank && device && *device)
> -		snprintf(dimm->label, sizeof(dimm->label), "%s %s", bank, device);
> +	snprintf(dimm->label, sizeof(dimm->label), "%s %s",
> +		 (bank && *bank) ? bank : "N/A",
> +		 (device && *device) ? device : "N/A");

The dimm->label buffer must be pre-initialized zero. This broke with:

 b9cae27728d1 EDAC/ghes: Scan the system once on driver init

since krealloc/krealloc_array() does not zero out the new allocated
buffer for struct dimm_info in enumerate_dimms(). This uninitialized
broken struct is then copied in ghes_edac_register() to the final
dimm_info destination. Originally, before b9cae27728d1, the struct was
zero initialized with kzalloc'ed by edac_mc_alloc() and directly used.
Now, that a copy is created first, this copy must be also zero
initialized.

IMO this is the proper fix:

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 59b0bedc9c24..3b5bf6502141 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -220,6 +220,7 @@ static void enumerate_dimms(const struct dmi_header *dh, void *arg)
 	}
 
 	d = &hw->dimms[hw->num_dimms];
+	memset(d, 0, sizeof(*d));
 	d->idx = hw->num_dimms;
 
 	assign_dmi_dimm_info(d, entry);


-Robert

>  }
