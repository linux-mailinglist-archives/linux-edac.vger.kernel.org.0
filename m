Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC74B4D59
	for <lists+linux-edac@lfdr.de>; Mon, 14 Feb 2022 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348935AbiBNKpB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 05:45:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbiBNKoy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 05:44:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5251674859;
        Mon, 14 Feb 2022 02:06:11 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B9271EC01A9;
        Mon, 14 Feb 2022 11:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644833165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aXPq0nLzHCwRfyUGulTT2l60daxEfBrJC63adKuy65o=;
        b=MjK8jxmnJXjN2XXB/H1U2Yk7OIDpTQ9Kc792Rjc72CJIbjXL8YKS0o85ObU98GqQc0GWRo
        Zr0zG5il9szYmsEztX0N5cbiLdB+1iSmGPvlTiAi41kzWpclF4bvfha6wvYGZTTcabXKiL
        Tw0j9UqkXuAkEe0JwiEh7DHMX2SlCmI=
Date:   Mon, 14 Feb 2022 11:06:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 08/24] EDAC/amd64: Define function to check DRAM limit
 address
Message-ID: <YgopjwgItEHPfFtF@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-9-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-9-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:59PM +0000, Yazen Ghannam wrote:
> Move the DRAM limit check into a separate helper function.

You're still writing the "what" in commit messages - pls make a note to
write about "why" you're doing a change instead.

Because I don't see why you're doing this. Because
umc_normaddr_to_sysaddr() is supposed to call helper functions only?

Now if you had the "why" I wouldn't be wondering...

:)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
