Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5FD4700BE
	for <lists+linux-edac@lfdr.de>; Fri, 10 Dec 2021 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhLJMh7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Dec 2021 07:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhLJMh7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Dec 2021 07:37:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18837C061746;
        Fri, 10 Dec 2021 04:34:24 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69A9C1EC0535;
        Fri, 10 Dec 2021 13:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639139657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jfyx8yNivL7PHlxA1P8iIYgkuecYK2mnYhE69iT2PYc=;
        b=MZ4k6ykulwss9wnSYaCKVp3oby/qsQhh9Tyu7yFQfCinjFEetF6GGsF7swX1T7eC1uuLWj
        AOF1SjTqMtOf+nSFDuT59AqMR0dLv3kRefjXr6Hqg+EeX+UefLPNeRaFP4gC6FN26/+RLa
        3vkPPrJcQWALW/sjYnWNog0VyIuK+GY=
Date:   Fri, 10 Dec 2021 13:34:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 3/4] EDAC/amd64: Check register values from all UMCs
Message-ID: <YbNJSyv4GdC+SUSD@zn.tnic>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
 <20211208174356.1997855-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208174356.1997855-4-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 08, 2021 at 05:43:55PM +0000, Yazen Ghannam wrote:
> Loop over all UMCs and create bitmasks to check the values of the
> DIMM_CFG and UMC_CFG registers rather than just checking the values from
> the first two UMCs.

Do not talk about what your patch does in the commit message - that
should hopefully be visible in the diff itself. Rather, talk about *why*
you're doing what you're doing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
