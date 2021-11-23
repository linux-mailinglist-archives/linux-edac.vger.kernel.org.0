Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326F945AB63
	for <lists+linux-edac@lfdr.de>; Tue, 23 Nov 2021 19:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhKWSm6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Nov 2021 13:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239576AbhKWSm6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Nov 2021 13:42:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 942C960231;
        Tue, 23 Nov 2021 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637692790;
        bh=q3yTpI4Q0rJx+kU/+OTPxy33tA2d4yqHAfMRilwZMg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM9YMA72jOvSCzle+RHsGe4DSeO/VRQquvB0BUUj6TsPlARDrB2jOYUbK6SxyFpss
         rEMBwNXn7MF+4FdJDIBgNH11tPylm13nnsMu0+d4g37U1tCnK0jLUnmbt7aViBk1b4
         VEGVs6kVWTSnsjVxthzedxe995A5GvXWxXWRo2Y0=
Date:   Tue, 23 Nov 2021 19:39:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Tim Small <tim@buttersideup.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Douglas Thompson <dougthompson@xmission.com>
Subject: Re: [PATCH] EDAC/443bxgx: drop never enabled driver marked as broken
 for 14 years.
Message-ID: <YZ01c06kBc1yNqK2@kroah.com>
References: <20211123150646.47676-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123150646.47676-1-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 23, 2021 at 10:06:46AM -0500, Paul Gortmaker wrote:
> In commit 28f96eeafc89 ("drivers/edac-new-i82443bxgz-mc-driver: mark
> as broken") this driver got added "depends on BROKEN", indicating:
> 
>    It will claim the PCI devices from under intel_agp.ko's feet.
>    Greg is brewing some fix for that.

I have no idea what I was brewing up then :)

> That was 14 years ago.  It is safe to say that 99.9% of the original
> 440BX/GX chipset systems have long been retired anyway.  So there is no
> point in carrying around this driver any longer and making tree wide
> changes to it.
> 
> In fact, the driver was added in v2.6.23-rc1~321 and then marked broken
> in the following commit above - v2.6.23-rc1~320 and hence was never ever
> enabled in mainline to begin with.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Tim Small <tim@buttersideup.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Douglas Thompson <dougthompson@xmission.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks for the cleanup.

greg k-h
