Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528E92590A3
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgIAOfu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 10:35:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgIAOfn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Sep 2020 10:35:43 -0400
Received: from zn.tnic (p200300ec2f111c00f0e9a36004a82e59.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1c00:f0e9:a360:4a8:2e59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C2721EC00EC;
        Tue,  1 Sep 2020 16:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598970938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W/JjlPkr56envneKc3L1P/Ow3k/grlx00YCQ6+YN6bg=;
        b=abXJBU2J4S5SacLtZDga/ty8nkt15z0PcR3rPQlsoWywTj6Vdp1ODsbYvriCt5eH7K3rA+
        /RuhpFcuV4oSFc6Dl0m2urbBNH76GW74iPRzcs00L3lnkoSdR4k4ODPyyuUcQ2/jszk02L
        WJRxfrOe0y8ZAzSYnE4QKDKCQN7F19M=
Date:   Tue, 1 Sep 2020 16:35:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        rjw@rjwysocki.net, james.morse@arm.com, lenb@kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Message-ID: <20200901143539.GC8392@zn.tnic>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901140140.1772-1-shiju.jose@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 01, 2020 at 03:01:40PM +0100, Shiju Jose wrote:
> When the CPU correctable errors reported on an ARM64 CPU core too often,
> it should be isolated. Add the CPU correctable error collector to
> store the CPU correctable error count.
> 
> When the correctable error count for a CPU exceed the threshold
> value in a short time period, it will try to isolate the CPU core.
> The threshold value, time period etc are configurable.
> 
> Implementation details is added in the file.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/ABI/testing/debugfs-cpu-cec |  22 ++
>  arch/arm64/ras/Kconfig                    |   8 +
>  drivers/acpi/apei/ghes.c                  |  30 +-
>  drivers/ras/Kconfig                       |   1 +
>  drivers/ras/Makefile                      |   1 +
>  drivers/ras/cpu_cec.c                     | 393 ++++++++++++++++++++++

So instead of adding the ability to collect other error types to the
CEC, you're duplicating the CEC itself?!

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
