Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89952C1726
	for <lists+linux-edac@lfdr.de>; Mon, 23 Nov 2020 22:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgKWUzB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Nov 2020 15:55:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47690 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgKWUzB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Nov 2020 15:55:01 -0500
Received: from zn.tnic (p200300ec2f0bbc004db97da25dfc8587.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bc00:4db9:7da2:5dfc:8587])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AF6F1EC0506;
        Mon, 23 Nov 2020 21:55:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606164900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eOxsNY7Er405uLXDsZt8H9k38WgOvAwa9tKguJYOqQo=;
        b=Ax4UYuaYggVY1jvgLuF6jrJBpT1tgAhDIW85bNQ/6QCQZ3cN4++42EfPZxl9NA5ijzQSq4
        93w4FOMIm5QyAEhJ8fxMWCoqR/qRzgwapgc/1bi3LdJ+DM0TuNvv11PX6BsAFl5PTPvsxe
        ISQpzkyf3WS135ypXyIwOz5T3MiLS2Y=
Date:   Mon, 23 Nov 2020 21:54:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, sachin.ghadi@sifive.com
Subject: Re: [PATCH 3/3] EDAC/sifive: Add support for SiFive BEU in SiFive
 platform EDAC
Message-ID: <20201123205453.GJ15044@zn.tnic>
References: <1605182457-86046-1-git-send-email-yash.shah@sifive.com>
 <1605182457-86046-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1605182457-86046-3-git-send-email-yash.shah@sifive.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 12, 2020 at 05:30:57PM +0530, Yash Shah wrote:
> Register for ECC error events from SiFive BEU in SiFive platform EDAC
> driver.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/edac/Kconfig       |  2 +-
>  drivers/edac/sifive_edac.c | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
