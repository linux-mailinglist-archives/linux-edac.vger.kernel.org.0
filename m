Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C66D678F
	for <lists+linux-edac@lfdr.de>; Tue,  4 Apr 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjDDPhS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Apr 2023 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjDDPhI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Apr 2023 11:37:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A27448F;
        Tue,  4 Apr 2023 08:36:47 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFCAB1EC0529;
        Tue,  4 Apr 2023 17:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680622600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2sPBGWr54kw4A2qEKLOZq6gkXB3eP7VzA6/tCd+AW20=;
        b=oBkj6A5fT8ySiQgv98D/jFVpT6KTJBURwchEloRkx8+74BagyFD94b+5/2gA/M+JqAm2F1
        iB973uHrvUpqzQADqUefFfsQrA9ix+brKRJdoIasP1amCoL25YiNEHIAjM0ysuPSsArfwK
        htCiJeGmyY+o6nRzjRmvkOjhd3W2DOE=
Date:   Tue, 4 Apr 2023 17:36:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     yazen.ghannam@amd.com, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] EDAC/amd64: clean up some inconsistent
 indentings
Message-ID: <20230404153640.GAZCxECKKfsQoYGM6p@fat_crate.local>
References: <20230404022557.46409-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404022557.46409-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 04, 2023 at 10:25:57AM +0800, Yang Li wrote:
> Use consistent indentation to improve the readability and eliminate
> the below warning:
> 
> drivers/edac/amd64_edac.c:1279 umc_determine_edac_cap() warn: inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4639
> Fixes: f6a4b4a1aa16 ("EDAC/amd64: Split determine_edac_cap() into dct/umc functions")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> change in v2:
> --According to yazen's suggestion, include a fixes tag and
>   describe the changes in the commit message
> 
>  drivers/edac/amd64_edac.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
