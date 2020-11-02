Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A850D2A3444
	for <lists+linux-edac@lfdr.de>; Mon,  2 Nov 2020 20:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgKBTiH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Nov 2020 14:38:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgKBTiG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 2 Nov 2020 14:38:06 -0500
Received: from zn.tnic (p200300ec2f086a00baffd5cf7a666694.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:baff:d5cf:7a66:6694])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44D171EC026D;
        Mon,  2 Nov 2020 20:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604345885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V/Ai7BjSsO5yxLEsYXa5ZAcD1maTaWRrHOQLLmxUXNU=;
        b=kJntBVhjuJ2JVZsvE6L2dUVU9txoznAlgXWy4y1vnXdjusgfW5MIxUWcEPRrizq6DdOvGx
        toppOXFNnzH7bqvCAfOHq5W3A6eckyabuAKCd4Ba1dEB274PEfJXfqIftRDL0X99khSfpG
        aYRLBHJ6uEWbQV6wzfV7ke7kfMajHxo=
Date:   Mon, 2 Nov 2020 20:37:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/56] EDAC: fix some kernel-doc markups
Message-ID: <20201102193755.GH15392@zn.tnic>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <1d291393ba58c7b80908a3fedf02d2f53921ffe9.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d291393ba58c7b80908a3fedf02d2f53921ffe9.1603469755.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 23, 2020 at 06:32:57PM +0200, Mauro Carvalho Chehab wrote:
> Kernel-doc markup should use this format:
>         identifier - description
> 
> Also, some enums are using wrong names at the kernel-doc
> markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/edac/edac_device.h | 11 +++++------
>  include/linux/edac.h       |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
