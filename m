Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7C1F95CB
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jun 2020 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgFOMAB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jun 2020 08:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOMAB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 Jun 2020 08:00:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2554C061A0E;
        Mon, 15 Jun 2020 05:00:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f063c0085fbd8d4455f52fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:85fb:d8d4:455f:52fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AC991EC0299;
        Mon, 15 Jun 2020 13:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592222399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4enB91kRD9rJWobEi4WugDt9+vQpQho4vn9V6hTQAw=;
        b=JbV+t55Xum04E2Lc3Yd19X2GBeJQla5k2LMCa4LhzY9G9XnpNrf9NjTCGZ3TrQ7c3tShef
        u1jPfBtFjWHXd1etGWGfRyR8cbkgV388pZtgVdZ5vOa7iCMhdqpiXEDFOq5qwjwXj/TFmi
        f6YgJN/7o7TQPUkScj8Hv353pzb3qAE=
Date:   Mon, 15 Jun 2020 13:59:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
Message-ID: <20200615115950.GG14668@zn.tnic>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200607043709.48178-1-hengqing.hu@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+ Yazen and linux-hwmon.

On Sun, Jun 07, 2020 at 12:37:07PM +0800, Jacky Hu wrote:
> This patchset adds MCA and EDAC support for AMD Family 17h, Model 60h.
> 
> Also k10temp works with 4800h
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:         1.55 V
> Vsoc:          1.55 V
> Tctl:         +49.6°C
> Tdie:         +49.6°C
> Icore:         0.00 A
> Isoc:          0.00 A
> 
> Jacky Hu (2):
>   x86/amd_nb: Add Family 17h, Model 60h PCI IDs
>   EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
> 
>  arch/x86/kernel/amd_nb.c  |  5 +++++
>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  drivers/hwmon/k10temp.c   |  2 ++
>  include/linux/pci_ids.h   |  1 +
>  5 files changed, 25 insertions(+)
> 
> -- 
> 2.27.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
