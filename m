Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5461338E
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 11:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJaK04 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJaK0x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 06:26:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF94CDF83;
        Mon, 31 Oct 2022 03:26:51 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cf329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cf:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DF351EC0535;
        Mon, 31 Oct 2022 11:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667212010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E7+K2agDo3PWDiJqVGMFuc1n6P62g6uovokW/fknxaA=;
        b=Zk9hoPSpjGxLc164VkfRjc3kxF3H5rdM5S2OIk8Sm2KSIfuJ3RKiVpKzNYmGfHeTViGApG
        amin5PfneXFixhMrbpF8F+8UQ4rwNPUNZzpWdq8cpBNHEjkeSFJw/R9BEUjMzD4sktnPGs
        nzTzehkkbh1DZFK28+khZ7EQcOGLWok=
Date:   Mon, 31 Oct 2022 11:26:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Subject: Re: [PATCH] EDAC/mc_sysfs: Increase legacy channel support to 12
Message-ID: <Y1+i5GvygCVfiCGx@zn.tnic>
References: <20221018153630.14664-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018153630.14664-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 18, 2022 at 10:36:30AM -0500, Yazen Ghannam wrote:
> Newer AMD systems, such as Genoa, can support up to 12 channels per EDAC
> "mc" device. These are detected by the device's EDAC module, and the
> current EDAC interface is properly enumerated. However, the legacy EDAC
> sysfs interface provides device attributes only for channels 0 to 7.
> Therefore, channels 8 to 11 will not be visible in the legacy interface.
> This was overlooked in the initial support for AMD Genoa.
> 
> Add additional device attributes so that up to 12 channels are visible
> in the legacy EDAC sysfs interface.
> 
> Ignore checkpatch warnings about "Symbolic permissions" to maintain
> coding style.
> 
> Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
