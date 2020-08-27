Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC0254A80
	for <lists+linux-edac@lfdr.de>; Thu, 27 Aug 2020 18:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH0QTw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Aug 2020 12:19:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43576 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgH0QTw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 12:19:52 -0400
Received: from zn.tnic (p200300ec2f104500059e4b9a4804679d.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4500:59e:4b9a:4804:679d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D9791EC0423;
        Thu, 27 Aug 2020 18:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598545191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8QkVnkRzvDRQrZeUzmaDHT7ZWuqLDu370tFsz3uoBFk=;
        b=GhtCzp23m/8JrKlNe2AI+L5CSVBCovcFE+rSdbNl4qQvwW8E7FnRgZ0Erw+L1DLPjYArHB
        DwOaq0bqDxeRxZkmOs+1DhnUBCRyhzk1Bk9iwxBUHcD/oirjDG0Jh3JV/sSDxBkWIORIpT
        KVeILwGC2j5EK9F3KkFa0ROUSPuQ+Ss=
Date:   Thu, 27 Aug 2020 18:19:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linuxarm@huawei.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Message-ID: <20200827161952.GD30897@zn.tnic>
References: <20200827140450.1620-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827140450.1620-1-shiju.jose@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 27, 2020 at 03:04:50PM +0100, Shiju Jose wrote:
> After the 'commit b9cae27728d1 ("EDAC/ghes: Scan the system once on driver init")'
> applied, following error has occurred in the ghes_edac_register() when
> CONFIG_DEBUG_TEST_DRIVER_REMOVE is enabled. The null ghes_hw.dimms pointer
> in the mci_for_each_dimm() of ghes_edac_register() caused the error.
> 
> The error occurs when all the previously initialized ghes instances are
> removed and then probe a new ghes instance. In this case, the ghes_refcount
> would be 0, ghes_hw.dimms and mci already freed. The ghes_hw.dimms would
> be null because ghes_scan_system() would not call enumerate_dimms() again.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/ghes_edac.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Thanks, queued in edac-urgent.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
