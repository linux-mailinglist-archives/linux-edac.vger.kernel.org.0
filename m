Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB45387C6
	for <lists+linux-edac@lfdr.de>; Mon, 30 May 2022 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiE3Tfg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 May 2022 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiE3Tff (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 May 2022 15:35:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D727403D4;
        Mon, 30 May 2022 12:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1CA8B80EF5;
        Mon, 30 May 2022 19:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C0AC385B8;
        Mon, 30 May 2022 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653939331;
        bh=eijbhpTJ2B3JlcVU/XzMFj2+PLIBef38WosQNqTCfrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2OiJJm48j1Ovm1Iw5XFX7Lpl8jev4IHDuE4+pdi0xlYhRdnfkd+yEHVf/DDjnLHY
         Es3rfrST95gJYei1rlGgdtBu3MOrhTV6+HKayuKixhs+tJwiluiyObU8DE7JFvaNDY
         8vbExebiT7c90LgMJpIG4hQhdooOenpAyVgnVOxg=
Date:   Mon, 30 May 2022 21:35:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
Message-ID: <YpUcf19E+qgb6Eyu@kroah.com>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 30, 2022 at 12:16:24PM -0400, Mikulas Patocka wrote:
> Hi
> 
> The commit 7f99cb5e60392fc3494c610776e733b68784280c ("x86/CPU/AMD: Use 
> default_groups in kobj_type") causes the following warnings to be printed 
> during suspend to disk and resume from disk. There are many of these 
> warnings, 3 for each core.

And if you revert that change it goes back to not warning?

that is odd.

> 
> The machine is two six-core Opterons 8435.
> 
> Mikulas
> 
> 
> [   31.349584] PM: hibernation: hibernation entry
> [   31.350319] Filesystems sync: 0.000 seconds
> [   31.350417] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   31.351994] OOM killer disabled.
> [   31.357889] PM: hibernation: Preallocating image memory
> [   34.791852] PM: hibernation: Allocated 735563 pages for snapshot
> [   34.792065] PM: hibernation: Allocated 2942252 kbytes in 3.43 seconds (857.79 MB/s)
> [   34.792296] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> [   34.793791] printk: Suspending console(s) (use no_console_suspend to debug)
> [   34.795159] serial 00:03: disabled
> [   34.795248] serial 00:02: disabled
> [   34.824316] mptbase: ioc0: pci-suspend: pdev=0x00000000f4bc4e1a, slot=0000:02:06.0, Entering operating state [D3]
> [   35.470390] amdgpu 0000:07:00.0: amdgpu: BACO reset
> [   35.533783] Disabling non-boot CPUs ...
> [   35.535798] smpboot: CPU 1 is now offline
> [   35.537754] ------------[ cut here ]------------
> [   35.537764] kernfs: can not remove 'threshold_limit', no directory

Before you suspend, is this directory (and the other ones) really there?

Are they not getting created now properly somehow?  Any warning messages
at boot time?

thanks,

greg k-h
