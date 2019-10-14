Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C44D66DC
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfJNQJL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 12:09:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbfJNQJL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 12:09:11 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2C391EC0C84;
        Mon, 14 Oct 2019 18:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571069350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mXJL7k8d93itpw2Epm3NBVCRmKBnJ6PfnLe2dfWuHO4=;
        b=DhuMtUFdFtMnvixXqgPx9BYpkA40oL9e0f6K1jhgwvbywuWFBOZoNoflJ+Gun6vHQXG2k0
        zHPJg3z5lgf27mtWPuiA7S76euVATpjzCbIEpTdSZ32ARkkxkyU+0rUd3V3y4W8s1onDD7
        t4IcQKFyLBi2gnGc7pqX+cNgi5+MvVI=
Date:   Mon, 14 Oct 2019 18:09:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: edac KASAN warning in experimental arm64 allmodconfig boot
Message-ID: <20191014160901.GE4715@zn.tnic>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 04:18:49PM +0100, John Garry wrote:
> Hi guys,
> 
> I'm experimenting by trying to boot an allmodconfig arm64 kernel, as
> mentioned here:
> https://lore.kernel.org/linux-arm-kernel/507325a3-030e-2843-0f46-7e18c60257de@huawei.com/
> 
> One thing that I noticed - it's hard to miss actually - is the amount of
> complaining from KASAN about the EDAC/ghes code. Maybe this is something I
> should not care about/red herring, or maybe something genuine. Let me know
> what you think.
> 
> The kernel is v5.4-rc3, and I raised the EDAC mc debug level to get extra
> debug prints.
> 
> Log below, Thanks,
> John
> Log snippet (I cut off after the first KASAN warning):
> 
> [   70.471011][    T1] random: get_random_u32 called from new_slab+0x360/0x698 with crng_init=0
> [   70.478671][    T1] [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x94110034/64/0/3/0]
> [   70.526585][    T1] EDAC DEBUG: edac_mc_alloc: allocating 3524 bytes for mci data (32 dimms, 32 csrows/channels)
> [   70.542013][    T1] EDAC DEBUG: ghes_edac_dmidecode: DIMM2: Registered-DDR4 size = 16384 MB(ECC)
> [   70.551044][    T1] EDAC DEBUG: ghes_edac_dmidecode:         type 26, detail 0x2080, width 72(total 64)
> [   70.559986][    T1] EDAC DEBUG: edac_mc_add_mc_with_groups:
> [   70.567082][    T1] EDAC DEBUG: edac_create_sysfs_mci_device: device mc0 created
> [   70.575608][    T1] EDAC DEBUG: edac_create_dimm_object: device dimm2 created at location memory 2
> [   70.585818][    T1] EDAC DEBUG: edac_create_csrow_object: device csrow2 created
> [   70.594110][    T1] EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
> [   70.605936][    T1] EDAC DEBUG: edac_mc_del_mc:
> [   70.611188][    T1] EDAC DEBUG: edac_remove_sysfs_mci_device:
> [   70.619443][    T1] random: get_random_u32 called from kobject_put+0x8c/0x190 with crng_init=0
> [   70.628163][    T1] kobject: 'csrow2' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 750)
> [   70.638477][    T1] EDAC DEBUG: edac_remove_sysfs_mci_device: unregistering device dimm2
> [   70.647903][    T1] kobject: 'dimm2' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 250)
> [   70.658105][    T1] EDAC MC: Removed device 0 for ghes_edac.c ghes_edac: DEV ghes
> [   70.665673][    T1] EDAC DEBUG: edac_mc_free:
> [   70.670211][    T1] EDAC DEBUG: edac_unregister_sysfs: unregistering device mc0
> [   70.679027][    T1] kobject: 'mc0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 500)
> [   70.690987][    T1] EDAC DEBUG: edac_mc_del_mc:
> [   70.695769][    T1] EDAC DEBUG: edac_mc_free:
> [   70.700412][    T1] ------------[ cut here ]------------
> [   70.705832][    T1] ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x48
> [   70.716663][    T1] WARNING: CPU: 50 PID: 1 at lib/debugobjects.c:484 debug_print_object+0xec/0x130

If I am parsing these unwrapped messages correctly (btw, pls use another
mail client for pasting log lines - thunderbird is usually ok but I
guess you need to configure it properly), that must be some workqueue
object of sorts.

Now, ghes_edac doesn't init the workqueue:

[   70.594110][    T1] EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)

as it is in interrupt mode.

So the only other workqueue I see is that "delayed XXX" stuff which is in
kobject_release().

AFAICT.

Do you have CONFIG_DEBUG_KOBJECT_RELEASE enabled and if so, does the
warning go away if you disable it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
