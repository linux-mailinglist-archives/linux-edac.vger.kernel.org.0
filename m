Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365957D63EE
	for <lists+linux-edac@lfdr.de>; Wed, 25 Oct 2023 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjJYHtI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Oct 2023 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJYHtA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Oct 2023 03:49:00 -0400
X-Greylist: delayed 80520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 00:48:13 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D837D43
        for <linux-edac@vger.kernel.org>; Wed, 25 Oct 2023 00:48:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6DFF40E01B1;
        Wed, 25 Oct 2023 07:48:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KAtJL9cQPBec; Wed, 25 Oct 2023 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698220089; bh=hxm/WTl8KOdQQA/wAFeOPK0hoiuC0DenxxTHxjFCxmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJs05RhE7SrlKG+btkQcqbIcJQvlDhg9CMLxIIATluqULQ0+UvcBrL71T+6Lc4Ae5
         viyfz22NehegwH4E1FchxJOgnws2kzgYsvEptPqwc2HNM51bLWaPX3XIhweKYG6nrS
         sqcIaJ+99ImZwS9Zn8vgxuBD47peTaqmHDgGPLv6hq8JQY2mT1mfHgwf2OQ0AglEl+
         ybYlG/j4ilwN+qEYWNzyy+qZjA2bIQtvccJkhhqM5kzNm2IUUQlfZx/y4ouBqcqPFe
         hmbvJUGwqHyfUXRb8Q3mWqe0JwfCrCLcV+ukeRmzHeQzEM4E6JYAI8oThF/55A1/gd
         0Vc4kq3DFhVXfEozT7cOme2/18T4fjJLDs5xiPuQr3CcduPXug0PaFnTnn8wWl4bGX
         JgEPWhO+SL74jYZ4KNFOOFUXiS2Oq/drTcdVLntoauc4AmQsVppaAgf3TEluDFjaZh
         wzJwKUm+a62u/QLv4r03vao0VIkJ8Uship3ciBsMSGN9wKenPprXuxIfA1is5fSTbj
         +DjRKyPjsS9mrFNMVkpppEuZN9JdspqI8cspflUjgN0AkTE06XZxKBpWn5YNMvpI9v
         8d5Oq2NHDUEBj51s5L+wgKFy2cc44IiXnM+NhZ/s+FeJZ3UwQrfSur6SxDFXnHdtmX
         F8MWZhq2yv8KzdNu0oO6hAmk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0096940E014B;
        Wed, 25 Oct 2023 07:48:05 +0000 (UTC)
Date:   Wed, 25 Oct 2023 09:48:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-edac@vger.kernel.org
Subject: Re: [bug report] x86/mce: Mark fatal MCE's page as poison to avoid
 panic in the kdump kernel
Message-ID: <20231025074804.GBZTjINPXkFlpfgwV8@fat_crate.local>
References: <12eb6db6-bc24-4e7c-af34-a5c68d49d52a@moroto.mountain>
 <fe7d6f43-2a10-4c73-be5b-d0702d0d89c8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe7d6f43-2a10-4c73-be5b-d0702d0d89c8@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 25, 2023 at 02:19:26PM +0800, Zhiquan Li wrote:
> +                       if (final && (final->status & MCI_STATUS_ADDRV))
> +                               p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
> +                               if (p)
> +                                       SetPageHWPoison(p);
> 
> The assignment can not be put into the "if" condition, checkpatch.pl script
> will complain it.

It doesn't complain here:

$ git diff | ./scripts/checkpatch.pl 
total: 0 errors, 0 warnings, 14 lines checked

Your patch has no obvious style problems and is ready for submission

> I'll re-validate the patch and send V5 soon.

When you do, please send it with my edits to the text.

Zapped from tip for now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
