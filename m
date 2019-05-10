Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD719F2F
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfEJOeT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 10:34:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfEJOeT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 May 2019 10:34:19 -0400
Received: from zn.tnic (p200300EC2F0F4000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D3FE1EC09A3;
        Fri, 10 May 2019 16:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557498857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C7+IBqexWMEpmbNKkcHjYer0PezJFxH8eIctfj9JsKQ=;
        b=saKkANIF8smkogjtdEzHVG5cCpmFn+8uNGWgXdVj+2Vco6/Ziz5lLYgWd1qJMpTofyJkN0
        BawLhz5CuCiz2s1MacwkA1RVDk9C5eTqdJVy+IdtTi0bsjX3bp/02aon6Ao09jc2FfA/9L
        5H/9cbxb6EObhdMwmP90jzzMivLIpI4=
Date:   Fri, 10 May 2019 16:34:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     mchehab@kernel.org, james.morse@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add Stratix10 OCRAM & SDMMC EDAC Support
Message-ID: <20190510143413.GC29927@zn.tnic>
References: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 23, 2019 at 09:36:33AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> This patch series adds EDAC support for the Stratix10 OCRAM
> and SDMMC peripherals.
> 
> Thor Thayer (4):
>   EDAC, altera: Add Stratix10 OCRAM ECC support
>   arm64: dts: stratix10: Add OCRAM EDAC node
>   EDAC, altera: Add Stratix10 SDMMC support
>   arm64: dts: stratix10: Add SDMMC EDAC node
> 
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  8 ++++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 11 ++++++
>  drivers/edac/altera_edac.c                         | 43 ++++++++++++++++++++--
>  3 files changed, 59 insertions(+), 3 deletions(-)
> 
> -- 

All 4 queued locally, will appear after -rc1 releases.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
