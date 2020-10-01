Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9962D280539
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbgJARaz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 13:30:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732407AbgJARaz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 1 Oct 2020 13:30:55 -0400
Received: from zn.tnic (p200300ec2f089d001daab592cfa658ec.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:9d00:1daa:b592:cfa6:58ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3469E1EC034B;
        Thu,  1 Oct 2020 19:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601573454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mINMhjqMRFURlWw8yOtlyf5CfMc+3HwvDNVyjD1JQm0=;
        b=PjEzcScajMIEVuegXTD6MlGND71UTp5GUt+FoH/ID7lsr3lcsNFGrOKfgnOQpHmD4X/+HR
        riVHQB4olz3vG1ZH3ZseaLv+tOjh7FIGv1nRaGEllt/+5K+kMzCiqUKpXIP6//ZFxWzqrQ
        W7AKhyPFgQjLUZVCxshFeu/R1vlkJVU=
Date:   Thu, 1 Oct 2020 19:30:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Message-ID: <20201001173052.GH17683@zn.tnic>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic>
 <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
 <20200909120203.GB12237@zn.tnic>
 <50714e083d55491a8ccf5ad847682d1e@huawei.com>
 <20200917084038.GE31960@zn.tnic>
 <91e71fe9-b002-0f1f-3237-62cea49e083a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91e71fe9-b002-0f1f-3237-62cea49e083a@arm.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 01, 2020 at 06:16:03PM +0100, James Morse wrote:
> If the corrected-count is available somewhere, can't this policy be
> made in user-space?

You mean rasdaemon goes and offlines CPUs when certain thresholds are
reached? Sure. It would be much more flexible too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
