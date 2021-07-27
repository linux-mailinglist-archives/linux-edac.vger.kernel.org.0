Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C33D72ED
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jul 2021 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhG0KSb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Jul 2021 06:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236103AbhG0KSb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Jul 2021 06:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 859E161529;
        Tue, 27 Jul 2021 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381111;
        bh=EsU+qCFwWudGSdUYDF/FwtEOQgFnErYkX1N5RwJjDgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbJ5ImVf1KlE/J+KCHNCo+dikc1a/FyoKOCxKqRcfu13y1oKPAl52pkWBsZn29kPf
         fRrTRQLjLjgYf73TyOzSeRmsakjNl41VPCklyHQqni9zhP7rqMiJx/tyiBUO86NpSk
         s/2zftIohPTYgW8/IpR/3xXG9CcDfk7uhES+4yLKZcSshrMxW5HWyJfXNlyqML9WdF
         h13nT7WCPJzgSjBgOU9kgRvDvBSSmo0C48Fu7IZiPtrmb6yMmdVNX/dkvp7SPKuteV
         OBvOdnSBrMjmp/sIRpSsdNWrqXMh5E6XVfClQx7bZj1eynh4cNZmaDuMt7p3w6ECQZ
         rWcQ4WSCHV3Kg==
Date:   Tue, 27 Jul 2021 12:18:23 +0200
From:   Robert Richter <rric@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Doug Thompson <dougthompson@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/edac: add missing macro arguments and missing
 macro edac_pci_remove_sysfs
Message-ID: <YP/db1lKhkVxmHRs@rric.localdomain>
References: <20210715135826.26241-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715135826.26241-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15.07.21 14:58:26, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The macros edac_pci_handle_pe and edac_pci_handle_npe are missing their
> arguments and don't match the function prototypes they replace. Also
> macro edac_pci_remove_sysfs is missing. Fix this by adding in the missing
> arguments and missing macro.
> 
> Fixes: d4c1465b7de9 ("drivers/edac: fix edac_pci sysfs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/edac_module.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
> index aa1f91688eb8..ed194ba2c207 100644
> --- a/drivers/edac/edac_module.h
> +++ b/drivers/edac/edac_module.h
> @@ -123,8 +123,9 @@ extern void edac_pci_handle_npe(struct edac_pci_ctl_info *pci,
>  #define edac_sysfs_pci_teardown()
>  #define edac_pci_get_check_errors()
>  #define edac_pci_get_poll_msec()
> -#define edac_pci_handle_pe()
> -#define edac_pci_handle_npe()
> +#define edac_pci_remove_sysfs(pci)
> +#define edac_pci_handle_pe(pci, msg)
> +#define edac_pci_handle_npe(pci, msg)

All drivers of those functions are guarded by CONFIG_PCI (all except
EDAC_MPC85XX by Kconfig dependency and for mpc85xx it is inline). Not
protected is only:

 drivers/edac/edac_module.c:     edac_pci_clear_parity_errors();
 drivers/edac/edac_pci.c:        edac_pci_remove_sysfs(pci);
 drivers/edac/edac_pci.c:        if (edac_pci_get_check_errors())
 drivers/edac/edac_pci.c:        msec = edac_pci_get_poll_msec();
 drivers/edac/edac_pci.c:                edac_queue_work(&pci->work, msecs_to_jiffies(edac_pci_get_poll_msec()));
 drivers/edac/edac_pci.c:        edac_pci_do_parity_check();

So instead of adding those stubs we should in fact remove the whole
!CONFIG_PCI part here, make edac_pci.c dependent on CONFIG_PCI too and
fix the use of edac_pci_clear_parity_errors() in modules.c which looks
wrong at this location anyway.

-Robert

>  #endif				/* CONFIG_PCI */
>  
>  #endif				/* __EDAC_MODULE_H__ */
> -- 
> 2.31.1
> 
