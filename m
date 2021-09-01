Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8234B3FDED6
	for <lists+linux-edac@lfdr.de>; Wed,  1 Sep 2021 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbhIAPlV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Sep 2021 11:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343746AbhIAPlU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Sep 2021 11:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630510823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5WinnYXvg2iYFpy0z2oAKoDwNk1Mt/0CpYI65fqO58k=;
        b=MToFF0kc/fK9VUDSAqIGsnHQjGwstj6tWmS0qvh1bGEMT4MqZfMRBwgFlSdGFWnYCtsAtB
        bB5pfUvfQMPdCDdrrZy5/b8K2hrFAUWds4LvqcYuDFipeqN/i7tyVSXaxh0x6wA4Jfmheq
        1gL1Pit0QsuA86++T8ybXRrEppCnjAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-LWUEAZCJPDWgAxZ0z7TwRw-1; Wed, 01 Sep 2021 11:40:22 -0400
X-MC-Unique: LWUEAZCJPDWgAxZ0z7TwRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C41CEFC80;
        Wed,  1 Sep 2021 15:40:19 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB32B6ACFF;
        Wed,  1 Sep 2021 15:40:08 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     dan.j.williams@intel.com
Cc:     David Hildenbrand <david@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch, v2] x86/pat: pass valid address to sanitize_phys()
References: <x49o8a3pu5i.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 01 Sep 2021 11:41:32 -0400
In-Reply-To: <x49o8a3pu5i.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Wed, 11 Aug 2021 17:07:37 -0400")
Message-ID: <x49zgswfglv.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Ping?

Jeff Moyer <jmoyer@redhat.com> writes:

> The end address passed to memtype_reserve() is handed directly to
> sanitize_phys().  However, end is exclusive and sanitize_phys() expects
> an inclusive address.  If end falls at the end of the physical address
> space, sanitize_phys() will return 0.  This can result in drivers
> failing to load, and the following warning:
>
> [    9.999440] mpt3sas version 29.100.01.00 loaded
> [    9.999817] mpt3sas_cm0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (65413664 kB)
> [    9.999819] ------------[ cut here ]------------
> [    9.999826] WARNING: CPU: 26 PID: 749 at arch/x86/mm/pat.c:354 reserve_memtype+0x262/0x450
> [    9.999828] reserve_memtype failed: [mem 0x3ffffff00000-0xffffffffffffffff], req uncached-minus
> [    9.999828] Modules linked in: mpt3sas(+) bnxt_en(+) ahci(+) crct10dif_pclmul crct10dif_common nvme crc32c_intel libahci nvme_core libata raid_class scsi_transport_sas devlink drm_panel_orientation_quirks nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod
> [    9.999840] CPU: 26 PID: 749 Comm: systemd-udevd Not tainted 3.10.0-1077.el7_7.mpt3sas_test008.x86_64 #1
> [    9.999842] Hardware name: Inspur SA5112M5/SA5112M5, BIOS 4.1.12 02/24/2021
> [    9.999843] Call Trace:
> [    9.999851]  [<ffffffffa497c4e4>] dump_stack+0x19/0x1b
> [    9.999857]  [<ffffffffa429bc08>] __warn+0xd8/0x100
> [    9.999859]  [<ffffffffa429bc8f>] warn_slowpath_fmt+0x5f/0x80
> [    9.999861]  [<ffffffffa427b1f2>] reserve_memtype+0x262/0x450
> [    9.999867]  [<ffffffffa4276254>] __ioremap_caller+0xf4/0x330
> [    9.999872]  [<ffffffffc04620a1>] ? mpt3sas_base_map_resources+0x151/0xa60 [mpt3sas]
> [    9.999875]  [<ffffffffa42764aa>] ioremap_nocache+0x1a/0x20
> [    9.999879]  [<ffffffffc04620a1>] mpt3sas_base_map_resources+0x151/0xa60 [mpt3sas]
> [    9.999884]  [<ffffffffa442656b>] ? __kmalloc+0x1eb/0x230
> [    9.999889]  [<ffffffffc0465555>] mpt3sas_base_attach+0xf5/0xa50 [mpt3sas]
> [    9.999894]  [<ffffffffc046af3c>] _scsih_probe+0x4ec/0xb00 [mpt3sas]
> [    9.999901]  [<ffffffffa45d297a>] local_pci_probe+0x4a/0xb0
> [    9.999903]  [<ffffffffa45d40c9>] pci_device_probe+0x109/0x160
> [    9.999909]  [<ffffffffa46b7225>] driver_probe_device+0xc5/0x3e0
> [    9.999910]  [<ffffffffa46b7623>] __driver_attach+0x93/0xa0
> [    9.999912]  [<ffffffffa46b7590>] ? __device_attach+0x50/0x50
> [    9.999914]  [<ffffffffa46b4dc5>] bus_for_each_dev+0x75/0xc0
> [    9.999916]  [<ffffffffa46b6b9e>] driver_attach+0x1e/0x20
> [    9.999918]  [<ffffffffa46b6640>] bus_add_driver+0x200/0x2d0
> [    9.999920]  [<ffffffffa46b7cb4>] driver_register+0x64/0xf0
> [    9.999922]  [<ffffffffa45d3905>] __pci_register_driver+0xa5/0xc0
> [    9.999924]  [<ffffffffc049b000>] ? 0xffffffffc049afff
> [    9.999928]  [<ffffffffc049b16e>] _mpt3sas_init+0x16e/0x1000 [mpt3sas]
> [    9.999933]  [<ffffffffa420210a>] do_one_initcall+0xba/0x240
> [    9.999940]  [<ffffffffa431e95a>] load_module+0x271a/0x2bb0
> [    9.999946]  [<ffffffffa45b0600>] ? ddebug_proc_write+0x100/0x100
> [    9.999948]  [<ffffffffa431eedf>] SyS_init_module+0xef/0x140
> [    9.999954]  [<ffffffffa498fed2>] system_call_fastpath+0x25/0x2a
> [    9.999955] ---[ end trace 6d6eea4438db89ef ]---
> [    9.999957] ioremap reserve_memtype failed -22
> [   10.000087] mpt3sas_cm0: unable to map adapter memory! or resource not found
> [   10.000334] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10597/_scsih_probe()!
>
> (Note that this warning was from an older distribution kernel, so line
> numbers and file names may not line up with the current tree.)
>
> Fix this by passing the inclusive end address to sanitize_phys().
>
> Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for "decoy" addresses")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> ---
> v2:
> - Add the warning splat to the commit log. (tglx)
> - Use parenthesis when referring to function names. (tglx)
> - Add a comment to the code. (tglx)
> - Use inclusive/exclusive instead of interval notation.
>
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 3112ca7786ed..4ba2a3ee4bce 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -583,7 +583,12 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>  	int err = 0;
>  
>  	start = sanitize_phys(start);
> -	end = sanitize_phys(end);
> +
> +	/*
> +	 * The end address passed into this function is exclusive, but
> +	 * sanitize_phys() expects an inclusive address.
> +	 */
> +	end = sanitize_phys(end - 1) + 1;
>  	if (start >= end) {
>  		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
>  				start, end - 1, cattr_name(req_type));

