Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ACA55CE80
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jun 2022 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiF0P4r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jun 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiF0P4q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jun 2022 11:56:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DE1AE;
        Mon, 27 Jun 2022 08:56:44 -0700 (PDT)
Received: from zn.tnic (p200300ea9746579d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:579d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 564D11EC0575;
        Mon, 27 Jun 2022 17:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656345398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VoABTwSKF7gRqkr32j5uM2qGN99CISEd1yVEqSoNc7Y=;
        b=hv+7aTQVwf922nutG/vKgAj84fx3xYCE1m9P7s0xwFgWhOA26aiMR9g1G+6q69/sFl/yeP
        Wq6vJ/lsdgelZWBP4VRqDkRufqPaTtGFXdtMfHlKsh4o8NYqE/FZn4c13p9Hu0M71k46T2
        sp+9moGItlx+vEwGq/z7OGae/YVwYyQ=
Date:   Mon, 27 Jun 2022 17:56:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YrnTMmwl5TrHwT9J@zn.tnic>
References: <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
 <YlflJfyQR/j/eRkn@zn.tnic>
 <YlmHtlKABn9W0pu5@yaz-ubuntu>
 <YlmfZU2Bg5cRk07J@agluck-desk3.sc.intel.com>
 <YqJHwXkg3Ny9fI3s@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqJHwXkg3Ny9fI3s@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 09, 2022 at 07:19:29PM +0000, Yazen Ghannam wrote:
> Also, please see the patch below which is based on Boris' patch from earlier
> in this thread.

Looks good to me. You can send me one against latest tip:ras/core
whenever you can.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
