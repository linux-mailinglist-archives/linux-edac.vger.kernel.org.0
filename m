Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32958225A
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiG0IqL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiG0IqL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 04:46:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9362101C2;
        Wed, 27 Jul 2022 01:46:08 -0700 (PDT)
Received: from zn.tnic (p57969665.dip0.t-ipconnect.de [87.150.150.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6CA91EC064A;
        Wed, 27 Jul 2022 10:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658911562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=52YT4f2neETdfG32mraDwGLruVCe/2pjtd1VhSOaC/0=;
        b=Vn8aNrDhBbfOQkUVWZduL8uERb/KaEf9hlTAcS/86DfU3EDPg3fMqAJPILBdoKNzYJx0oC
        1gkuDw8YZPTAF7d1rYbGtbehx9KSfRBhiRE+hGy4MYOUyNDsYziPEcUGxZxwmTNpDfpdZF
        kGNPVyqUFjMNXyCNo5gUM3DXvTFDppI=
Date:   Wed, 27 Jul 2022 10:45:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     rric@kernel.org, mchehab@kernel.org, elliott@hpe.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/ghes: Set the DIMM label unconditionally
Message-ID: <YuD7RU7cdo5bnKmX@zn.tnic>
References: <20220726164628.1756924-1-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220726164628.1756924-1-toshi.kani@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 26, 2022 at 10:46:28AM -0600, Toshi Kani wrote:
> The following buffer overflow BUG was observed on an HPE system.
> ghes_edac_register() called strlen() on an uninitialized label,
> which had non-zero values from krealloc_array().

...

> Fixes: b9cae27728d1f ("EDAC/ghes: Scan the system once on driver init")
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Co-developed-by: Robert Richter <rric@kernel.org>
> Tested-by: Robert Elliott <elliott@hpe.com>
> ---
>  drivers/edac/ghes_edac.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Amended and pushed out.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
