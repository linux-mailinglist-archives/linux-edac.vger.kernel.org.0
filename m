Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8722A3965B2
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhEaQpZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhEaQnX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 12:43:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3526C053A09
        for <linux-edac@vger.kernel.org>; Mon, 31 May 2021 08:05:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f080f002c54d32600da041e.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:2c54:d326:da:41e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71ADF1EC04DE;
        Mon, 31 May 2021 17:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622473510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UkzFANFQtQbvHOCkSdinM8TxCtsswQGkShM6HDIdWpw=;
        b=OhZwPS4XrsaRlocKjxCEqulTjVevFAHJ1n4oYZs1PlMky2rq/25jCUMmU6ufNxJOnvnAoK
        6O/HG+wOwcYWJbN8th3wi47KPrK7e1hVcWIzx1vWhxxIbhKZEeX163aQa/igQ5Koe5R4VR
        nUMZ/AHlrq9fN7Sp2E8zgRDe3N0agjA=
Date:   Mon, 31 May 2021 17:05:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC, mellanox: Remove redundant error printing in
 bluefield_edac_mc_probe()
Message-ID: <YLT7JOR3fND5Y3K2@zn.tnic>
References: <20210511121856.5996-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210511121856.5996-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 11, 2021 at 08:18:56PM +0800, Zhen Lei wrote:
> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource().

In every possible failure case or is there a case where an error won't
be printed and keeping the dev_err() in the driver doesn't hurt at all?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
